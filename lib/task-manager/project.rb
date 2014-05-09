
class TM::Project

  #keeps track of project_id_count in array
  @@project_id_counter = 0
  @@projects = []

  #allows instance variables to be 'read'
  attr_reader :name, :completed_tasks, :project_id
  attr_accessor :project_id_counter, :projects

  # .new method - creates instances of the TM::Project class
  # each @'value' is called an instance variable
  # these are the attributes which are specific to the instance
  def initialize(name)
    @name = name
    @@project_id_counter += 1
    @project_id = @@project_id_counter
    @@projects << self
  end

  #this method will have to do two things
  #1, populate a list of completed tasks
  #2, return the list sorted by creation date
  def retrieve_list
    @@projects
  end

  # Resets the project_id_count so that it doesn't increment while testing
  # the 'self' means that it is a Class method
  # in other words, you do not have to use this method on an instance
  # rather, it can be used on a Class object
  def self.reset_class_variables
    @@project_id_counter = 0
  end

end
