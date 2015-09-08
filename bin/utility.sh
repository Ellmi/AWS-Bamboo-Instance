function create_stack {
    stackName=$1
    templateBody=$2
    parameters=$3

    aws cloudformation create-stack --stack-name ${stackName} --template-body ${templateBody} --parameters ${parameters} --capabilities CAPABILITI_IMG
}