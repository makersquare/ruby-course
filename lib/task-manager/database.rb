module TM
  class DB
    attr_reader :tasks, :projects, :project_count, :task_count, :employees, :employee_count, :task_assignment, :task_assignment_count
    def initialize
      @projects = {}
      @project_count = 0
      @tasks= {}
      @task_count = 0
      @employees = {}
      @employee_count = 0
      @task_assignment = {}
      @task_assignment_count = 0
    end

    def create_project(data)
      id = @project_count
      @projects[id]= {name: data[:name], id: id}
      build_project(@projects[id])
      @project_count+=1
    end

    def get_project(id)
      build_project(@projects[id])
    end

    def update_project(project)
      #@projects[id].each {|x,y| hash[x] = y }
      #build_project(@projects[id])
      attrs = @projects[project.id]
      attrs[:name] = project.name
    end

    def destroy_project(id)
      @projects.delete_if {|x,y| x == id}
    end

    def build_project(data)
      Project.new(data[:name], data[:id])
    end

    def create_task(data)
      id = @task_count
      @tasks[id]= {name: data[:name], id: id, project_id: data[:project_id], description: data[:description], priority: data[:priority], status: data[:status], due_date: data[:due_date]}
      build_task(@tasks[id])
      @task_count+=1
    end

    def get_task(id)
      build_task(@tasks[id])
    end

    def update_task(task)
      # @tasks[id].each {|x,y| y = hash[x] }
      # build_task(@tasks[id])
      attrs = @tasks[task.id]
      attrs[:name] = task.name
      attrs[:status] = task.status
    end

    def destroy_task(id)
      @tasks.delete_if {|x,y| x == id}
    end

    def get_all_tasks_for_project(project_id)
      all_tasks_hash = @tasks.select {|x,y| y[:project_id] == project_id}
      all_task_object = all_tasks_hash.each {|x,y| build_task(y)}
    end

    def get_all_incomplete_tasks_for_project(project_id)
      all_incomplete_tasks_hash = @tasks.select {|x,y| y[:status] == 'incomplete'}.select {|k,v| v[:project_id] == project_id}
      all_incomplete_task_object = all_incomplete_tasks_hash.each {|x,y| build_task(y)}
    end

    def get_all_completed_tasks_for_project(project_id)
      all_complete_tasks_hash = @tasks.select {|x,y| y[:project_id] == project_id}.select {|k,v| v[:status] == 'complete'}
      all_complete_task_object = all_complete_tasks_hash.each {|x,y|  p build_task(y)}
    end

    def build_task(data)
      Task.new(data[:name], data[:id], data[:project_id],data[:description], data[:priority], data[:status], data[:due_date])
    end


    def create_employee(data)
      id = @employee_count
      @employees[id]= {name: data[:name], id: id}
      build_employee(@employees[id])
      @employee_count+=1
    end

    def get_employee(id)
      build_employee(@employees[id])
    end

    def update_employee(employee)
      #@projects[id].each {|x,y| hash[x] = y }
      #build_project(@projects[id])
      attrs = @employees[employee.id]
      attrs[:name] = employee.name
    end

    def destroy_employee(id)
      @employees.delete_if {|x,y| x == id}
    end

    def build_employee(data)
      Employee.new(data[:name], data[:id])
    end

#@task-assignment ={assignment_id => {emplo_id; task_id; project_id}
    def create_task_assignment(data)
      id = @task_assignment_count
      @task_assignment[id] = {id: id, employee_id: data[:employee_id], task_id: data[:task_id], project_id: data[:project_id]}
      @task_assignment_count +=1
    end

    def get_task_assignment(id)
      employee_x = get_employee(@task_assignment[id][:employee_id])
      task_assigned_to_x =get_task(@task_assignment[id][:task_id])
      project_assigned_to_x = get_project(@task_assignment[id][:project_id])
      puts "#{employee_x.name} has been assigned to task #{task_assigned_to_x.name} on project #{project_assigned_to_x.name}."
      @task_assignment[id]
    end

    def update_task_assignment(task_assignment)
      attrs = @task_assignment[task_assignment[:id]]
      attrs[:employee_id] = task_assignment[:employee_id]
      attrs[:task_id] = task_assignment[:task_id]
      attrs[:project_id] = task_assignment[:project_id]
    end

    def destroy_task_assignment(id)
      @task_assignment.delete_if {|x,y| x == id}
    end

    def get_all_tasks_for_employee(employee_id)
      all_tasks_by_employee_hash = @task_assignment.select {|x,y| y[:employee_id] == employee_id}
      all_task_object = all_tasks_by_employee_hash.each {|x,y| build_task(@tasks[y[:task_id]])}
    end

    def get_all_incomplete_tasks_for_employee(employee_id)
      all_incomplete_tasks_by_employee_hash = @task_assignment.select {|x,y| y[:employee_id] == employee_id}.select {|k,v| @tasks[v[:task_id]][:status] == 'incomplete'}
      all_incomplete_task_object = all_incomplete_tasks_by_employee_hash.each {|x,y| build_task(@tasks[y[:task_id]])}
    end

    def get_all_completed_tasks_for_employee(employee_id)
      all_complete_tasks_by_employee_hash = @task_assignment.select {|x,y| y[:employee_id] == employee_id}.select {|k,v| @tasks[v[:task_id]][:status] == 'complete'}
      all_complete_task_by_employee_object = all_complete_tasks_by_employee_hash.each {|x,y|  p build_task(@tasks[y[:task_id]])}
    end

    def get_all_projects_for_employee(employee_id)
      all_tasks_by_employee_hash = @task_assignment.select {|x,y| y[:employee_id] == employee_id}
      all_task_object = []
      all_tasks_by_employee_hash.each {|x,y| all_task_object<<build_project(@projects[y[:project_id]])}
      all_task_object.uniq {|s| s.id}
    end

  end

  def self.db
    @__db_instance ||= DB.new
  end
end


  # def get_tasks_for_project(pid)
  #    @tasks.select {|task| task.project_id == pid}
  # end

  #get_tasks_from_project_id(pid)

  # @project[project.id]= {id: project.id, name: project.name}
  #@projects key is id , value is hash of attributes
  # updates: speak with middle man aka database class
  #create_user({}) return entity
  #get_user[id] return entity
  # db.create_project(:name=>"Do it")
  #def create_project(attrs)
  # #store new project in DB#
  # # create and return entity#
  # attrs[:id] = @project_count
  # @projects[@project_count] = attrs
  # Project.new(attrs[:name], attrs[:id])
  #end

#atrr_reader :complete
# def mark_complete
# @complete = true
#end *****encapsulation ****persistent
