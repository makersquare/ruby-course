
module TM
class Project

  attr_reader :id, :emp_ids
  attr_accessor :name

  @@num_projects = 0

  def initialize(name)
    @name = name
    @@num_projects +=1
    @id = @@num_projects
    # @emp_ids {eid=> true, eid => true}
    @emp_ids = {}
  end

  def add_emp(eid)
    @emp_ids[eid] = true
  end

end
end

# Client should be able to add/create new project
# Project manager should be renamed to Terminal Client

# used "module TM" above because keyword module re-opens the module, whereas
# "TM::some_class" (the scope operator) just indicates that the specified
# class is within the module
