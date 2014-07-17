# lib/use_cases/assign_task_to_employee
module Timeline
  class GetTeams < UseCase
    def run(inputs=nil)
      teams = Timeline.db.all_teams()
      return failure(:team_does_not_exist) if teams.nil?

      # NOT SHOWN: Modify task to assign to employee

      # Return a success with relevant data
      success :teams => teams

    end
  end
end

# result = MyApp::AssignTaskToEmployee.run({:task_id => 1, :employee_id => 2})

# # in case of failure where task does not exist
# result.success? # false
# result.error # :task_does_not_exist

# # in case of success - no failures

# result.success? # true
# result.task # get the task object
# result.employee # get the employee object
