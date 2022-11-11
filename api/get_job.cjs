'use strict';

const { DynamoDBDocumentClient } = require("@aws-sdk/lib-dynamodb");
const { DynamoDBClient } = require("@aws-sdk/client-dynamodb");
const { GetCommand } = require("@aws-sdk/lib-dynamodb");
const { v4: uuidv4} = require('uuid');

const REGION = process.env.AWS_REGION
const JOBS_TABLE = process.env.JOBS_TABLE

module.exports.handler = async (event) => {

  console.log(event)

  const jobId = event['queryStringParameters']['jobId'] 

  const ddbClient = new DynamoDBClient({ region: REGION });

  const params = {
    TableName: JOBS_TABLE,
    Key: {
      id: jobId
    }
  };

  try {
    const data = await ddbDocClient(ddbClient).send(new GetCommand(params));
    console.log("Success - item returned", data);

    return {
      statusCode: 200,      
      body: JSON.stringify(data.Item)
    }
  } catch (err) {
    console.log("Error", err.stack);
  }
}


function ddbDocClient(ddbClient){
  const marshallOptions = {
    // Whether to automatically convert empty strings, blobs, and sets to `null`.
    convertEmptyValues: false, // false, by default.
    // Whether to remove undefined values while marshalling.
    removeUndefinedValues: false, // false, by default.
    // Whether to convert typeof object to map attribute.
    convertClassInstanceToMap: false, // false, by default.
  };
  
  const unmarshallOptions = {
    // Whether to return numbers as a string instead of converting them to native JavaScript numbers.
    wrapNumbers: false, // false, by default.
  };
  
  const translateConfig = { marshallOptions, unmarshallOptions };
  
  // Create the DynamoDB document client.
  const ddbDocClient = DynamoDBDocumentClient.from(ddbClient, translateConfig);
  
  return ddbDocClient;
}
 
