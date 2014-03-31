require 'spec_helper'

describe TM::ShowEmpsProjects do

  it "shows projects in which employee is participating" do
    # Set up our data
    proj1 = TM.db.create_project("Business...man")
    emp = TM.db.create_emp('Wiz Khalifa')
    proj = TM.db.update_project(proj1.id, {eid: emp.id})

    result = subject.run({:employee_id => emp.id})
    expect(result.success?).to eq true
    expect(result.projects.length).to eq(1)
    expect(result.projects[0].name).to eq("Business...man")
  end

  it "errors if the employee does not exist" do
    # Set up our data
    result = subject.run({ :employee_id => 0 })
    expect(result.error?).to eq true
    expect(result.error).to eq :employee_does_not_exist
  end

  it "errors if employee is not assigned to any projects" do
    proj1 = TM.db.create_project("Make Projects")
    emp = TM.db.create_emp('Lee McHuman')

    result = subject.run({:employee_id => emp.id})
    expect(result.error?).to eq true
    expect(result.error).to eq :employee_is_not_assigned_to_any_projects
  end
end
