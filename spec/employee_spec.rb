require 'spec_helper'

module TM
  describe 'employee' do

    it "can be created with a name" do
      emp1 = Employee.new("Bob")
      expect(emp1.name).to eq("Bob")
    end

    it "generates a unique id for each employee" do
      emp1 = Employee.new("Bob")
      emp2 = Employee.new("Sue")
      expect(emp2.id).to eq(emp1.id + 1)
    end

  end
end
