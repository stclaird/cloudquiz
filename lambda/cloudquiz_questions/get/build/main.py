"""Deliver questions to API gateway"""
import json
import boto3
from boto3.dynamodb.conditions import Key
from botocore.exceptions import ClientError

def lambda_handler(event, context):
    """Retrieve set of questions and return them in json format"""
    try:
        category = event["queryStringParameters"]["category"]

        try:
            #Dynamo DB connection
            conn = boto3.resource('dynamodb', region_name="eu-west-2")
            table = conn.Table("cloudquiz-questions")
            questions = table.query(
                KeyConditionExpression=Key('category').eq(category) & Key('id').gt(0)
            )
            items = (questions["Items"])
            for item in items:
                item["id"] = str(item["id"])
            body = json.dumps(items)
        except ClientError as err:
            error = "Unable to fetch results {}".format(err)
            body = json.dumps({"response": error})
    except KeyError:
        body = json.dumps({"response": "No Category Supplied"})

    response = {"statusCode": 200,
                "headers": {'Content-Type': 'application/json',
                            'Access-Control-Allow-Origin': '*'},
                'body' : body
               }

    return response
