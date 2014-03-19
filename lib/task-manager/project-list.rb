require_relative '../task-manager.rb'

class TM::ProjectList

  attr_reader :projects

  def initialize
    @projects = []
  end

  def create_project(title)
    proj = TM::Project.new(title)

    @projects << proj
  end

end