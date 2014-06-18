require 'time'
require 'pg'

@@db = PG.connect(host: 'localhost', dbname: 'task-manager')

class TM::Project
  attr_accessor :name, :pid, :tasks

  @@projects = [] ##add to projects table of db

  def initialize(name=nil)
    @name = name
    @pid = @@projects.size #change to return of result
    @tasks = [] ##add to tasks table of db
    @@projects << self
    result = @@db.exec("INSERT INTO projects(name) VALUES ('#{@name}, #{@creation_date}') RETURNING *;")
  end

  def self.create_tables
    @@db.exec("CREATE TABLE projects(pid SERIAL, name TEXT, creation_date TIMESTAMP, PRIMARY KEY(pid));")
    @@db.exec("CREATE TABLE tasks(tid SERIAL, priority INTEGER, description TEXT, pid INTEGER REFERENCES projects(pid), status TEXT, creation_date TIMESTAMP, PRIMARY KEY(tid));")
  end

  def add_task(priority, description)
    task = TM::Task.new(priority, description)
    @tasks << task
    result = @@db.exec("INSERT INTO tasks(description) VALUES('#{@priority}, #{@description}, #{@pid}, #{@status}, #{@creation_date}') RETURNING *;")
    result.values
  end

  def list_all_tasks
    result = @@db.exec("SELECT * FROM tasks;")
    result.values
    # puts @tasks.map { |i| puts "TID #{i.tid}: Priority #{i.priority}, #{i.description}" }
  end

  def list_completed_tasks
   # result = @@db.exec("SELECT * FROM tasks WHERE status ='complete' AND #{task.pid}=@pid;")
    result = @@db.exec("PREPARE tasks(priority, description) AS SELECT * FROM tasks WHERE status ='complete' AND #{task.pid}=@pid;")

    result.values
    # @tasks.sort_by! { |i| i.creation_date }
    # @tasks.select { |i| puts "TID #{i.tid}: #{i.description}" if i.status == 'complete' }
  end

  def list_incomplete_tasks
    result = @@db.exec("SELECT * FROM tasks WHERE status ='incomplete';")
    result.values
    # @tasks.sort_by! { |i| [i.priority, i.creation_date] }
    # @tasks.select { |i| puts "TID #{i.tid}: Priority #{i.priority}, #{i.description}" if i.status == 'incomplete' }
  end

  def self.list_projs
    result = @@db.exec("SELECT * FROM projects;")
    result.values
    # @@projects.each_with_index { |i,idx| puts "PID #{idx}: #{i.name}" }
  end

end
