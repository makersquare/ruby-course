require 'spec_helper'

module TM
  describe "Assign" do

    describe "project/employee passed" do
      it "returns an error if the project does not exist" do
        emp1 = TM::db.create_employee("Sue")
        result = TM::Assign.run({employee_id: emp1.id, project_id: 99 })
        expect(result.success?).to eq(false)
        expect(result.error).to eq(:project_not_found)
      end

      it "returns an error if the employee does not exist" do
        proj1 = TM::db.create_project("Kill Bob")
        result = TM::Assign.run({employee_id: 99, project_id: proj1.id })
        expect(result.success?).to eq(false)
        expect(result.error).to eq(:employee_not_found)
      end

      it "assigns an employee to a project if they both exist" do
        emp1 = TM::db.create_employee("Sue")
        proj1 = TM::db.create_project("Kill Bob")
        result = TM::Assign.run({employee_id: emp1.id, project_id: proj1.id })
        expect(result.success?).to eq(true)
        expect(TM::db.assigned?({employee_id: emp1.id, project_id: proj1.id })).to eq(true)
      end

    end

    describe "employee/task passed" do
      it "returns an error if the employee is not assigned to the task's project" do
        emp1 = TM::db.create_employee("Sue")
        proj1 = TM::db.create_project("Kill Bob")
        task1 = TM::db.create_task({description:"Buy Gun",
                                      priority: 5,
                                      project_id: proj1.id})
        result = TM::Assign.run({employee_id: emp1.id, task_id: task1.id })
        expect(result.success?).to eq(false)
        expect(result.error).to eq(:employee_not_assigned_to_project)
      end

      it "returns an error if the employee does not exist" do
        proj1 = TM::db.create_project("Kill Bob")
        task1 = TM::db.create_task({description:"Buy Gun",
                                      priority: 5,
                                      project_id: proj1.id})
        result = TM::Assign.run(task_id:task1.id, employee_id: 99)
      end

      it "returns an error if the task does not exist" do
        emp1 = TM::db.create_employee("Sue")
        proj1 = TM::db.create_project("Kill Bob")
        result = TM::Assign.run(task_id: 99, employee_id: emp1.id)
      end
    end
  end
end
