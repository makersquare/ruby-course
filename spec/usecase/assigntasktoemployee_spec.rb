describe TM::AssignTaskToEmployee do
  before do
    @database = TM.database
  end

  it "allows you to delegate an employee to a task" do
    employee = @database.add_new_employee("project")
    project = @database.create_new_project("project")
    task = @database.add_task(project.id, 5, "yellow task")
    result = subject.run({:employee_id => employee.id, :task_id => task.id})
    expect(result.error).to eq(:employee_not_assigned_to_project)
    expect(result.success?).to eq(false)
  end

  it "gives you an error if employee not exist" do
    project = @database.create_new_project("project")
    task = @database.add_task(project.id, 5, "yellow task")
    result = subject.run({:employee_id => nil, :task_id => task.id})
    expect(result.error).to eq (:employee_not_found)
  end

  it "gives you an error if task does not exist" do
    employee = @database.add_new_employee("project")
    result = subject.run({:employee_id => employee.id, :task_id => nil})
    expect(result.error).to eq (:task_not_found)
  end

  it "won't let you assign an employee already assigned a task" do
    employee = @database.add_new_employee("project")
    project = @database.create_new_project("project")
    task = @database.add_task(project.id, 5, "yellow task")
    task.employee_id = employee.id
    result = subject.run({:employee_id => employee.id, :task_id => task.id})
    expect(result.error).to eq(:task_already_assigned)
  end

 it "works" do
    employee = @database.add_new_employee("project")
    project = @database.create_new_project("project")
    task = @database.add_task(project.id, 5, "yellow task")
    @database.delegate_employee_to_project(employee.id, project.id)
    result = subject.run({:employee_id => employee.id, :task_id => task.id})
    expect(result.success?).to eq(true)
  end

end













