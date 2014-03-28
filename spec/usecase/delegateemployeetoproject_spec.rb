describe TM::DelegateEmployeeToProject do
  before do
    @database = TM.database
  end

  it "allows you to delegate an employee to a project" do
   employee = @database.add_new_employee("project")
    project = @database.create_new_project("project")
    result = subject.run({:employee_id => employee.id, :project_id => project.id})
    expect(result.success?).to eq(true)
  end

  it "gives you an error if employee not exist" do
    project = @database.create_new_project("project")
    result = subject.run({:employee_id => nil, :project_id => project.id})
    expect(result.error).to eq (:employee_not_found)
  end

  it "gives you an error if project does not exist" do
    employee = @database.add_new_employee("project")
    result = subject.run({:employee_id => employee.id, :project_id => nil})
    expect(result.error).to eq (:project_not_found)
  end
end
