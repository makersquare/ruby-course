require 'spec_helper'

describe TM::AssignTaskToEmployee do
  it 'successfully assigns a task to an employee' do
    task = TM.db.add_task_to_project('a new task', 1, 1)
    employee = TM.db.create_employee('bob')

    result = subject.run(tid: task.id, eid: employee.id)

    expect(result.success?).to eq(true)
    expect(result.assigned_task.eid).to eq(employee.id)

  end
end
