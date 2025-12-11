def lambda_handler(event, context):
    print("de")
    return {
        "statusCode": 200,
        "body": "Hello World"
    }
