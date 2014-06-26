# require 'spec_helper'
# require 'pry'

# describe 'ProjectsManager' do
#  before(:each) do
#     TM::Project.reset_class_variables
#     TM::Task.reset_class_variables
#   end

#   it "exists" do
#     expect(TM::ProjectsManager).to be_a(Class)
#   end

#   context 'a projects_manager client is initialized' do
#     let(:projects_manager) { TM::ProjectsManager.new }

#     it 'has an array for projects' do
#       expect(projects_manager.projects).to eq([])
#     end
#   end

#   context 'a new project is created' do
#     let(:projects_manager) { TM::ProjectsManager.new }
#     let(:project1) { TM::Project.new("Project 1") }
#     let(:project2) { TM::Project.new("Project 2") }

#     it 'can create a new project' do
#       projects_manager.create_project("Project 1")
#       expect(projects_manager.projects.count).to eq(1)
#     end

#     it 'can list all current projects' do
#       projects_manager.projects << project1
#       projects_manager.projects << project2

#       expect(projects_manager.list_projects).to eq([project1, project2])
#     end
#   end

#   context 'a project is created and task are viewed' do
#     let(:projects_manager) { TM::ProjectsManager.new }
#     let(:project1) { TM::Project.new("Project 1") }
#     let(:project2) { TM::Project.new("Project 2") }
#     let(:task1) { TM::Task.new(1, 1, "complete this task manager") }
#     let(:task2) { TM::Task.new(1, 2, "complete this task manager") }

#     it 'can list all remaining task for a project by project ID' do
#       projects_manager.projects << project1
#       projects_manager.projects << project2
#       project1.task << task1
#       project1.task << task2

#       expect(projects_manager.remaining_task(1)).to eq([task1,task2])
#     end

#     it 'can list all previously completed task' do
#       projects_manager.projects << project1
#       projects_manager.projects << project2
#       project1.task << task1
#       projects_manager.complete_task(1)
#       project1.task << task2

#       expect(projects_manager.history(1)).to eq([task1])
#     end
#   end

#   context 'a task is added to a current project' do
#     let(:projects_manager) { TM::ProjectsManager.new }
#     let(:project1) { TM::Project.new("Project 1") }

#     it "increases the project's task count by 1" do
#       projects_manager.projects << project1
#       expect(projects_manager.projects.first.task.count).to eq(0)
#       projects_manager.add_task(1,3, "Add a task already!")
#       expect(projects_manager.projects.first.task.count).to eq(1)
#     end

#     it  "can be marked as completed" do
#       projects_manager.projects << project1
#       projects_manager.add_task(1,3, "Add a task already!")
#       task = projects_manager.projects.first.task.first

#       expect(task.completed).to eq(false)
#       projects_manager.complete_task(1)
#       expect(task.completed).to eq(true)
#     end
#   end
# end
