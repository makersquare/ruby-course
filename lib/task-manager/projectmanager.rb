class TM::ProjectManager
  attr_reader :projects

  def initialize
    @projects = []
  end

  def add_project(project)
    @projects << project
  end

  def get_project(project_id)
    @projects.each do |project|
      if project.id == project_id
        return project
      end
    end
    nil
  end

  def list_all
    @projects.each do |project|
      puts "Name: #{project.name} - ID: #{project.id}"
      puts "Percentage Finished - #{project.percentage_complete}%"
      puts "Percentage Tasks Overdue - #{project.overdue_tasks}%"
    end
  end
end
