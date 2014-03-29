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
    task = @db.create_task(8,2,"fishing",3)
    expect(@db.tasks.length).to eq 1
  end

  it "should get a task based on id" do
    task = @db.create_task(8,2,"fishing",3)
    task1 = @db.create_task(8,2,"hunting",4)

    expect(task.id).to eq 2
    expect(@db.tasks.length).to eq (2)
    expect(@db.get_task(2)).to eq task

  end

  it "should delete a task, based on id" do
    task = @db.create_task(8,2,"fishing",3)
    task1 = @db.create_task(8,2,"hunting",4)


    expect(task1.id).to eq 5
    expect(@db.tasks.length).to eq 2
    expect(@db.delete_task(5).length).to eq 1
  end

  it "should update a task, based on id" do
    task = @db.create_task(8,2,"fishing",3)
    expect(@db.get_task(6).descr).to eq "fishing"
    expect(@db.get_task(6).priority_num).to eq 3
    task1 = @db.create_task(8,2,"hunting",4)
    expect(task.id).to eq 6

    expect(@db.update_tasks(6,2,3,"rowing",4))
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

  it "should get all tasks an employee is working on, based on eid " do
    #same startegey as more, use the databases that you have
    # you have a hash with employees, you have a hash with tasks, each with ids
    emp = @db.create_employee("Bob")
    emp1 = @db.create_employee("Sarah")
    emp2 = @db.create_employee("Kelly")
    # search through task hash, to find the employeeid on it
    expect(emp.id).to eq 14
    expect(emp1.id).to eq 15
    expect(emp2.id).to eq 16

    task = @db.create_task(8,14,"fishing",3)
    task1 = @db.create_task(9,14,"running",4)
    task2 = @db.create_task(9,16,"hunting",5)

    expect(@db.get_tasks_for_emp(14)).to eq [task,task1]

  end

  xit "should get employee that is working on a task, based on tid" do

    emp = @db.create_employee("Bob")
    emp1 = @db.create_employee("Sarah")
    emp2 = @db.create_employee("Kelly")

    expect(emp.id).to eq 17
    expect(@db.get_emp_for_task(17))
    # based on task_id, I need to get employee, so @employees, doesn't
    # have a task_id points to a task, so if

  end

  it "should assign a task to an employee" do
    emp = @db.create_employee("Bob")
    emp1 = @db.create_employee("Sarah")
    emp2 = @db.create_employee("Kelly")

    task = @db.create_task(8,14,"fishing",3)
    task1 = @db.create_task(9,14,"running",4)
    task2 = @db.create_task(9,16,"hunting",5)

    expect(emp.id).to eq 17
    expect(emp1.id).to eq 18

    expect(task.id).to eq 11
    expect(task1.id).to eq 12
    expect(task2.id).to eq 13

    expect(task.emp_id).to eq 14
    @db.assign_task_emp(11,17)
    expect(task.emp_id).to eq 17

  end

  it "add new task to project, based on projectid" do
    task = @db.create_task(8,14,"fishing",3)
    task1 = @db.create_task(9,14,"running",4)
    task2 = @db.create_task(9,16,"hunting",5)
    # not necessary, because when you create a
    # task, you assign it a pid, which gives it to a
    #project
    proj1 = @db.create_project("Fitness")
    proj2 = @db.create_project("coding")
    proj3 = @db.create_project("social")

    expect(proj1.id).to eq 18
    expect(proj2.id).to eq 19
    expect(proj3.id).to eq 20


  end

  it "should list all projects" do
    proj1 = @db.create_project("Fitness")
    proj2 = @db.create_project("coding")
    proj3 = @db.create_project("social")

    expect(proj1.id).to eq 21
    expect(proj2.id).to eq 22
    expect(proj3.id).to eq 23

    allcurrentproj = @db.list_all_proj
    expect(allcurrentproj).to eq ({proj1.id =>proj1, proj2.id=>proj2, proj3.id=>proj3})
  end

  it "should show remaining task for project pid" do
    proj1 = @db.create_project("Fitness")
    proj2 = @db.create_project("coding")
    proj3 = @db.create_project("social")

    expect(proj1.id).to eq 24
    expect(proj2.id).to eq 25
    expect(proj3.id).to eq 26

    task = @db.create_task(8,14,"fishing",3)
    task1 = @db.create_task(9,14,"running",4)
    task2 = @db.create_task(9,16,"hunting",5)


  end


end
