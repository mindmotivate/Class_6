import boto3

# Create an EC2 client
ec2_client = boto3.client('ec2', region_name='us-east-1')

# Specify the Availability Zone you want to filter by
availability_zone = 'us-east-1e'

# Fetch the volumes in the specified AZ
response = ec2_client.describe_volumes(
    Filters=[{'Name': 'availability-zone', 'Values': [availability_zone]}]
)

# Iterate through the filtered volumes and create snapshots
for volume in response['Volumes']:
    new_snapshot = ec2_client.create_snapshot(VolumeId=volume['VolumeId'])
    print(f"Snapshot created for volume {volume['VolumeId']} in {availability_zone} with Snapshot ID: {new_snapshot['SnapshotId']}")
