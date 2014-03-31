require 'spec_helper'

module TM
  describe 'CreateEmployee'  do
    it "creates an employee" do
      result = TM::CreateEmployee.run("Bob")
      expect(result.success?).to eq(true)
      expect(TM::db.get_employee(result[:employee].id).id).to eq(result[:employee].id)
    end
  end
end
