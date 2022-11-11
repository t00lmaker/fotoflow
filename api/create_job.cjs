'use strict';

const { DynamoDBDocumentClient } = require("@aws-sdk/lib-dynamodb");
const { DynamoDBClient } = require("@aws-sdk/client-dynamodb");
const { PutCommand } = require("@aws-sdk/lib-dynamodb");
const { v4: uuidv4} = require('uuid');

const REGION = process.env.AWS_REGION
const JOBS_TABLE = process.env.JOBS_TABLE

module.exports.handler = async (event) => {

  console.log(event)

  const body = JSON.parse(event.body)

  const ddbClient = new DynamoDBClient({ region: REGION });

  const params = {
    TableName: JOBS_TABLE,
    Item: {
      id: uuidv4(),
      name: body.name,
      description: body.description  
    },
  };

  try {
    const data = await ddbDocClient(ddbClient).send(new PutCommand(params));
    console.log("Success - item added or updated", data);

    return {
      statusCode: 201,      
      body: JSON.stringify(data)
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
 
