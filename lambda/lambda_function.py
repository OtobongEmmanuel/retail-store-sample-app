import json

def lambda_handler(event, context):
    print("File uploaded to S3")
    print(json.dumps(event))

    return {
        "statusCode": 200,
        "body": "success"
    }
