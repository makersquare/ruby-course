require 'spec_helper'

describe 'Task' do
  it "exists" do
    expect(TM::Task).to be_a(Class)
  end



  it "creates a new task with a default complete value to false" do
    # TM::Task.new(project_id,description,priority,task_id)
    eating_better = TM::Task.new(1,2,"diet",1)
    expect(eating_better.priority_num).to eq 1
    expect(eating_better.complete).to eq false
  end

   it 'gives the task a creation date' do
    Time.stub(:now).and_return(Time.parse("2pm"))
    eating_better = TM::Task.new(1,"diet",1)
    created_time_stub = Time.now

    expect(eating_better.creation_date).to eq(created_time_stub)

    end

end


# A new task can be created with a project id, description, and priority number
# A task can be marked as complete, specified by id





