import boto3


def lambda_handler(event, context):
    ec2 = boto3.resource('ec2')

    # Filtering instances by their tags
    runningInstancesFilter = [
        {
            'Name': 'tag:poweroff',
            'Values': ['true']
        },
        {
            'Name': 'tag:system',
            'Values': ['unitetech']
        },
        {
            'Name': 'instance-state-name',
            'Values': ['running']
        }
    ]

    getInstances = ec2.instances.filter(Filters=runningInstancesFilter)

    # List comprehension to export instances ids
    instances = [instance.id for instance in getInstances]

    if instances:
        try:
            ec2.instances.filter(InstanceIds=instances).stop()
            print(f'Powered off Instances: {instances}')

            return
        
        except Exception as erro:
            print(f'Couldnt Poweroff the Instances: {erro}')

            return

    print('None Existent Instances to Poweroff')

    return
