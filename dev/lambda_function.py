import urllib.parse
import boto3

s3 = boto3.client('s3')

def lambda_handler(event, context):
    print("EVENT:", event)

    bucket = event['Records'][0]['s3']['bucket']['name']
    key = urllib.parse.unquote_plus(
        event['Records'][0]['s3']['object']['key'], encoding='utf-8'
    )

    print("Bucket:", bucket)
    print("Key:", key)

    response = s3.get_object(Bucket=bucket, Key=key)
    print("Got object")

    data = []
    for line in response["Body"].read().splitlines():
        data.append(line.decode('utf-8').replace('*', '#'))

    new_key = "output/output.txt"   # ✅ put in a folder
    s3.put_object(
        Bucket=bucket,
        Key=new_key,
        Body="\n".join(data)
    )

    print("File written:", new_key)
