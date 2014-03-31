require 'spec_helper'

describe TM::AddEmployeeToProject do

  it "adds an employee to a project" do
    # Set up our data
    new_proj = TM.db.create_project("Building a cabin")
    emp = TM.db.create_emp('Sophie')
    proj = TM.db.update_project(new_proj.id, {eid: emp.id})

    result = subject.run({ :project_id => new_proj.id, :employee_id => emp.id })
    expect(result.success?).to eq true
    expect(result.project.id).to eq(new_proj.id)
    expect(result.employee.name).to eq("Sophie")
  end

  it "errors if project does not exist" do
    # Set up our data
    emp = TM.db.create_emp('Bob')

    result = subject.run({ :project_id => 0, :employee_id => emp.id })
    expect(result.error?).to eq true
    expect(result.error).to eq :project_does_not_exist
  end

  it "errors if employee does not exist" do
     # Set up our data
    proj = TM.db.create_project('Build a boat')

    result = subject.run({ :project_id => proj.id, :employee_id => 0 })
    expect(result.error?).to eq true
    expect(result.error).to eq :employee_does_not_exist
  end
end
