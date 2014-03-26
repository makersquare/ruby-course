require 'spec_helper'

describe 'Project list' do

  before do
    @proj_list = TM::ProjectList.new
  end

it "can create a project" do
  result = @proj_list.create_project("Cure cancer") # PROJ 1
  expect(result).to be_a(TM::Project)
  expect(result.name).to eq("Cure cancer")
  expect(result.all_tasks).to be_empty
end

it "can list all projects" do
  @proj_list.create_project("Solve world hunger") #PROJ 2
  @proj_list.create_project("Build a warship") #PROJ 3
  @proj_list.create_project("Clone Einstein") #PROJ 4
  result = @proj_list.show_all
  expect(result).to be_a(Array)
  expect(result[-1].name).to eq("Clone Einstein")
end

it "can list remaining tasks for specific project" do
    result = @proj_list.create_project("Alleviate world hunger") #PROJ 5
    task1 = result.add_task("grow corn", 4)
    task2 = result.add_task("secure funding", 5)
    task3 = result.add_task("buy farmland", 2)
    task4 = result.add_task("solve distribution", -9)
    result.mark_complete(task2.id)
    result.mark_complete(task4.id)
    incomplete = @proj_list.show_inc(result.id)
    expect(incomplete).to be_a(Array)
  end


it "can list completed tasks" do
  a_proj = @proj_list.create_project("Build giant ship") #PROJ 6
  task1 = a_proj.add_task("cut trees", 14)
  task2 = a_proj.add_task("cut more trees", 2)
  task3 = a_proj.add_task("give up and become lumberjack", 1)
  task4 = a_proj.add_task("get crew", 4)
  task1_c = a_proj.mark_complete(task1.id)
  task3_c = a_proj.mark_complete(task3.id)
  complete = @proj_list.show_comp(a_proj.id)
  expect(complete).to be_a(Array)
  expect(complete[0][1].description).to eq("cut trees")
end

it "can add a new task to a specific project" do
  result = @proj_list.create_project("Bake a sweet potato pie") #PROJ 7
  task1 = @proj_list.add_new_task(result.id, "drive to store", 3)
  task2 = @proj_list.add_new_task(result.id, "buy sweet potatoes", 1)
  task3 = @proj_list.add_new_task(result.id, "buy the pie from a bakery", 5)
  expect(task1.projID).to eq(result.id)
  expect(task2.priority).to eq(1)
  expect(task3.description).to eq("buy the pie from a bakery")
  expect(task3.complete?).to eq(false)
  a_proj = @proj_list.show_all
  expect(a_proj[-1].name).to eq("Bake a sweet potato pie")
end


it "can mark a task with TID (task ID) as complete" do
  result = @proj_list.create_project("Make pasta") #PROJ 7
  task1 = @proj_list.add_new_task(result.id, "go to the market", 4)
  task2 = @proj_list.add_new_task(result.id, "buy tomatoes", 10)
  task3 = @proj_list.add_new_task(result.id, "go to restaurant", 12)
  # binding.pry
  comp_task = @proj_list.mark_task_c(task2.id)
  # expect(comp_task.complete).to eq("complete")
end


end
