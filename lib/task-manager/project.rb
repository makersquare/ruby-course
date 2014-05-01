require_relative 'module-organization'

class TM::Project
include Organization


attr_reader :created, :add_task, :task_list
attr_accessor :name, :task, :project_list, :id

def self.project_count
  @@project_count
end

@@project_count = 0


def self.reset_class_variables
  @@project_count = 0
  # @@project_instances_list.clear
end

# def self.project_instances_list
#   @@project_instances_list
# end




# @@project_count = 0

# @@project_instances_list = []

  # def initialize(name="New Project #{@project_id}")
  #   @list = []
  #   @name = name
  #   @created = Time.now
  #   @project_id = @@project_count
  #   @@project_count += 1
  # end


  # def id_call_count
  #   @id_call_count = 1
  # end

  def initialize(name="New Project")
    @name = name
    @created = @create_date
    @task_list = []
    @@project_count += 1
    @id = @@project_count

    # @id = @id_call_count
    # @id_call_count += 1
    # @name = name + " - #{@project_id}"
    # @project_list = {@project_id => []}
    # @@project_count += 1
    # @@project_instances_list << @name
  end

  def add_task(task, project)
    @add_task = Task.new(task)

    # ## if the project doesn't exist, I need to add a new project
    # if @@project_instances_list.include?
    #   @project_list = {@project_id => [@add_task]}
    # end



  end
end
