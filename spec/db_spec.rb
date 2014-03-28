require "spec_helper.rb"


describe "database"  do
  before do
    @db = TM.db
  end

  it "testing db" do

    expect(@db.project_list.count).to eq 0
  end

  it "a DB starts with an empty memberships" do
    expect(@db.memberships.count).to eq 0
  end

  it "a DB starts with an empty employees" do
    expect(@db.employees.count).to eq 0
  end

  it "a DB starts with an empty task for projects" do
    expect(@db.task_project.count).to eq 0
  end

  it "creates and adds an employee to the Database" do
    emp = @db.create_employee('Bob') # method on object
    expect(@db.employees[emp.id]).to eq(emp)
  end

  it "creates and adds a project to the Database" do
    proj = @db.create_project("Fitness")
    expect(@db.project_list[proj.id]).to eq (proj)
  end

  it "should get a project based on id" do
    proj = @db.create_project("Fitness")
    proj2 = @db.create_project("Study")
    expect(proj2.id).to eq 3
    expect(@db.get_project(3)).to eq proj2
  end

  it "should update a project name based on id" do
    proj = @db.create_project("Fitness")
    proj2 = @db.create_project("Study")
    expect(proj2.id).to eq 5
    expect(@db.update_project(5,"Relax")).to eq "Relax"
  end

  it "should delete a project" do
    proj = @db.create_project("Fitness")
    proj2 = @db.create_project("Study")

    expect(@db.project_list.length).to eq 2
    expect(proj.id).to eq 6
    expect(@db.delete_project(6).length).to eq 1

  end

  it "should get an employee based on id" do
    bob = @db.create_employee("Bob")
    jack = @db.create_employee("Jack")

    expect(@db.employees.length).to eq 2
    expect(bob.id).to eq 2
    expect(@db.delete_employee(2).length).to eq 1
  end

  it "creates and adds a task to the Database" do
    proj = @db.create_project("Fitness")
    expect(proj.id).to eq 8
    task = @db.create_task(8,"fishing",3)
    expect(@db.tasks.length).to eq 1
  end

  it "should get a task based on id" do
    task = @db.create_task(8,"fishing",3)
    task1 = @db.create_task(8,"hunting",4)

    expect(task.id).to eq 2
    expect(@db.tasks.length).to eq (2)
    expect(@db.get_task(2)).to eq task

  end

  it "should delete a task, based on id" do
    task = @db.create_task(8,"fishing",3)
    task1 = @db.create_task(8,"hunting",4)


    expect(task1.id).to eq 5
    expect(@db.tasks.length).to eq 2
    expect(@db.delete_task(5).length).to eq 1
  end

  it "should update a task, based on id" do
    task = @db.create_task(8,"fishing",3)
    task1 = @db.create_task(8,"hunting",4)
    expect(task.id).to eq 6
  end



end
