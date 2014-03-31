describe TM::ProjectsOfEmployee do
  before do
    @database = TM.database
  end

  it "gives projects of an employee" do
    # Set up our data
    employee = @database.add_new_employee("parth")
    project = @database.create_new_project("project name")
    project_two = @database.create_new_project("project name")
    @database.delegate_employee_to_project(employee.id, project.id)
    @database.delegate_employee_to_project(employee.id, project_two.id)
    result = subject.run(:employee_id => employee.id)
    expect(result.success?).to eq true
    expect(result.projects.count).to eq(2)
    expect(result.employee.name).to eq(employee.name)
  end

  it "errors if employee not found" do
    # Set up our data
    result = subject.run(:employee_id => nil)
    expect(result.error).to eq :employee_not_found
  end

  it "errors if no projects of employee" do
    employee = @database.add_new_employee("parth")
    result = subject.run(:employee_id => employee.id)
    expect(result.error).to eq(:no_projects_of_employee)
  end
end
