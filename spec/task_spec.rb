require 'spec_helper'

describe 'Task' do
  it "exists" do
    expect(TM::Task).to be_a(Class)
  end

  before do
    TM::Task.current_id = 1
    @new_project = TM::Project.new("Kill Jim")
    @buy_gun = TM::Task.new(@new_project.id, "Go buy a gun", 7)
  end

  it "can be created with a project_id, description, and priority number" do
    expect(@buy_gun.project_id).to eq(@new_project.id)
    expect(@buy_gun.description).to eq("Go buy a gun")
    expect(@buy_gun.priority).to eq(7)
  end


  it "keeps a master hash of all tasks created" do
    old_length = TM::DB.instance.all_tasks.size
    load_gun = TM::Task.new(@new_project.id, "Load the gun", 5)
    expect(TM::DB.instance.all_tasks.size).to eq(old_length + 1)
    expect(TM::DB.instance.all_tasks.has_key?(load_gun.task_id)).to eq(true)
    expect(TM::DB.instance.all_tasks.has_value?(load_gun)).to eq(true)
  end

  it "can be marked as complete" do
    @buy_gun.finished = true
    expect(@buy_gun.finished?).to eq(true)
  end

  it "adds itself to the task-list in the approriate project" do
    new_task = TM::Task.new(@new_project.id, "Go to store", 3)
    expect(@new_project.tasks).to have_key(new_task.task_id)
  end



end
