require 'spec_helper'

describe 'Database' do

  before do
    @db = TM::DB.new
  end

  it "exists" do
    expect(TM::DB).to be_a(Class)
  end

  it "can create a new task with pid, description and priority" do
    new_task = @db.create_task(3, "Buy umbrella", 2)
    expect(new_task.projID).to eq(3)
    expect(new_task.description).to eq("Buy umbrella")
    expect(new_task.priority).to eq(2)
  end

  it "can retrieve tasks" do
    new_task = @db.create_task(5, "Clean car", 4)
    task = @db.get_task(new_task.id)
    expect(task.id).to eq(new_task.id)
    expect(task.description).to eq("Clean car")
  end

  it "can update tasks" do
    new_task = @db.create_task(2, "Organize file system", 3)
    stuff = {complete: true, description:"Update file system", priority: 5}
    updates = @db.update_task(new_task.id, stuff)
    expect(new_task.complete).to eq(true)
    expect(updates.description).to eq("Update file system")
    expect(updates.priority).to eq(5)
  end

  it "can delete tasks" do
    new_task = @db.create_task(11, "Clean up fridge", 4)
    @db.delete_task(new_task.id)
    result = @db.get_task(new_task.id)
    expect(result).to eq(nil)
  end

  it "can create a new project with a name and id" do
    new_proj = @db.create_project("Affordable Nuclear Fusion")
    expect(new_proj.name).to eq("Affordable Nuclear Fusion")
    expect(new_proj.id).to be_a(Fixnum)
  end

  it "can retrieve projects" do
    new_proj = @db.create_project("Get rich")
    got_proj = @db.get_project(new_proj.id)
    expect(got_proj.name).to eq(new_proj.name)
  end

  it "can update project names" do
    new_proj = @db.create_project("Plant a garden")
    updates = {name: "Get haircut"}
    updated_proj = @db.update_project(new_proj.id, updates)
    expect(updated_proj.name).to eq("Get haircut")
  end


  it "can delete projects" do
    new_proj = @db.create_project("Pick up dry cleaning")
    @db.delete_project(new_proj.id)
    result = @db.get_project(new_proj.id)
    expect(result).to eq(nil)
  end

  it "can return all tasks in a project" do
    new_proj = @db.create_project("Compete in the UFC")
    task1 = @db.create_task(new_proj.id, "Train hard", 3)
    task2 = @db.create_task(new_proj.id, "Train harder", 1)
    task3 = @db.create_task(new_proj.id, "Fight!", 5)
    updates = {complete: true}
    updated_task2 = @db.update_task(task2.id, updates)
    all_tasks = @db.get_all_tasks(new_proj.id)
    expect(all_tasks).to be_a(Array)
    expect(all_tasks.count).to eq(3)
  end

  it "can return an array of all complete tasks by creation date" do
    new_proj = @db.create_project("After Work Errands")
    task1 = @db.create_task(new_proj.id, "Wash car", 3)
    task2 = @db.create_task(new_proj.id, "Buy groceries", 5)
    task3 = @db.create_task(new_proj.id, "Get haircut", 1)
    updates = {complete:true}
    updated_task1 = @db.update_task(task1.id, updates)
    updated_task3 = @db.update_task(task3.id, updates)
    comp_arr = @db.sort_comp_tasks(new_proj.id)
    expect(comp_arr).to be_a(Array)
    expect(comp_arr[1].description).to eq("Get haircut")
  end

  it "can return a list of a project's incomplete tasks sorted by priority and creation date" do
    new_proj = @db.create_project("Build a spaceship")
    task1 = @db.create_task(new_proj.id, "Get abducted by aliens", 1)
    task2 = @db.create_task(new_proj.id, "Give them expensive gifts", 3)
    task3 = @db.create_task(new_proj.id, "Ask them how to build a spaceship", 2)
    task4 = @db.create_task(new_proj.id, "Build spaceship", 1)
    task5 = @db.create_task(new_proj.id, "The end", 3)
    updates = {complete: true}
    @db.update_task(task5.id, updates)
    result = @db.sort_inc_tasks(new_proj.id)
    expect(result).to be_a(Array)
    expect(result.count).to eq(4)

    expect(result[1].description).to eq("Build spaceship")
    expect(result[2].description).to eq("Ask them how to build a spaceship")
  end

  it "can create an employee with name and id" do
    new_emp = @db.create_emp("Isaac Newton")
    expect(new_emp.name).to eq("Isaac Newton")
    expect(new_emp.id).to be_a(Fixnum)
  end

  it "can retrieve employees" do
    new_emp = @db.create_emp("Albert Einstein")
    got_emp = @db.get_emp(new_emp.id)
    expect(got_emp.name).to eq(new_emp.name)
  end

  it "can update employee information" do
    new_emp = @db.create_emp("Loren Laffler")
    updated_emp = @db.update_emp(new_emp.id, "Lauren Loffler")
    expect(updated_emp.name).to eq("Lauren Loffler")
  end

  it "can delete employees" do
    new_emp = @db.create_emp("John Darnielle")
    @db.delete_emp(new_emp.id)
    result = @db.get_emp(new_emp.id)
    expect(result).to eq(nil)
  end

  it "can add an employee to a project" do
    new_proj = @db.create_project("Smash Pumpkins")
    new_emp = @db.create_emp("Billy Corgan")
    updates = {eid: new_emp.id}
    proj_assigned = @db.update_project(new_proj.id, updates)
    proj_emps = proj_assigned.emp_ids
    expect(proj_emps[new_emp.id]).to eq(true)
  end

  it "will only assign tasks to employees participating in project" do
    new_proj = @db.create_project("Build a bicycle")
    emp1 = @db.create_emp("Lee Rhoads")
    emp2 = @db.create_emp("Alex Pedal")

    proj_updates = {eid: emp2.id}
    @db.update_project(new_proj.id, proj_updates)

    task1 = @db.create_task(new_proj.id, "Purchase wrench", 1)
    task2 = @db.create_task(new_proj.id, "Buy wheels", 4)

    task_updates = {eid: emp2.id}
    task_assigned = @db.update_task(task1.id, task_updates)
    expect(task_assigned.eid).to eq(emp2.id)

    not_assigned = @db.update_task(task2.id, {eid:emp1.id})
    expect(not_assigned).to eq(nil)
  end

  it "can get all remaining tasks for an employee" do
    new_proj = @db.create_project("Go nuts")
    task1 = @db.create_task(new_proj.id, "w00t", 1)
    task2 = @db.create_task(new_proj.id, "oh yeah!", 4)
    task3 = @db.create_task(new_proj.id, "sweeeeet", 3)
    emp = @db.create_emp("Who O'What")

    proj_updates = {eid: emp.id}
    @db.update_project(new_proj.id, proj_updates)

    task_updates = {eid: emp.id}
    @db.update_task(task1.id, task_updates)
    @db.update_task(task2.id, task_updates)
    @db.update_task(task3.id, task_updates)

    result = @db.get_inc_emp_tasks(emp.id)
    expect(result[task2.id][0].description).to eq("oh yeah!")
    expect(result[task3.id][1].name).to eq("Go nuts")
  end

  it "can get all complete tasks for an employee" do
    new_proj = @db.create_project("Beat Kobayashi in an Eating Contest")
    task1 = @db.create_task(new_proj.id, "EAT!", 1)
    task2 = @db.create_task(new_proj.id, "Eat MOAR", 4)
    task3 = @db.create_task(new_proj.id, "FEWD!", 3)
    emp = @db.create_emp("Cardiac O'Rest")

    proj_updates = {eid: emp.id}
    @db.update_project(new_proj.id, proj_updates)

    @db.update_task(task1.id, {eid: emp.id, complete: true})
    @db.update_task(task2.id, {eid: emp.id})
    @db.update_task(task3.id, {eid: emp.id, complete:true})

    result = @db.get_comp_emp_tasks(emp.id)
    expect(result.length).to eq(2)
    expect(result[task1.id][0].description).to eq("EAT!")
    expect(result[task3.id][1].name).to eq("Beat Kobayashi in an Eating Contest")
  end

  it "can return a list of all projects" do
    proj1 = @db.create_project("Go hard")
    proj2 = @db.create_project("Be baller")
    proj3 = @db.create_project("Get mad stacks")

    result = @db.get_all_proj
    expect(result).to be_a(Array)
    expect(result.length).to eq(3)
  end

  it "can return all of the employees participating in a project" do
    proj1 = @db.create_project("Make giant battle robots")

    emp1 = @db.create_emp("Anne Droid")
    emp2 = @db.create_emp("Hal Hummin")
    emp3 = @db.create_emp("Lil Asimov")

    @db.update_project(proj1.id, {eid:emp1.id})
    @db.update_project(proj1.id, {eid:emp2.id})
    @db.update_project(proj1.id, {eid:emp3.id})

    result = @db.get_proj_emps(proj1.id)
    expect(result).to be_a(Array)
    expect(result.length).to eq(3)
    expect(result[0].name).to eq("Anne Droid" || "Hal Hummin" || "Lil Asimov")
  end

  it "can return a list of all the projects in which one employee is participating" do
    emp = @db.create_emp("Jane Employment")

    proj1 = @db.create_project("Work")
    proj2 = @db.create_project("Ping pong")
    proj3 = @db.create_project("Not doing this")

    proj_updates = {eid: emp.id}
    @db.update_project(proj1.id, proj_updates)
    @db.update_project(proj2.id, proj_updates)

    result = @db.get_emp_proj(emp.id)

    expect(result).to be_a(Array)
    expect(result.length).to eq(2)
    expect(result[0].name).to eq("Work" || "Ping pong")
  end
end
