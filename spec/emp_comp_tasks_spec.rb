require 'spec_helper'

describe TM::ShowEmployeeCompleteTasks do

  it "shows an employee's complete tasks" do
    # Set up our data
    new_proj = TM.db.create_project("Being a motorcycle stuntperson")
    emp = TM.db.create_emp('Evel')
    TM.db.update_project(new_proj.id, {eid: emp.id})

    task1 = TM.db.create_task(new_proj.id, 'eat sandwiches', 4)
    task2 = TM.db.create_task(new_proj.id, 'ride sweet bikes', 2)
    TM.db.update_task(task1.id, {complete: true, eid:emp.id})

    result = subject.run({:employee_id => emp.id})
    expect(result.success?).to eq true
    expect(result.task[task1.id][0].description).to eq("eat sandwiches")
    expect(result.employee.name).to eq("Evel")
  end

  it "errors if the employee does not exist" do
    # Set up our data
    result = subject.run({:employee_id => 0 })
    expect(result.error?).to eq true
    expect(result.error).to eq :employee_does_not_exist
  end

  it "errors if the employee has no complete tasks" do
    new_proj = TM.db.create_project("Kicking butt, taking names")
    emp = TM.db.create_emp('Mary Madd')
    TM.db.update_project(new_proj.id, {eid: emp.id})

    task1 = TM.db.create_task(new_proj.id, 'wear leather jackets', 5)
    task2 = TM.db.create_task(new_proj.id, 'never follow rules', 1)

    result = subject.run({:employee_id => emp.id})
    expect(result.error?).to eq true
    expect(result.error).to eq(:employee_has_no_complete_tasks)
  end

end
