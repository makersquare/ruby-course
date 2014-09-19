require 'project_manager'

PM::Repos.adapter = 'mtm_exercise'

PM.projects = PM::Repos::Projects.new
PM.employees = PM::Repos::Employees.new
PM.memberships = PM::Repos::Memberships.new
