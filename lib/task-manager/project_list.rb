class TM::ProjectList
  attr_reader :project_list

  def initialize
    @project_list = []
  end

  def create_project(name)
    @project_list << TM::Project.new(name)
  end

  def get_project(project_id)
    match = @project_list.select {|x| x.project_id = project_id}

    return match[0]

  end

end

