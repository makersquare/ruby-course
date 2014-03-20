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

  it "can retrieve a list of completed tasks sorted by creation date" do
    buy_gun = TM::Task.new(2, "Go buy a gun", 8)
    load_gun = TM::Task.new(2, "Load the gun", 8)
    evade_police = TM::Task.new(2, "Get away!", 10)
    @kill_bob.add_task(buy_gun)
    @kill_bob.add_task(load_gun)
    @kill_bob.add_task(evade_police)
    buy_gun.finished = true
    load_gun.finished = true
    evade_police.finished = true
    expect(@kill_bob.completed_tasks).to eq([buy_gun, load_gun, evade_police])
  end

  it "can retrieve a list of all incomplete tasks sorted by priority, creation_date" do
    buy_gun = TM::Task.new(2, "Go buy a gun", 8)
    load_gun = TM::Task.new(2, "Load the gun", 8)
    evade_police = TM::Task.new(2, "Get away!", 10)
    @kill_bob.add_task(buy_gun)
    @kill_bob.add_task(load_gun)
    @kill_bob.add_task(evade_police)

    expect(@kill_bob.ongoing_tasks).to eq([evade_police, buy_gun, load_gun])
  end

  it "can retrieve a hash of all current projects and their ids" do
    expect(TM::DB.instance.all_projects.length).to eq(2)
    expect(TM::DB.instance.all_projects[1]).to eq(@kill_bob)
    expect(TM::DB.instance.all_projects[2]).to eq(@kill_sue)
  end

  it "keeps a list of enrolled employees" do
    employee1 = TM::Employee.new("Bob")
    @kill_bob.assign_employee(employee1)
    expect(@kill_bob.assigned_employees[employee1.employee_id]).to eq(employee1)
  end


end
