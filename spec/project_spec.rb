require 'spec_helper'

describe 'Project' do

  before do
    @my_proj = TM::Project.new "To Do"
  end

  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  it "initializes with name and id" do
      expect(@my_proj.name).to eq("To Do")
      expect(@my_proj.id).to eq(2)
  end

  it "can add new tasks to the project and return num tasks" do
    result = @my_proj.add_task("buy milk", 4) #TASK ID 1
    expect(result).to eq(1)
    expect(@my_proj.all_tasks).to be_a(Hash)
    expect(@my_proj.all_tasks[1].complete?).to eq("incomplete")
  end

  it "can mark tasks as complete or incomplete" do
    new_proj = TM::Project.new "Errands"
    new_proj.add_task("shower", 5)  #TASK ID 2
    result = new_proj.mark_complete(2).complete?
    expect(result).to eq("complete")
    # binding.pry
    result = new_proj.mark_incomplete(2).complete?
    expect(result).to eq("incomplete")
  end

  it "can return an array of all complete tasks by creation date" do
    @my_proj.add_task("wash car", 2) #TASK ID 3
    @my_proj.add_task("buy groceries", 10) #TASK ID 4
    @my_proj.add_task("get haircut", 0) #TASK ID 5
    @my_proj.mark_complete(3)
    @my_proj.mark_complete(4)
    result = @my_proj.sort_comp
    expect(result).to be_a(Array)
    expect(result[0][1].description).to eq("wash car")
    expect(result[1][1].description).to eq("buy groceries")
  end

  it "can return a list of all incomplete tasks sorted by priority" do
    @my_proj.add_task("walk dog", 7) #TASK ID 6
    @my_proj.add_task("fill gas tank", 4) #TASK ID 7
    @my_proj.add_task("cook dinner", -1) # TASK ID 8
    @my_proj.add_task("call Ma", 2) # TASK ID 9
    @my_proj.mark_incomplete(6)
    @my_proj.mark_incomplete(7)
    @my_proj.mark_incomplete(8)
    @my_proj.mark_incomplete(9)
    result = @my_proj.sort_inc
    expect(result).to be_a(Array)
    expect(result[0][1].description).to eq("cook dinner")
    expect(result[1][1].description).to eq("call Ma")
  end

  it "can return a list of incomplete tasks sorted by priority and creation date" do
    @my_proj.add_task("do homework", 5) #TASK ID 10
    @my_proj.add_task("do laundry", 2) #TASK ID 11
    @my_proj.add_task("boil pasta", 5) # TASK ID 12
    @my_proj.add_task("get new glasses", 1) # TASK ID 13
    @my_proj.mark_incomplete(10)
    @my_proj.mark_incomplete(11)
    @my_proj.mark_incomplete(12)
    @my_proj.mark_incomplete(13)
    result = @my_proj.sort_inc
    expect(result).to be_a(Array)
    expect(result[0][1].description).to eq("get new glasses")
    expect(result[2][1].description).to eq("do homework")
    expect(result[3][1].priority).to eq(5)
  end


end
