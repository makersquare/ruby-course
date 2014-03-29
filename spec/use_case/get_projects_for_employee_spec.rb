require 'spec_helper.rb'
describe TM::GetProjectsForEmployee do
  before do
    @db = TM.db
    @employee = @db.create_employee("Walter Johnson")
  end

  it "returns an error if employee does not exist" do
    result = subject.run({ :employee_id => 999 })
    expect(result.error?).to eq(true)
    expect(result.error).to eq(:employee_does_not_exist)
  end

  it "returns an error if employee has no projects" do
    result = subject.run({ :employee_id => @employee.employee_id })
    expect(result.error?).to eq(true)
    expect(result.error).to eq(:employee_has_no_projects)
  end

  it "returns an array of employee projects" do
    project1 = @db.create_project("Project 1")
    project2 = @db.create_project("Project 2")
    @db.add_employee_to_project(@employee.employee_id, project1.project_id)
    @db.add_employee_to_project(@employee.employee_id, project2.project_id)

    result = subject.run({ :employee_id => @employee.employee_id })
    expect(result.success?).to eq(true)
    expect(result.projects.size).to eq(2)
    expect(result.projects[1].name).to eq("Project 2")
  end
end
