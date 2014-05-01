
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

def sort_by_priority(project, priority)
# Iterate over projects task list array and create a hash with priority as the key and an array of tasks as the value
  #project.project_list
  project.task_list.each do |task|
    task.priority == priority
    {priority => [task]}
  end
end


def sort_by_date
# Load hash from sort_by_priority and iterate over value by comparing the @create as the argument passed in.  Return a sorted array.
end

def mark_project_complete(project)
# Mark project complete and clear out project list array
  project.
  project.task_list.clear
end


