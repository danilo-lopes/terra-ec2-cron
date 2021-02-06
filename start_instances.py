import boto3


def lambda_handler(event, context):
    ec2 = boto3.resource('ec2')

    # Filtering instances by their tags
    stoppedInstancesFilter = [
        {
            'Name': 'tag:poweron',
            'Values': ['true']
        },
        {
            'Name': 'tag:system',
            'Values': ['unitetech']
        },
        {
            'Name': 'instance-state-name',
            'Values': ['stopped']
        }
    ]

    getInstances = ec2.instances.filter(Filters=stoppedInstancesFilter)

    # List comprehension to export instances ids
    instances = [instance.id for instance in getInstances]

    if instances:
        try:
            ec2.instances.filter(InstanceIds=instances).start()
            print(f'Powered on Instances: {instances}')

            return
        
        except Exception as erro:
            print(f'Couldnt Poweron the Instances: {erro}')

            return

    print('None Existent Instances to Poweron')

    return
