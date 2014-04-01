require 'spec_helper'

describe TM::ListAllEmployees do

  it "lists all employees" do
    # Set up our data
    emp1 = TM.db.create_emp('Marcus')
    emp2 = TM.db.create_emp('Joan')
    emp3 = TM.db.create_emp('Ralph')

    result = subject.run({})
    expect(result.success?).to eq true
    expect(result.all_employees).to be_a(Hash)
    expect(result.all_employees[emp2.id].name).to eq("Joan")
  end

  it "errors if there are no employees" do
    # Set up our data
    result = subject.run({})
    expect(result.error?).to eq true
    expect(result.error).to eq :no_employees_exist
  end
end
