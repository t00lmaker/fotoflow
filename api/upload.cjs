'use strict';

const { S3Client, PutObjectCommand } = require("@aws-sdk/client-s3")
const parseMultipart = require('parse-multipart');
 
const REGION = process.env.AWS_REGION
const BUCKET = process.env.BUCKET

const s3 = new S3Client({ region: REGION })

module.exports.handler = async (event) => {

  console.log(event)
  
  try {
    const { filename, data } = extractFile(event)
    await   s3.send(new PutObjectCommand({ 
      Bucket: BUCKET, 
      Key: filename, 
      ACL: 'public-read', 
      Body: data 
    }))
 
    return {
      statusCode: 200,
      body: JSON.stringify({ link: `https://${BUCKET}.s3.amazonaws.com/${filename}` })
    }
  } catch (err) {
    return {
      statusCode: 500,
      body: JSON.stringify({ message: err.stack })
    }
  }
}
 
function extractFile(event) {
  const boundary = parseMultipart.getBoundary(event.headers['content-type'])
  const parts = parseMultipart.Parse(Buffer.from(event.body, 'base64'), boundary);
  const [{ filename, data }] = parts
 
  return {
    filename,
    data
  }
}
