import boto3

# Create EC2 client
ec2 = boto3.client('ec2', region_name='us-east-1')

def delete_old_snapshots():
    # Retrieve all snapshots
    snapshots = ec2.describe_snapshots(OwnerIds=['self'])['Snapshots']
    
    # Group by volume, sort by StartTime, and delete all but the last 2
    for volume_id, snaps in group_snapshots(snapshots).items():
        for snap in sorted(snaps, key=lambda x: x['StartTime'], reverse=True)[2:]:
            try:
                ec2.delete_snapshot(SnapshotId=snap['SnapshotId'])
                print(f"Deleted snapshot {snap['SnapshotId']} for volume {volume_id}")
            except Exception as e:
                print(f"Error deleting snapshot {snap['SnapshotId']}: {e}")

def group_snapshots(snapshots):
    groups = {}
    for snap in snapshots:
        groups.setdefault(snap['VolumeId'], []).append(snap)
    return groups

# Call the function to delete old snapshots
delete_old_snapshots()
