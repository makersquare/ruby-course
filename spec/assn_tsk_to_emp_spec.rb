require 'spec_helper'

describe TM::AssignTaskToEmployee do

  it "adds a task to an employee" do
    # Set up our data
    new_proj = TM.db.create_project("Bossing Bob Around")
    task = TM.db.create_task(new_proj.id, 'make me a sandwich', 4)
    emp = TM.db.create_emp('Bob')
    proj = TM.db.update_project(new_proj.id, {eid: emp.id})

    result = subject.run({ :task_id => task.id, :employee_id => emp.id })
    expect(result.success?).to eq true
    expect(result.task.eid).to eq(emp.id)
  end

  it "errors if the task does not exist" do
    # Set up our data
    emp = TM.db.create_emp('Bob')

    result = subject.run({ :task_id => 999, :employee_id => emp.id })
    expect(result.error?).to eq true
    expect(result.error).to eq :task_does_not_exist
  end
end
