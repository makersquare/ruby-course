require 'spec_helper.rb'
describe TM::GetEmployeesOnProject do
  before do
    @db = TM.db
    @project = @db.create_project("Test Project")
  end

  it "returns an error if project does not exist" do
    result = subject.run({ :project_id => 999 })
    expect(result.error?).to eq(true)
    expect(result.error).to eq(:project_does_not_exist)
  end

  it "returns an error if there are no employees on project" do
    result = subject.run({ :project_id => @project.project_id })
    expect(result.error?).to eq(true)
    expect(result.error).to eq(:no_employees_on_project)
  end

  it "returns all employees on project" do
    employee1 = @db.create_employee("Employee 1")
    employee2 = @db.create_employee("Employee 2")
    employee3 = @db.create_employee("Employee 3")

    TM::AddEmployeeToProject.run({ :employee_id => employee1.employee_id, :project_id => @project.project_id })
    TM::AddEmployeeToProject.run({ :employee_id => employee2.employee_id, :project_id => @project.project_id })
    TM::AddEmployeeToProject.run({ :employee_id => employee3.employee_id, :project_id => @project.project_id })

    result = subject.run({ :project_id => @project.project_id})

    expect(result.success?).to eq(true)
    expect(result.employees[2].name).to eq("Employee 3")
  end
end
