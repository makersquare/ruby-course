require 'spec_helper'

module TM
  describe "List Employees" do
    it "provides a list of all employees" do
      emp1 = TM::db.create_employee("Bob")
      emp2 = TM::db.create_employee("Bill")
      emp3 = TM::db.create_employee("Jimmy")
      result = ListEmployees.run
      expect(result.success?).to eq(true)
      expect(result[:employees_list].size).to eq(3)
    end
  end
end
