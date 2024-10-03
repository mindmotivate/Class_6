import boto3

# Specify the AWS region and AZ
region_name = 'us-east-1'  # Change this to your desired region
availability_zone = 'us-east-1a'  # Change this to your desired AZ

# Create an EC2 client
ec2_client = boto3.client('ec2', region_name=region_name)

def create_snapshot(volume_id):
    try:
        # Create the snapshot
        response = ec2_client.create_snapshot(
            VolumeId=volume_id,
            TagSpecifications=[
                {
                    'ResourceType': 'snapshot',
                    'Tags': [
                        {
                            'Key': 'Environment',
                            'Value': 'prod'
                        },
                    ]
                }
            ]
        )
        print(f"Created snapshot {response['SnapshotId']} for volume {volume_id} with tag 'prod'.")
    except Exception as e:
        print(f"Error creating snapshot for volume {volume_id}: {e}")

def main():
    # Retrieve all volumes owned by the user
    response = ec2_client.describe_volumes()
    volumes = response['Volumes']

    # Filter volumes by the specified AZ
    for volume in volumes:
        if volume['AvailabilityZone'] == availability_zone:
            create_snapshot(volume['VolumeId'])

if __name__ == '__main__':
    main()
