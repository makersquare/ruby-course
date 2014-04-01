require 'spec_helper'

describe TM::ShowEmployeesInProject do

  it "shows all employees participating in the project" do
    # Set up our data
    new_proj = TM.db.create_project("Mega Project")
    emp1 = TM.db.create_emp("Busy McWorkhard")
    emp2 = TM.db.create_emp("Tinariwen Rocks")

    TM.db.update_project(new_proj.id, {eid: emp1.id})
    TM.db.update_project(new_proj.id, {eid: emp2.id})

    result = subject.run({ :project_id => new_proj.id })
    expect(result.success?).to eq true
    expect(result.employees.length).to eq(2)
  end

  it "errors if the project does not exist" do
    # Set up our data
    result = subject.run({:project_id => 0 })
    expect(result.error?).to eq true
    expect(result.error).to eq :project_does_not_exist
  end

  it "errors if there are no employees in the project" do
    new_proj = TM.db.create_project("Getting fit")
    result = subject.run({:project_id => new_proj.id})
    expect(result.error?).to eq true
    expect(result.error).to eq :no_employees_in_project
  end
end
