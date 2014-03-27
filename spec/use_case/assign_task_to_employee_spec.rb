require 'spec_helper.rb'
describe TM::AssignTaskToEmployee do
  before do
    @db = TM.db
    @project = @db.create_project("Test")
    @task = @db.create_task("New Task", 5, @project.project_id)
    @employee = @db.create_employee("Employee")
  end

  it "assigns a task to an employee" do
    result = subject.run({ :employee_id => @employee.employee_id, :task_id => @task.task_id })
    expect(result.success?).to eq(true)
    expect(result.task.employee_id).to eq(@employee.employee_id)
  end

  it "returns an error if task does not exist" do
    result = subject.run({ :employee_id => @employee.employee_id, :task_id => 9999 })
    expect(result.error?).to eq(true)
    expect(result.error).to eq :task_does_not_exist
  end

  it "returns an error if employee does not exist" do
    result = subject.run({ :employee_id => 9999, :task_id => @task.task_id })
    expect(result.error?).to eq(true)
    expect(result.error).to eq :employee_does_not_exist
  end
end
