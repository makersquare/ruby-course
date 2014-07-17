require 'spec_helper.rb'

describe TM::AddEmployeeToProject do
  before do
    @db = TM.db
    @project = @db.create_project("Test")
    @employee = @db.create_employee("Name")
  end

  it "adds an employee to a project" do
    result = subject.run({ :employee_id => @employee.employee_id, :project_id => @project.project_id })
    expect(@db.join_employees_projects[0]).to eq({employee_id: @employee.employee_id, project_id: @project.project_id})
    expect(result.success?).to eq(true)
  end

  it "returns error if project does not exist" do
    result = subject.run({ :employee_id => @employee.employee_id, :project_id => 1000 })
    expect(result.error?).to eq(true)
    expect(result.error).to eq :project_does_not_exist
  end

  it "returns error if employee does not exist" do
    result = subject.run({ :employee_id => 1000, :project_id => @project.project_id })
    expect(result.error?).to eq(true)
    expect(result.error).to eq :employee_does_not_exist
  end
end
