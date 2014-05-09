def add_task_to_project(task, project)
   task.id = project.id
   project.task_list << task
   puts "#{task.description} added to #{project.name}"
end

def sort_by_priority(project)
  project.task_list.sort {|a, b| a.priority <=> b.priority }
end

def sort_date_and_priority(project, priority)
  project.task_list.select {|task| task.priority == priority}
end


def mark_project_complete(project)
  project.mark_complete
  project.task_list.each do |task|
  task.mark_complete
  end
end

def retrieve_complete_tasks(project)
  project.task_list.select {|task| task.complete == true}
end

add_task_to_project(task1, project1)
