module TM
  class DB
    attr_reader :tasks, :projects, :project_count
    def initialize
      @projects = {}
      @project_count = 0
      @tasks= {}
      @task_count = 0
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
      @tasks[id] = nil
    end

    def get_all_tasks_for_project(project_id)
      all_tasks_hash = @tasks.select {|x,y| y[:project_id] == project_id}
      all_task_object = all_tasks_hash.each {|x| build_task(x)}
    end

    def get_all_incomplete_tasks_for_project(project_id)
      all_incomplete_tasks_hash = @tasks.select {|x,y| [y[:project_id] == project_id, y[:status] == 'incomplete']}
      all_incomplete_task_object = all_incomplete_tasks_hash.each {|x| build_task(x)}
    end

    def get_all_completed_tasks_for_project(project_id)
      all_complete_tasks_hash = @tasks.select {|x,y| [y[:project_id] == project_id, y[:status] == 'complete']}
      all_complete_task_object = all_complete_tasks_hash.each {|x| build_task(x)}
    end

    def build_task(data)
      Task.new(data[:name], data[:id], data[:project_id],data[:description], data[:priority], data[:status], data[:due_date])
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
