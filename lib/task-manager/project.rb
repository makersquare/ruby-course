
class TM::Project #this means project class belongs to TM module...doing this sill help with class conflict names ex MKS::Project...creating a new onject would be p = TM::Project.new

  @@id_count
  attr_reader :name, :id
  attr_accessor :description

  def initialize(name)
    @name = name
    @@id_count += 1
    @id = @@id_count
    # @description = description
    # @priority = 1
  end

  def self.reset_class_variables
    @@id_count = 0
  end


  # def mark_task_complete

  # def change_priority(new_number)
  #   @priority = new_number
  # end

end
