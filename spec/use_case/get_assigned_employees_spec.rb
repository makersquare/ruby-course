require 'spec_helper'

module TM

  describe 'GetAssignedEmployees' do
    it "returns an error if the project is not found" do
      result = TM::GetAssignedEmployees.run({ project_id: 99 })
      expect(result.success?).to eq(false)
      expect(result.error).to eq(:project_not_found)
    end

    it "returns an error if the task is not found" do
      result = TM::GetAssignedEmployees.run({ task_id: 99 })
      expect(result.success?).to eq(false)
      expect(result.error).to eq(:task_not_found)
    end

    it "returns a list of employees assigned to tasks or projects" do
      proj1 = TM::db.create_project("Maim Sue")
      task1 = TM::db.create_task({ project_id: proj1.id,
                                      description: "Buy sword",
                                      priority: 4 })
      emp1 = TM::db.create_employee("Billy")
      emp2 = TM::db.create_employee("Bob")
      emp3 = TM::db.create_employee("John")
      emp4 = TM::db.create_employee("Jacob")
      TM::db.assign({ project_id: proj1.id, employee_id: emp1.id })
      TM::db.assign({ project_id: proj1.id, employee_id: emp2.id })
      TM::db.assign({ project_id: proj1.id, employee_id: emp3.id })
      TM::db.assign({ project_id: proj1.id, employee_id: emp4.id })

      TM::db.assign({ task_id: task1.id, employee_id: emp1.id })
      TM::db.assign({ task_id: task1.id, employee_id: emp2.id })
      TM::db.assign({ task_id: task1.id, employee_id: emp3.id })

      result1 = GetAssignedEmployees.run({ project_id: proj1.id })
      expect(result1.success?).to eq(true)
      expect(result1[:assigned_employees].size).to eq(4)

      result2 = GetAssignedEmployees.run({ task_id: task1.id })
      expect(result2.success?).to eq(true)
      expect(result2[:assigned_employees].size).to eq(3)
    end



  end
end
