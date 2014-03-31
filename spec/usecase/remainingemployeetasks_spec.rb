describe TM::RemainingOfEmployee do
  before do
    @database = TM.database
  end

  it "gives you back employee incomplete tasks" do
    # Set up our data
    project = @database.create_new_project("project")
    task = @database.add_task(project.id, 5, "yellow task")
    employee = @database.add_new_employee("Parth")
    task.employee_id = employee.id
    result = subject.run( :employee_id => employee.id )
     expect(result.success?).to eq true
  end

  it "errors if no incomplete tasks are found" do
    project = @database.create_new_project("project")
    task = @database.add_task(1, 5, "yellow task")
    employee = @database.add_new_employee("Parth")
    task.employee_id = employee.id
    task.status = 'complete'
    result = subject.run({ :employee_id => employee.id })
    expect(result.success?).to eq false
    expect(result.error).to eq(:no_remaining_tasks_found)
  end

  it "errors if no employee is found" do
     result = subject.run({ :employee_id => nil })
     expect(result.success?).to eq false
    expect(result.error).to eq(:employee_not_found)
  end
end


