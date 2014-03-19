require 'spec_helper'

describe 'Task' do
  it "exists" do
    expect(TM::Task).to be_a(Class)
  end

  before do
    TM::Task.current_id = 1
    @buy_gun = TM::Task.new(2, "Go buy a gun", 7)
  end

  it "can be created with a project_id, description, and priority number" do
    expect(@buy_gun.project_id).to eq(2)
    expect(@buy_gun.description).to eq("Go buy a gun")
    expect(@buy_gun.priority).to eq(7)
  end


  it "keeps a master hash of all tasks created" do
    old_length = TM::Task.all_tasks.size
    load_gun = TM::Task.new(2, "Load the gun", 5)
    expect(TM::Task.all_tasks.size).to eq(old_length + 1)
    expect(TM::Task.all_tasks.has_key?(load_gun.task_id)).to eq(true)
    expect(TM::Task.all_tasks.has_value?(load_gun)).to eq(true)
  end

  it "can be marked as complete" do
    @buy_gun.finished = true
    expect(@buy_gun.finished?).to eq(true)
  end



end
