import boto3
import schedule
import time

def create_volume_snapshots():
    # Create EC2 client
    ec2_client = boto3.client('ec2', region_name='us-east-1')

    # Specify the Availability Zone you want to filter by
    availability_zone = 'us-east-1e'

    # Describe volumes in the specified AZ
    volumes = ec2_client.describe_volumes(
        Filters=[{'Name': 'availability-zone', 'Values': [availability_zone]}]
    )

    for volume in volumes['Volumes']:
        # Create a snapshot for each volume
        new_snapshot = ec2_client.create_snapshot(VolumeId=volume['VolumeId'])
        print(f"Snapshot created for volume {volume['VolumeId']} with Snapshot ID: {new_snapshot['SnapshotId']}")

# Uncomment the line below to run the function every 10 seconds for testing
schedule.every(60).seconds.do(create_volume_snapshots)

# Schedule the function to run daily at a specific time (uncomment this line for daily execution)
# schedule.every().day.at("02:00").do(create_volume_snapshots)  # Set to run daily at 2:00 AM

# Keep the script running
while True:
    schedule.run_pending()
    time.sleep(1)  # Wait for 1 second before checking again
