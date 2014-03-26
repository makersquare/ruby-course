require 'spec_helper'

describe 'Project' do

  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  it "initializes with name and id" do
      a_proj = TM::Project.new "Weekend Errands"
      expect(a_proj.name).to eq("Weekend Errands")
      expect(a_proj.id).to be_a(Integer)
  end

  it "can add new tasks to the project" do
    a_proj = TM::Project.new "Weekend Errands"
    result = a_proj.add_task("buy milk", 4)
    expect(a_proj.all_tasks).to be_a(Hash)
    expect(a_proj.all_tasks[result.id].complete?).to eq(false)
    expect(a_proj.all_tasks[result.id].description).to eq("buy milk")
  end

  it "can mark tasks as complete or incomplete" do
    new_proj = TM::Project.new "Errands"
    new_task = new_proj.add_task("shower", 5)  #
    result = new_proj.mark_complete(new_task.id).complete?
    expect(result).to eq(true)
    result = new_proj.mark_incomplete(new_task.id).complete?
    expect(result).to eq(false)
  end

  it "can return an array of all complete tasks by creation date" do
    my_proj = TM::Project.new "After Work Errands"
    task1 = my_proj.add_task("wash car", 2)
    task2 = my_proj.add_task("buy groceries", 10)
    task3 = my_proj.add_task("get haircut", 0)
    my_proj.mark_complete(task3.id)
    my_proj.mark_complete(task1.id)
    comp_arr = my_proj.sort_comp
    expect(comp_arr).to be_a(Array)
    expect(comp_arr[0][1].description).to eq("wash car")
  end

  it "can return a list of all incomplete tasks sorted by priority" do
    my_proj = TM::Project.new "Stuff to do"
    task1 = my_proj.add_task("walk dog", 7)
    task2 = my_proj.add_task("fill gas tank", 4)
    task3 = my_proj.add_task("cook dinner", -1)
    task4 = my_proj.add_task("call Ma", 2)
    task5 = my_proj.add_task("do laundry", 4)
    my_proj.mark_incomplete(task1.id)
    my_proj.mark_incomplete(task2.id)
    my_proj.mark_incomplete(task3.id)
    my_proj.mark_incomplete(task4.id)
    my_proj.mark_incomplete(task5.id)
    result = my_proj.sort_inc
    expect(result).to be_a(Array)
    expect(result[0][1].description).to eq("cook dinner")
    expect(result[1][1].description).to eq("call Ma")
  end

  it "can return a list of incomplete tasks sorted by priority and creation date" do
    my_proj = TM::Project.new "So busy much wow"
    task1 = my_proj.add_task("do homework", 5)
    task2 = my_proj.add_task("do laundry", 2)
    task3 = my_proj.add_task("boil pasta", 5)
    task4 = my_proj.add_task("get new glasses", 1)
    my_proj.mark_incomplete(task1.id)
    my_proj.mark_incomplete(task2.id)
    my_proj.mark_incomplete(task3.id)
    my_proj.mark_incomplete(task4.id)
    result = my_proj.sort_inc
    expect(result).to be_a(Array)
    expect(result[0][1].description).to eq("get new glasses")
    expect(result[2][1].description).to eq("do homework")
    expect(result[3][1].priority).to eq(5)
  end


end
