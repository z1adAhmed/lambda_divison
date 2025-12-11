def lambda_handler(event, context):
    print("Good")
    return {
        "statusCode": 200,
        "body": "Hello World"
    }
