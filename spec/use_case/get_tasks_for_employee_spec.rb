require 'spec_helper.rb'
describe TM::GetTasksForEmployee do
  before do
    @db = TM.db
    @employee = @db.create_employee("Bill Johnson")
  end

  it "returns an error if employee does not exist" do
    result = subject.run({ :employee_id => 999 })
    expect(result.error?).to eq(true)
    expect(result.error).to eq(:employee_does_not_exist)
  end

  it "returns an error if employee has no tasks" do
    result = subject.run({ :employee_id => @employee.employee_id })
    expect(result.error?).to eq(true)
    expect(result.error).to eq(:employee_has_no_tasks)
  end

  it "returns tasks for employee" do
    project = @db.create_project("name")
    task1 = @db.create_task("fun task", 5, project.project_id)
    task2 = @db.create_task("other task", 4, project.project_id)
    task1.employee_id = @employee.employee_id
    task2.employee_id = @employee.employee_id

    result = subject.run({ :employee_id => @employee.employee_id })

    expect(result.success?).to eq(true)
    expect(result.tasks.size).to eq(2)
    expect(reulst.tasks[1].description).to eq("other task")
  end
end
