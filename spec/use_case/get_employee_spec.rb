require 'spec_helper'

module TM
  describe GetEmployee do
    it "returns an error if the employee is not found" do
      result = GetEmployee.run(99)
      expect(result.success?).to eq(false)
      expect(result.error).to eq(:employee_not_found)
    end

    it "returns a project if it's found" do
      employee = TM::db.create_employee("Billy")
      result = GetEmployee.run(employee.id)
      expect(result.success?).to eq(true)
      expect(result[:employee].name).to eq("Billy")
    end
  end
end
