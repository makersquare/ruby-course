
# Create our module. This is so other files can start using it immediately
module TM
end

# Require all of our project files
require_relative 'task-manager/task.rb'
require_relative 'task-manager/project.rb'

def add_task_to_project(task, project)
   task.id = project.id
   project.task_list << task
   puts "#{task.description} added to #{project.name}"
end

def sort_by_priority(project)
# Iterate over projects task list array and create a hash with priority as the key and an array of tasks as the value
  #project.project_list
  project.task_list.sort {|a, b| a.priority <=> b.priority }

end


def sort_by_date(project)
# Load array from and iterate over value by comparing the @create as the argument passed in.  Return a sorted array.
  project.task_list.sort {|a, b| a.created <=> b.created }
end

def mark_project_complete(project)
# Mark project complete and clear out project list array
  project.mark_complete
  project.task_list.each do |task|
    task.mark_complete
  end
end


