require 'date'
class TM::Employee
  attr_accessor :name, :id, :project_id_list, :task_id_list
  def initialize(name, id)
    @name = name
    @id = id
  end
end


# An employee can be created with a name
# This must automatically generate and assign a unique id
# Multiple employees can participate in a single project
# Tasks can be assigned to an employee
# The employee must be participating in that project


#1 project many employees
#1 employee many tasks

#task {project}
#employee
#table {tasks employee eligible}
# employee = task = - projects = employee

#project{task}
#employee{project} - = signup = - task{project}

#employee : e_id, many projects, many tasks
#projects: p_id, many epmloyees, many tasks
#tasks: t_id, many employees, one project
#task_team: one task, one project, many employees
#@task-assignment ={assignment_id => {emplo_id; task_id; project_id}

