### From Module Organization
  # attr_accessor :name,:call_count_reset,:call_count

  # def created
  #   @create_date = Time.now
  # end


  # def call_count_reset
  #   @call_count = 1
  # end

  # def id
  #   @id = @id_call_count
  # end

  # def id_call_count
  #   @id_call_count = 1
  # end

  # def increment_id
  #   ## Implement a method for a unique ID
  #   ## Should be unique for projects
  #   @id = @call_count
  #   @call_count += 1
  # end

  # From project.rb

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

    # @id = @id_call_count
    # @id_call_count += 1
    # @name = name + " - #{@project_id}"
    # @project_list = {@project_id => []}
    # @@project_count += 1
    # @@project_instances_list << @name

     # def add_task(task, project)

  #   @add_task = Task.new(task)

    # ## if the project doesn't exist, I need to add a new project
    # if @@project_instances_list.include?
    #   @project_list = {@project_id => [@add_task]}
    # end

    ## From

  # def mark_complete
  #   @complete = true
  # end



