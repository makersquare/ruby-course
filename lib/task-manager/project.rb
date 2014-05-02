
class TM::Project

  @@project_id_count = []   #keeps track of project_id_count in array

  attr_reader :name, :project_id         #allows instance variables to be 'read'


  # .new method - creates instances of the TM::Project class
  # each @'value' is called an instance variable
  # these are the attributes which are specific to the instance
  def initialize(name)
    @name = name
    @project_id = @@project_id_count
    @@project_id_count += 1
  end

  # Resets the project_id_count so that it doesn't increment while testing
  # the 'self' means that it is a Class method
  # in other words, you do not have to use this method on an instance
  # rather, it can be used on a Class object
  def self.reset_class_variables
    @@project_id_count = 0
  end

end
