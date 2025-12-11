def lambda_handler(event, context):
    print("hya?")
    return {
        "statusCode": 200,
        "body": "Hello World"
    }
