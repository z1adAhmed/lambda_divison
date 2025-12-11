def lambda_handler(event, context):
    print("Hya")
    return {
        "statusCode": 200,
        "body": "Hello World"
    }
