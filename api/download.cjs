'use strict';

const { S3Client, GetObjectCommand } = require("@aws-sdk/client-s3")
const { STSClient, AssumeRoleCommand } = require("@aws-sdk/client-sts")
const { getSignedUrl } = require("@aws-sdk/s3-request-presigner");

const REGION = process.env.AWS_REGION
const BUCKET = process.env.BUCKET

module.exports.handler = async (event) => {

  console.log(event)

  const stsparams = {
    RoleArn: process.env.ROLE,
    RoleSessionName: "download_"+event['requestId'],
    DurationSeconds: 900,
  } 

  console.log(process.env.ROLE)

  const stsClient = new STSClient({ region: REGION });

  const data = await stsClient.send(new AssumeRoleCommand(stsparams));

  console.log("data"+data)

  const rolecreds = {
    accessKeyId: data.Credentials.AccessKeyId,
    secretAccessKey: data.Credentials.SecretAccessKey,
    sessionToken: data.Credentials.SessionToken,
  };

  console.log("credential recuperas com sucesso.")

  const expires = 60 * 100;
  
  const fileName = event['queryStringParameters']['file'] 
  const getObjectParams = {
    Bucket: BUCKET,
    Key: fileName,
    Expires: expires
  }
  
  console.log("gerando signed url.")

  const s3Client = new S3Client({ region: REGION, credentials: rolecreds });
  const command = new GetObjectCommand(getObjectParams);
  const url = await getSignedUrl(s3Client, command, { expiresIn: 900 });

  console.log("retornando signed url.")
  
  return {
    statusCode: 200,
    body: JSON.stringify({ url: url })
  }
}
