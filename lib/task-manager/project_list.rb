class TM::Project_list
  attr_accessor :projects

  def initialize
    @projects = []
  end

  def add_project(name)
    @projects << TM::Project.new(name)
  end

end
