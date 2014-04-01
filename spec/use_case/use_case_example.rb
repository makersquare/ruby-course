# successful use case
result = TM::AssignTaskToEmployee.run(:task_id => 4, :employee_id => 33)
result = success(:task => task, :employee => emp)

# failure use case
result = failure(:task_does_not_exist)

module TM
  class AssignTaskToEmployee < UseCase

    # assignTasktoEmployee inherents methods from UseCase
    # thus inherents def self.run which is NOT the same as def run
    # get's new self.run method
    def run(inputs)
      task = TM.db.get_task(inputs[:task_id])
      return failure(:task_does_not_exist) if task.nil?

      emp = TM.db.get_employee(inputs[:employee_id])
      return failure(:employee_does_not_exist) if emp.nil?

      # NOT SHOWN: Modify task to assign to employee
      # assign_task_to_emp(inputs[:task_id], inputs[:employee_id])

      TM.db.assign_task_emp(inputs[:task_id],inputs[:employee_id])

      # Return a success with relevant data
      success :task => task, :employee => emp
    end

    # def assign_task_to_emp(tid, eid)
    #   task = TM.db.get_task(tid)
    #   task.eid = eid
    # end
  end
end

# success(:employee => employee, :employee_projects => employee_projects)


result = TM::AssignTaskToEmployee.run(:task_id => 4, :employee_id => 33)

result = success(:task => task, :employee => emp)
result = UseCaseSuccess.new(:task => task,:employee=>emp)
result.success?
#=> true       # openstruct, dot notation, can do .key, or in this case .task
result.task  # give me task object
#=> task object
result.employee # -->> employee object

# failure use case
result = failure(:task_does_not_exist)
result.error ==> error_sym -- points to -> :task_does_not_exist
# => :task_does_not_exist
result.error?
# => true
module TM

  class UseCase
    # Convenience method that lets us call `.run` directly on the class
    def self.run(inputs)
      self.new.run(inputs)
    end

    def failure(error_sym, data={})
      UseCaseFailure.new(data.merge(:error => error_sym))
      # UseCaseFailure.new({ :error => error_sym })

    end

    def success(data={})
      UseCaseSuccess.new(data) # creates UseCaseSuccess Object
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
