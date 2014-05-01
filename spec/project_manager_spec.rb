require 'spec_helper'

describe 'ProjectManager' do

  before (:each) do
    @manager = TM::ProjectManager.new
  end
  it "has initial empty array projects and tasks list" do
   @manager.listed_projects.should == []
   @manager.listed_tasks.should == []
  end

  it "gives a specific input when help method is called" do
    @manager.help.should == "Follow the instruction and have fun!"
  end

  it "allows you to add a project and that project is stored in the projects array" do
    @manager.get_projects.should == "You need to create your project first"
    @manager.create_new_project("project1")
    @manager.create_new_project("project2")
    @manager.create_new_project("project3")
    @manager.create_new_project("project4")
    @manager.listed_projects.count.should == 4
    @manager.listed_projects.first.name.should == "project1"
    @manager.listed_projects.last.name.should == "project4"
  end


it "has the method to add tasks to a project" do
  TM::Project.project_id_counter = 1
  @manager.add_task("5", "project AB", "6").should == "You need to create your project first"
  @manager.create_new_project("project1")
  @manager.create_new_project("project2")
  @manager.listed_projects.count.should == 2
  @manager.listed_projects.first.id.should == 1
  @manager.listed_projects.last.id.should == 2
  @manager.add_task("1", "project AB", "23")
  @manager.add_task("2", "project YX", "24")
  @manager.listed_tasks.count.should == 2
end

it "has method to complete task" do
  TM::Project.project_id_counter = 1
  TM::Task.project_id_counter = 1
  @manager.create_new_project("project")
  task = @manager.add_task("1", "project AB", "7")
  @manager.complete_task(1)
  task.status.should == true
end
end
