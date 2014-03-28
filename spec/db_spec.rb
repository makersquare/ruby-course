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
    expect(@db.get_task(6).descr).to eq "fishing"
    expect(@db.get_task(6).priority_num).to eq 3
    task1 = @db.create_task(8,"hunting",4)
    expect(task.id).to eq 6

    expect(@db.update_tasks(6,2,"rowing",4))
    expect(@db.get_task(6).descr).to eq "rowing"
    expect(@db.get_task(6).priority_num).to eq 4
  end

  it "should update an employee, based on their id" do
    emp = @db.create_employee('Bob')
    expect(emp.id).to eq 4
    expect(emp.name).to eq ("Bob")
    expect(@db.update_employee(4,"John").name).to eq "John"
  end

  it "should add an employee who is working on a project to membership" do
    emp = @db.create_employee("Bob")
    emp1 = @db.create_employee("Sarah")
    emp2 = @db.create_employee("Kelly")

    proj1 = @db.create_project("Fitness")
    proj2 = @db.create_project("coding")
    proj3 = @db.create_project("social")

    expect(@db.memberships.length).to eq 0

    expect(@db.add_membership(emp.id,proj1.id)).to eq [{:eid=>emp.id,:pid=>proj1.id}]
    expect(@db.add_membership(emp1.id,proj2.id)).to eq [{:eid=>emp.id,:pid=>proj1.id},{:eid=>emp1.id,:pid=>proj2.id}]
    expect(@db.memberships.length).to eq 2
  end

  it "should take employee id and show all particpating projects" do
    emp = @db.create_employee("Bob")
    emp1 = @db.create_employee("Sarah")
    emp2 = @db.create_employee("Kelly")

    proj1 = @db.create_project("Fitness")
    proj2 = @db.create_project("coding")
    proj3 = @db.create_project("social")

    expect(@db.memberships.length).to eq 0

    expect(@db.add_membership(emp.id,proj1.id)).to eq [{:eid=>emp.id,:pid=>proj1.id}]
    expect(@db.add_membership(emp.id,proj2.id)).to eq [{:eid=>emp.id,:pid=>proj1.id},{:eid=>emp.id,:pid=>proj2.id}]
    expect(@db.add_membership(emp2.id,proj2.id)).to eq [{:eid=>emp.id,:pid=>proj1.id},{:eid=>emp.id,:pid=>proj2.id},{:eid=>emp2.id,:pid=>proj2.id}]
    expect(@db.show_emp_projects(emp.id)).to eq [proj1,proj2]
  end

  it "should take project id and show all employees on that project" do
    emp = @db.create_employee("Bob")
    emp1 = @db.create_employee("Sarah")
    emp2 = @db.create_employee("Kelly")

    proj1 = @db.create_project("Fitness")
    proj2 = @db.create_project("coding")
    proj3 = @db.create_project("social")

    expect(@db.memberships.length).to eq 0

    expect(@db.add_membership(emp.id,proj1.id)).to eq [{:eid=>emp.id,:pid=>proj1.id}]
    expect(@db.add_membership(emp.id,proj2.id)).to eq [{:eid=>emp.id,:pid=>proj1.id},{:eid=>emp.id,:pid=>proj2.id}]
    expect(@db.add_membership(emp2.id,proj2.id)).to eq [{:eid=>emp.id,:pid=>proj1.id},{:eid=>emp.id,:pid=>proj2.id},{:eid=>emp2.id,:pid=>proj2.id}]
    expect(@db.show_proj_employees(proj2.id)).to eq [emp,emp2]

  end

end
