'use strict';

const AWS = require('aws-sdk');
 
const BUCKET = process.env.BUCKET;
 
const s3 = new AWS.S3();
 
module.exports.handler = async (event) => {

  console.log(event)

  const file = 'heroku-recovery-codes.txt'

  const expires = 60 * 100

  const url = s3.getSignedUrl('getObject', {
    Bucket: BUCKET,
    Key: file,
    Expires: expires
  });

  return {
    statusCode: 200,
    body: JSON.stringify({ url: url })
  }
}
