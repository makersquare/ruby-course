require 'spec_helper.rb'
require 'pry'

describe "TM::Employee" do
  describe "#initialize" do
    it "an employee can be created with a name" do
      employee1 = TM::Employee.new("Kobe")
      expect(TM::Employee).to be_a(Class)
      expect(employee1.name).to eq("Kobe")
    end

    it "an employee can be created with a unique ID number" do
      employee1 = TM::Employee.new("Jordan")
      employee2 = TM::Employee.new("Pippen")
      expect(employee1.id).to eq(1)
      expect(employee2.id).to eq(2)
    end
  end

end
