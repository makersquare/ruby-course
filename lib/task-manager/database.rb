require 'pry-debugger'

class TM::DB

  attr_reader :tasks, :projects
  def initialize
    @projects = {
      1 => {
        id: 1,
        name: "Project 1"
      }
    }
    @project_count = 0
    @tasks = {
      1 => {
        tid: 1,
        pid: 1,
        desc: "buy shit",
        date: "2014 1 31",
        pnum: 1,
        complete: false,
        duedate: "2014 1 1"
      }
    }
    @task_count = 0
  end

#return instances
#edit hash separately

  def create_project(data)
    @project_count += 1
    data[:id] = @project_count
    @projects[@project_count] = data
    return TM::DB.build_project(data)
  end

  def get_project(id)
    data = @projects[:id]
    return TM::DB.build_project(data)
  end

  def update_project(id, data)
    data.each {|x,y| @projects[:id][:x] = y }
    return TM::DB.build_project(data)
  end

  def destroy_project(id)
    @projects.delete("id")
  end

  def build_project(data)
    TM::Project.new(data[:name], data[:id])
  end

  def create_task(data) #pid, des, pnum, duedate
    @task_count += 1
    data[:tid] = @task_count
    @tasks[:tid] = data
    @tasks[:@task_count] = TM::DB.build_task(data)
  end

  def get_task(tid)
    data = tasks[:tid]
    return TM::DB.build_task(data)
  end

  def update_task(id, data)
    data.each {|x,y| @tasks[:id][:x] = y }
    TM::Task.edit_project(data)
  end

  def destroy_task(id)
    @tasks.delete("id")
  end

  def build_task(data)
    TM::Task.new(data[:pid], data[:desc], data[:duedate], data[:tid])
  end

end

def self.db
  @__db_instance ||= DB.new
end
