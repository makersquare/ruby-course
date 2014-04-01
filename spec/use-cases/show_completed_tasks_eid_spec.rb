require 'spec_helper'
describe TM::ShowCompletedTasksEID do
  before do
    @db = TM.DB
  end

  it "shows completed tasks for employee" do
    project = @db.create_project('project')
    employee = @db.create_employee('bob')
    task = @db.add_task_to_project('description', 1, project.id)
    assigned = @db.assign_task(task.id, employee.id)
    completed_task = @db.task_complete(task.id)
    result = subject.run(:eid => employee.id)
    expect(result.success?).to eq true
    expect(result.tasks.first.description).to eq task.description
  end

  it 'fails if no id is provided' do
    result = subject.run({:eid => nil})
    expect(result.error?).to eq true
    expect(result.error).to eq :provide_a_emp_id
  end

  it 'fails if project does not exist' do
    emp = @db.create_employee('bob')
    result = subject.run(:eid => 10000)
    expect(result.error?).to eq true
    expect(result.error).to eq :employee_doesnt_exist
  end
end
