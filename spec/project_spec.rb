require 'spec_helper'

describe 'Project' do
  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  before do
    TM::Project.current_id = 1
    @kill_bob = TM::Project.new("Kill Bob")
    @kill_sue = TM::Project.new("Kill Sue")
  end

  it "is created with a name" do
    expect(@kill_bob.name).to eq("Kill Bob")
  end

  it "automtically assigns a new id" do
    expect(@kill_bob.id).to eq(1)
    expect(@kill_sue.id).to eq(2)
  end

  it "can add tasks to itself" do
    @buy_gun = TM::Task.new(2, "Go buy a gun", 7)
    @kill_bob.add_task(@buy_gun)
    expect(@kill_bob.tasks.has_value?(@buy_gun)).to eq(true)
  end

  it "can also add tasks by id" do
    @buy_gun = TM::Task.new(2, "Go buy a gun", 7)
    @kill_bob.add_task(@buy_gun.task_id)
    expect(@kill_bob.tasks.has_key?(@buy_gun.task_id)).to eq(true)
  end

  it "can mark a task as complete by its id" do
    @buy_gun = TM::Task.new(2, "Go buy a gun", 7)
    @kill_bob.add_task(@buy_gun)
    @kill_bob.mark_as_finished(@buy_gun.task_id)
    expect(@buy_gun.finished?).to eq(true)
  end


end
