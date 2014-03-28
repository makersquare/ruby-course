describe TM::EmployeesInProject do
  before do
    @database = TM.database
  end

  it "gives employees in a project" do
    # Set up our data
    employee = @database.add_new_employee("parth")
    employee_two = @database.add_new_employee("john")
    project = @database.create_new_project("project name")
    @database.delegate_employee_to_project(employee.id, project.id)
    result = subject.run(:project_id => project.id)
    expect(result.success?).to eq true
    expect(result.employees.count).to eq(1)
    expect(result.project .name).to eq(project.name)
  end

  it "errors if project does not exist" do
    # Set up our data
    result = subject.run(:project_id => nil)
    expect(result.error).to eq :project_not_found
  end

  it "errors if no employees in project" do
    project = @database.create_new_project("project name")
    result = subject.run(:project_id => project.id)
    expect(result.error).to eq(:no_employees_in_project)
  end
end
