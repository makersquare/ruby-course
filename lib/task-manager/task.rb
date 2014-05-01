require 'time'

class TM::Task

  attr_accessor :project_id, :description, :priority_number, :id, :status, :project_id_counter, :creation_date
  @@project_id_counter = 1

  def initialize(project_id, description, priority_number)
    @project_id = project_id
    @description = description
    @priority_number = priority_number
    @id = @@project_id_counter
    @@project_id_counter += 1
    @status = "incomplete"
    @creation_date = Time.now
  end

  def self.project_id_counter
    @@project_id_counter
  end

  def self.project_id_counter=(value)
    @@project_id_counter = value
  end
end








# class TM::Task

#   attr_reader :project_id, :creation_date
#   attr_accessor :priority_no, :description, :status

# def initialize(project_id, priority_no= priority, description)
#     @priority_no = priority_no
#     @project_id = id
#     @description = description
#     @creation_date = Time.new
#     @projects = []
#   end

#   def priority
#     rand(1..6)
#   end

# def add_project(project)
#   @projects << project
# end


# def list_project
#   projects = add_project
#   if projects.size > 0
#   puts "There are #{projects.size} projects"
#   projects.each do |project|
#   puts project
# end
# else
#   puts "There is no available project right now"
#   end
# end

# def create_new_task(project_id, priority_no, description)
#     task = TM::Task.new(project_id, priority_no, description)
#     @tasks << task
#   end

#   def complete_tasks()
#     @complete_task = []
#     (0..@tasks.length).each do |t|
#     if @tasks[t].status == true
#     @complete_task << @tasks[t]
#   end
#   end
#     @complete_task.sort_by! {|task|task.creation_date}
#   end

#   def incomplete_tasks()
#     (0..@tasks.length).each do |t|
#     if @tasks[t].status == false
#     @incomplete_task << @tasks[t]
#     end
#     end
#     @incomplete_task.sort_by! {|task| task.priority_number}
#   end

#   def mark_complete
#   end

# end





