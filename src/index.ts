import { APIGatewayProxyEvent, APIGatewayProxyResult } from "aws-lambda";

export const handler = (event: APIGatewayProxyEvent): APIGatewayProxyResult => {
  return {
    statusCode: 200,
    body: ""
  };
};
