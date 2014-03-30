require 'spec_helper'

describe 'Project' do
  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  it "has a name" do
    test = TM::Project.new("Test")
    expect(test.name).to eq("Test")
  end

  it "has an id with the name" do
    test = TM::Project.new("Test")
    expect(test.name).to eq("Test")

    id = (0...8).map {(65+rand(26)).chr}.join
    expect(TM::Project.id).not_to be_empty
  end

  it "lists and sorts completed tasks by date created" do
    current_time = Time.now
    Time.stub(:now).and_return(current_time)
    test = TM::Project.new("Test")
    test_task = TM::Task.new("TestTask", 3, TM::Project.id)

    test_task2 = TM::Task.new("TestTask2", 2, TM::Project.id)

    test_task2.complete
    expect(test.completed_tasks_method(test_task2)).to eq([[test_task2.project_id, "yes", Time.now]])
  end

end
