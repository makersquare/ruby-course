require 'spec_helper'

describe "DB" do

  before do
    @db = TM::DB.new
    TM::Task.class_variable_set(:@@task_count, 0)
    TM::Project.class_variable_set(:@@projectcount, 0)
    TM::Employee.class_variable_set(:@@employeecount, 0)

    @project = @db.create_project("Project Name")
    @employee = @db.create_employee("Employee Name")

  end

  it "contains a hash of projects accessible by index with get_project added by create_project" do
    expect(@db.get_project(1)).to be_a(TM::Project)
    @db.create_project("Second")
    expect(@db.get_project(2)).to be_a(TM::Project)
  end

  it "can create a task and add it to a project, and add it to tasks hash" do
    new_task = @db.create_task("A fun task",5,6)
    expect(new_task).to be_a(TM::Task)
    expect(new_task.description).to eq("A fun task")
    expect(new_task.project_id).to eq(6)
    expect(new_task.priority).to eq(5)
    expect(@db.tasks[new_task.task_id]).to eq(new_task)
  end

  it "can mark a task complete" do
    new_task = @db.create_task("A fun task",5,6)
    @db.mark_task_complete(new_task.task_id)
    expect(new_task.complete).to eq(true)
  end

  it "can retrieve a list of all complete tasks, sorted by creation date" do
    puts @db.create_task("task 1",5,@project.project_id).task_id
    puts @db.create_task("task 2",4,@project.project_id).task_id
    puts @db.create_task("task 3",3,@project.project_id).task_id
    puts @db.create_task("task 4",2,@project.project_id).task_id
    puts @db.create_task("task 5",1,@project.project_id).task_id

    @db.mark_task_complete(1)
    @db.mark_task_complete(3)
    @db.mark_task_complete(5)

    completed_projects = @db.complete_task_list(@project.project_id)

    expect(completed_projects[0].description).to eq("task 1")
    expect(completed_projects[1].description).to eq("task 3")
    expect(completed_projects[2].description).to eq("task 5")
    expect(completed_projects.length).to eq(3)
  end

  it "can create a list of all incomplete tasks, sorted by creation date and priority" do
    db = TM::DB.new
    project = db.create_project("new test project")

    db.create_task("task 1",4,project.project_id)
    db.create_task("task 2",3,project.project_id)
    db.create_task("task 3",1,project.project_id)
    db.create_task("task 4",1,project.project_id)
    db.create_task("task 5",3,project.project_id)

    incomplete_projects = db.incomplete_task_list(project.project_id)
    expect(incomplete_projects[0].description).to eq("task 3")
    expect(incomplete_projects[1].description).to eq("task 4")
    expect(incomplete_projects[2].description).to eq("task 2")
    expect(incomplete_projects[3].description).to eq("task 5")
    expect(incomplete_projects[4].description).to eq("task 1")
  end

  it "Can add employees to projects by pushing hash to join_projects_employees array" do
    db = TM::DB.new
    project = db.create_project("new test project")
    employee = db.create_employee("Employee Name")

    db.add_employee_to_project(employee.employee_id, project.project_id)

    expect(db.join_employees_projects[0]).to eq({employee_id: employee.employee_id, project_id: project.project_id})
  end

  it "Can add employee to task" do
    db = TM::DB.new
    project = db.create_project("new test project")
    employee = db.create_employee("Employee Name")
    task = db.create_task("task 1",4,project.project_id)

    db.assign_task_to_employee(employee.employee_id, task.task_id)

    expect(task.employee_id).to eq(employee.employee_id)
  end

  it "can get array of all employees on a project" do
    db = TM.db

    project = db.create_project("new test project")
    employee1 = db.create_employee("Employee One")
    employee2 = db.create_employee("Employee Two")
    employee3 = db.create_employee("Employee Three")

    db.add_employee_to_project(employee1.employee_id, project.project_id)
    db.add_employee_to_project(employee2.employee_id, project.project_id)
    db.add_employee_to_project(employee3.employee_id, project.project_id)

    employees = db.get_employees_on_project(project.project_id)

    expect(employees[2].name).to eq("Employee Three")
  end
end
