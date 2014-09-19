module PM
  def self.employees=(x)
    @employees_repo = x
  end

  def self.employees
    @employees_repo
  end

  def self.projects=(x)
    @projects_repo = x
  end

  def self.projects
    @projects_repo
  end

  def self.memberships=(x)
    @memberships_repo = x
  end

  def self.memberships
    @memberships_repo
  end
end

require_relative 'project_manager/entities/employee.rb'
require_relative 'project_manager/entities/project.rb'

require_relative 'project_manager/repositories/repo.rb'
require_relative 'project_manager/repositories/employees.rb'
require_relative 'project_manager/repositories/projects.rb'
require_relative 'project_manager/repositories/memberships.rb'

