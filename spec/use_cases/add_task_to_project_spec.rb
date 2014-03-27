require 'spec_helper'

# Example written in class:
#
# class TerminalClient
#   def self.start
#     params = { :name => 'Task Name', :project_id => 4 }
#     result = TM::AssignTaskToProject.run(params)
#     if result.success?
#       puts result.task
#     elsif result.error == :missing_project
#       puts "That project does not exist"
#     elsif result.error == :missing_task_name
#       puts "You must provide a task name"
#     end
#   end
# end

describe TM::AssignTaskToProject do
  it "fails when the project does not exist" do
    params = { :name => 'do it' }
    result = TM::AssignTaskToProject.run(params)
    expect(result.error?).to eq true
    expect(result.error).to eq :missing_project
  end

  it "fails when user did not provide a task name" do
    project = TM.db.create_project('one')
    params = { :project_id => project.id }
    result = TM::AssignTaskToProject.run(params)
    expect(result.error?).to eq true
    expect(result.error).to eq :missing_task_name
  end

  it "adds a task to a project"
end
