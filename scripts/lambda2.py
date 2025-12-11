def lambda_handler(event, context):
    print("yay")
    return {
        "statusCode": 200,
        "body": "Hello World"
    }
