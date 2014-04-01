require 'spec_helper'

module TM
  describe 'Get Employee Projects' do
    it "returns an error if the employee is not found" do
      result = GetEmployeeProjects.run(99)
      expect(result.success?).to eq(false)
      expect(result.error).to eq(:employee_not_found)
    end

    it "returns a list of an employee's projects" do
      proj1 = TM::db.create_project("kill bob")
      proj2 = TM::db.create_project("kill Tom")
      emp1 = TM::db.create_employee("Bill")
      TM::db.assign({ project_id: proj1.id, employee_id: emp1.id })
      TM::db.assign({ project_id: proj2.id, employee_id: emp1.id })
      result = GetEmployeeProjects.run(emp1.id)
      expect(result.success?).to eq(true)
      expect(result[:employee_projects].size).to eq(2)
    end
  end
end
