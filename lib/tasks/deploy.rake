require 'json'

namespace :master do
  NOT_EXIST = 'NOT_EXIST'
  stack_name = 'aws-bamboo-master'

  desc 'create or update bamboo master stack'
  task :create do
    template = 'file://aws/master/bamboo-template.json'
    parameters = 'file://aws/master/bamboo-params.json'
    if NOT_EXIST == status_for(stack_name)
      create(parameters, stack_name, template)
    else
      update(parameters, stack_name, template)
    end

  end
end

namespace :agent do
  NOT_EXIST = 'NOT_EXIST'
  stack_name = 'aws-bamboo-agent'

  desc 'create or update bamboo agent stack'
  task :create do
    template = 'file://aws/agent/bamboo-template.json'
    parameters = 'file://aws/agent/bamboo-params.json'
    if NOT_EXIST == status_for(stack_name)
      create(parameters, stack_name, template)
    else
      update(parameters, stack_name, template)
    end

  end
end

private

def create(parameters, stack_name, template)
  puts "\nStarting create stack: #{stack_name} ..."
  run "aws cloudformation create-stack --stack-name #{stack_name} --template-body #{template} --parameters #{parameters} --capabilities CAPABILITY_IAM"
  puts "Create stack: #{stack_name}, done!"
end

def update(parameters, stack_name, template)
  puts "\nStarting update stack: #{stack_name} ..."
  run "aws cloudformation update-stack --stack-name #{stack_name} --template-body #{template} --parameters #{parameters} --capabilities CAPABILITY_IAM"
  puts "Update stack: #{stack_name}, done!"
end

def status_for(stack_name)
  info = run "aws cloudformation describe-stacks --stack-name #{stack_name}"
  return NOT_EXIST if info.empty?
  JSON.parse(info)['Stacks'].first['StackStatus']
end

def run(cmd)
  puts cmd
  `#{cmd}`
end