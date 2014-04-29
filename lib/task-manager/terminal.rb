class TM::TerminalClient

  attr_reader :projects

  def initialize
    @projects = []
  end

  def create_project(name)
    @projects << TM::Project.new(name)
  end

end
