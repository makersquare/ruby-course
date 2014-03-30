
# Create our module. This is so other files can start using it immediately
require 'ostruct'
module TM
  def self.database
    @database ||= Database.new
  end
  class UseCase
    # Convenience method that lets us call `.run` directly on the class
    def self.run(inputs={})
      self.new.run(inputs)
    end

    def failure(error_sym, data={})
      UseCaseFailure.new(data.merge :error => error_sym)
    end

    def success(data={})
      UseCaseSuccess.new(data)
    end
  end

  class UseCaseFailure < OpenStruct
    def success?
      false
    end
    def error?
      true
    end
  end

  class UseCaseSuccess < OpenStruct
    def success?
      true
    end
    def error?
      false
    end
  end
end

# Require all of our project files

require_relative 'task-manager/task.rb'
require_relative 'task-manager/project.rb'
require_relative 'task-manager/database.rb'
require_relative 'task-manager/employee.rb'
require_relative 'usecase/createproject.rb'
require_relative 'usecase/AddTaskToProject.rb'
require_relative 'usecase/listprojects.rb'
require_relative 'usecase/createemployee.rb'
require_relative 'usecase/delegateemployeetoproject.rb'
require_relative 'usecase/assigntasktoemployee.rb'
require_relative 'usecase/marktaskascomplete.rb'
require_relative 'usecase/listemployees.rb'
require_relative 'usecase/employeesinproject.rb'
require_relative 'usecase/projectsofemployee.rb'
require_relative 'usecase/historyofproject.rb'
require_relative 'usecase/remainingprojecttasks.rb'
require_relative 'usecase/remainingemployeetasks.rb'
require_relative 'usecase/historyofemployee'
