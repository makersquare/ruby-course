require 'pry-debugger'

class TM::DB

  attr_reader :tasks, :projects, :project_count, :task_count
  def initialize
    @projects = {}
    @project_count = 0
    @tasks = {}
    @task_count = 0
  end

  def create_project(data)
    @project_count += 1
    data[:id] = @project_count
    @projects[@project_count] = data
    return TM::DB.build_project(data)
  end

  def get_project(id)
    data = @projects[id]
    return TM::DB.build_project(data)
  end

  def update_project(id, data)
    data.each {|x,y| @projects[id][:x] = data[:x] }
    return TM::DB.build_project(data)
  end

  def destroy_project(id)
    @projects.delete(id)
    @tasks.each do |x,y|
      @tasks.delete(x) if @tasks[:x][:pid] = id
    end
  end

  def self.build_project(data)
    TM::Project.new(data[:name], data[:id])
  end

  def create_task(data) #pid, des, pnum, duedate
    @task_count += 1
    data[:tid] = @task_count
    @tasks[:@task_count] = data
    return TM::DB.build_task(data)
  end

  def get_task(tid)
    data = tasks[tid]
    return TM::DB.build_task(data)
  end

  def update_task(id, data)
    data.each {|x,y| @tasks[:id][:x] = data[:x]}
    return TM::DB.build_task(data)
  end

  def destroy_task(id)
    @tasks.delete(id)
  end

  def build_task(data)
    TM::Task.new(data[:pid], data[:desc], data[:duedate], data[:tid])
  end

end

def self.db
  @__db_instance ||= DB.new
end
