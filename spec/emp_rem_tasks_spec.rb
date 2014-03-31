require 'spec_helper'

describe TM::ShowEmployeeRemainingTasks do

  it "shows an employee's remaining tasks" do
    # Set up our data
    new_proj = TM.db.create_project("Iron a shirt")
    emp = TM.db.create_emp('Jeff')
    TM.db.update_project(new_proj.id, {eid: emp.id})

    task1 = TM.db.create_task(new_proj.id, 'buy iron', 1)
    task2 = TM.db.create_task(new_proj.id, 'buy shirt', 5)
    TM.db.update_task(task1.id, {eid:emp.id})
    TM.db.update_task(task2.id, {eid:emp.id})

    result = subject.run({:employee_id => emp.id})
    expect(result.success?).to eq true
    expect(result.task[task1.id][0].description).to eq("buy iron")
    expect(result.employee.name).to eq("Jeff")
  end

  it "errors if the employee does not exist" do
    # Set up our data
    result = subject.run({:employee_id => 0 })
    expect(result.error?).to eq true
    expect(result.error).to eq :employee_does_not_exist
  end

  it "errors if the employee has no incomplete tasks" do
    new_proj = TM.db.create_project("Stuff")
    emp = TM.db.create_emp('Personette McLady')
    TM.db.update_project(new_proj.id, {eid: emp.id})

    task1 = TM.db.create_task(new_proj.id, 'I dunno', 2)
    task2 = TM.db.create_task(new_proj.id, 'things', 5)
    TM.db.update_task(task1.id, {complete:true})
    TM.db.update_task(task2.id, {complete:true})

    result = subject.run({:employee_id => emp.id})
    expect(result.error?).to eq true
    expect(result.error).to eq(:employee_has_no_incomplete_tasks)
  end
end
