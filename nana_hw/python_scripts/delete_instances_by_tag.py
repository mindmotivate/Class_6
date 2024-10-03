import boto3

# Specify the AWS region
region_name = 'us-east-1'  # Change this to your desired region

# Create an EC2 client
ec2_client = boto3.client('ec2', region_name=region_name)

def delete_prod_instances():
    # Retrieve all instances in the specified region
    response = ec2_client.describe_instances()
    
    # List to hold instance IDs for deletion
    instances_to_delete = []

    # Filter instances by tag
    for reservation in response['Reservations']:
        for instance in reservation['Instances']:
            # Check for the 'prod' tag
            tags = instance.get('Tags', [])
            if any(tag['Key'] == 'Name' and tag['Value'] == 'prod' for tag in tags):
                instances_to_delete.append(instance['InstanceId'])

    # Delete instances if any found
    if instances_to_delete:
        ec2_client.terminate_instances(InstanceIds=instances_to_delete)
        print(f"Deleted instances: {instances_to_delete}")
    else:
        print("No instances found with 'prod' tag.")

if __name__ == '__main__':
    delete_prod_instances()