require 'spec_helper'

# describe "project_list" do
#   before do
#     @new_project_list = TM::ProjectList.new
#     @new_project = TM::Project.new('project_name')
#   end

#   describe "add project" do
#     it "adds a project" do
#       @new_project_list.add_project('project_name')
#       result = @new_project_list.project_list
#       expect(result[0].name).to eq ('project_name')
#     end
#   end

#    describe "add task to project" do
#     it "adds a task to a project" do
#       description = "Holla back, gurl"
#       priority = 2
#       id = 4

#       @new_project_list.add_project("Holla back, gurl")
#       # new_task = TM::Task.new('description', 2, 1)
#       # binding.pry

#       @new_project_list.add_task_to_project(description, priority, id)
#       result = @new_project_list.project_list[0].tasks

#       expect(result[0].description).to eq("Holla back, gurl")
#       expect(result[0].priority).to eq(2)
#       expect(result[0].id).to eq(1)
#      end
#    end

#    describe "show_remaining_tasks" do
#     it "shows uncompleted tasks in a given project_id" do
#       @new_project_list.add_project(@new_project.name)

#       pid = @new_project.id + 1
#       @new_project_list.add_task_to_project("Holla back, gurl", 2, pid)
#       @new_project_list.add_task_to_project("I ain't", 2, pid)
#       @new_project_list.add_task_to_project("no holla back, gurl", 2, pid)
#       # binding.pry

#       expected_project = @new_project_list.project_list[0]

#       result = @new_project_list.show_remaining_tasks(pid)
#       expect(result).to eq(expected_project.tasks)

#     end
#    end

#    describe "show_completed_tasks" do
#     it "shows completed tasks in a given project_id" do
#       @new_project_list.add_project(@new_project.name)

#       pid = @new_project.id + 1
#       @new_project_list.add_task_to_project("Holla back, gurl", 2, pid)
#       @new_project_list.add_task_to_project("I ain't", 2, pid)
#       @new_project_list.add_task_to_project("no holla back, gurl", 2, pid)
#       # binding.pry

#       expected_project = @new_project_list.project_list[0]
#       expected_project.tasks.each { |task| task.complete = true }

#       result = @new_project_list.show_completed_tasks(pid)
#       expect(result).to eq(expected_project.tasks)

#     end
#    end

#    describe "mark" do
#     it 'marks a task complete by the task id' do
#       @new_project_list.add_project(@new_project.name)

#       pid = @new_project.id + 1
#       @new_project_list.add_task_to_project("Holla back, gurl", 2, pid)
#       @new_project_list.add_task_to_project("I ain't", 2, pid)
#       @new_project_list.add_task_to_project("no holla back, gurl", 2, pid)

#       expected_project = @new_project_list.project_list[0]
#       task = expected_project.tasks.find { |task| task.description == "Holla back, gurl" }
#       task_tid = task.id
#       @new_project_list.mark_complete(task_tid)

#       expect(task.complete).to eq(true)
#     end
#    end
# end
