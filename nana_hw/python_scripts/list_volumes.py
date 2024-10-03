import boto3
import json

# Create an EC2 client
ec2_client = boto3.client('ec2', region_name='us-east-1')

# Fetch the volumes
volumes = ec2_client.describe_volumes()

# Filter volumes for a specific us-east-1 availability zone
filtered_volumes = [
    volume for volume in volumes['Volumes'] if volume['AvailabilityZone'] == 'us-east-1e'
]

# Make the JSON output readable
formatted_output = json.dumps(filtered_volumes, indent=4, default=str)

# Print the formatted output
print(formatted_output)

# Print the raw volume list
# print(volumes['Volumes'])
