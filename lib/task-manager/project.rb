require_relative 'module-organization'

class TM::Project
include Organization


attr_reader :created, :add_task, :task_list
attr_accessor :name, :task,

def self.project_count
  @@project_count
end

def self.project_list
  @@project_list
end

def self.reset_class_variables
  @@project_count = 0
  @@project_list.clear
end

@@project_count = 0
@@project_list = []

  def initialize(name="New Project")
    @created = Time.now
    @task_list = []
    @@project_count += 1
    @id = @@project_count
    @name = "#{name} - #{@id}"
    @@project_list << @name
  end

def add_id_to_name
  @name = "#{@name} - #{id}"
end

def sort_by_date(project)
# Load array from and iterate over value by comparing the @create as the argument passed in.  Return a sorted array.
  @task_list.sort {|a, b| a.created <=> b.created }
end

end
