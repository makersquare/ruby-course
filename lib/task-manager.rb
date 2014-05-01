
# Create our module. This is so other files can start using it immediately
module TM
end

# Require all of our project files
require_relative 'task-manager/task.rb'
require_relative 'task-manager/project.rb'

def add_task_to_project(task, project)
  #When task is passed to project list associate project id with task
  # task = task
  # project = project
  # new_task.id(project.id)
end

def sort_by_priority
# Iterate over projects task list array and create a hash with priority as the key and an array of tasks as the value
end


def sort_by_date
# Load hash from sort_by_priority and iterate over value by comparing the @create as the argument passed in.  Return a sorted array.
end

def mark_project_complete
# Mark project complete and clear out project list array
end


