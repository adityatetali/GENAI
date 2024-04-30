


import json 
import logging 
import os

import boto3
from botocore.exceptions import ClientError

logger = logging-getLogger ()
logger.setLevel(logging.INFO)

def handler (event, context):
    print ("Boto3 version:", boto3.__version__)
    region = os.environ['AWS_REGION']

    # Initialize the Amazon Bedrock runtime client
    client = boto3. client(
    service_name="bedrock-runtime", region_name="us-east-1"
    )
    s3_client = boto3.client("s3")

    try:
        s3_bucket_name = event["Records"][0]["s3"] ["bucket"]["name"]
        s3_file_name = event ["Records"] [0]["s3" ]["object"]["key"]

        object = s3_client.get_object(Bucket=s3_bucket_name, Key=s3_file_name)
        body = object['Body'].read().decode('utf-8')
        prompt = json.loads(body)["prompt"]
    except Exception as err:
        logger.error (err)
        prompt = "I did not get the prompt. Please come up with a joke about Mule to Spring migration."

    model_id = "anthropic.claude-3-sonnet-20240229-v1:0"

    try:
        response = client.invoke_model(
            modelId=model_id,
            body=json.dumps(
                {
                    "anthropic version": "bedrock-2023-05-31",
                    "max_tokens": 1024,
                    "messages": [
                        {
                        "role": "user",
                        "content": [{"type": "text", "text": prompt}],
                        }
                    ],
                }
            ),
        )

        
        # Process and print the response
        result = json.loads(response.get("body").read())
        input_tokens = result["usage"]["input_tokens"]
        output_tokens = result ["usage"]["output_tokens"]
        output_list = result. get("content", [])

        logger. info("Invocation details:")
        logger.info(f"- The input length is {input_tokens} tokens.") 
        logger.info(f"- The output length is {output_tokens} tokens. ")

        logger.info(f"- The model returned {len(output_list)} response(s):")
        for output in output_list:
            logger.info(output ["text"])

        return result
    
    except ClientError as err:
        logger. error (
            "Couldn't invoke Claude 3 Sonnet. Here's why: %s: %s",
             err.response["Error" ]["Code"], 
             err.response["Error" ]["Message"],
        )
        return ""