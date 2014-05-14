require 'spec_helper'
require 'pry'

describe "TaskManager::Database" do

  before(:each) do
    @db = TM.db
  end

  it 'exist' do
    expect(TM::Database).to be_a(Class)
  end

  context 'it is initialized' do
    let(:employee1) { @db.create_employee(name: "Johnny") }
    let(:employee2) { @db.create_employee(name: "Jacoub") }
    let(:project1) { @db.create_project(name: "New Project") }
    let(:project2) { @db.create_project(name: "Second Project") }


    it 'creates an empty projects hash' do
      expect(@db.projects).to eq({})
    end

    it 'creates an empty task hash' do
      expect(@db.task).to eq({})
    end

    it 'has a projects counter' do
      expect(@db.projects_counter).to eq(0)
    end

    it 'has a task counter' do
      expect(@db.task_counter).to eq(0)
    end

    it 'can list all employees' do
      employee1
      expect(@db.all_employees.first.name).to eq("Johnny")
    end

    it 'can list all projects' do
      project1
      project2
      expect(@db.all_projects.last.name).to eq("Second Project")
      expect(@db.all_projects.first.id).to eq(1)
    end

    it 'can create assign employees to a project' do
      employee1; employee2; project1; project2
      @db.create_membership(pid: 1, eid: 1)
      @db.create_membership(pid: 1, eid: 2)
      @db.create_membership(pid: 2, eid: 2)

      # binding.pry

      expect(@db.employee_projects[1][:eid]).to eq(1)
      expect(@db.employee_projects[2][:eid]).to eq(2)
      expect(@db.employee_projects[3][:eid]).to eq(2)
      expect(@db.employee_projects[4]).to eq(nil)
    end

    it 'can remove an employees from a project' do
      employee1; employee2; project1; project2
      @db.create_membership(pid: 1, eid: 1)
      @db.create_membership(pid: 1, eid: 2)
      @db.create_membership(pid: 2, eid: 2)

      @db.destroy_membership(eid: 1, pid: 1)
      @db.destroy_membership(eid: 2, pid: 2)

      # binding.pry
      expect(@db.destroy_membership(eid: 1, pid: 3)).to eq(false)
      expect(@db.employee_projects[1]).to eq(nil)
      expect(@db.employee_projects[2][:eid]).to eq(2)
      expect(@db.employee_projects[3]).to eq(nil)
    end

  end

  context 'a new project is added to the datebase' do
    before(:each) do
      @new_project = @db.create_project({ :name => "Pizza Party Planning" })
    end

    it 'can add new projects' do
      expect(@db.projects).to eq({ 1 => { name: "Pizza Party Planning", id: 1, completed: false } })
      expect(@db.projects_counter).to eq(1)
    end

    it 'can return a project' do
      expect(@db.get_project(1).name).to eq("Pizza Party Planning")
    end

    it 'can update a project' do
      @db.update_project(1, { name: "Pizza and Ice Cream Party Planning" } )
      expect(@db.projects[1][:name]).to eq("Pizza and Ice Cream Party Planning")
    end

    it 'can destroy a project' do
      @db.destroy_project(1)
      expect(@db.projects).to eq({})
    end

    it 'can build a new project' do
      expect(@db.build_project({ :name => "Pizza Party Planning", id: 1, completed: false }).id).to eq(1)
    end

  end


  context 'a task is created' do

    before(:each) do
      @new_project = @db.create_project({ :name => "Pizza Party Planning" })
      @new_task = @db.create_task({ description: "Find Pizza", pid: 1, priority: 1 })
    end

    it 'has a uinquie employee id' do
      expect(@new_task[:eid]).to eq(nil)
    end

    it 'can add new task' do
      expect(@db.task.count).to eq(1)
    end

    it 'increases the task counter' do
      expect(@db.task_counter).to eq(1)
    end

    it 'can retrieve a task by its id' do
      expect(@db.get_task(1).description).to eq("Find Pizza")
    end

    it 'can update a tasks information' do
      @db.update_task(1, {description: "Find some ice cream"})
      expect(@db.task[1][:description]).to eq("Find some ice cream")
    end

    it 'can destroy a task' do
      @db.destroy_task(1)
      expect(@db.task[1]).to eq(nil)
    end
  end

  context 'a new employee is created' do

    before(:each) do
      @new_project = @db.create_project({ :name => "Pizza Party Planning" })
      @new_task = @db.create_task({ description: "Find Pizza", pid: 1, priority: 1 })
      @employee1 = @db.create_employee( {name: "Jason" })
      @employee2 = @db.create_employee( {name: "Rogger" })
    end

    it 'assignes a unique ID' do
      # binding.pry
      expect(@db.employees[1][:id]).to eq(1)
      expect(@db.employees[2][:id]).to eq(2)
    end

    it 'can get an employee' do
      @employee = @db.get_employee(1)
      expect(@employee.name).to eq("Jason")
      # binding.pry
    end

    it 'can be updated' do
      expect(@employee1[:name]).to eq("Jason")
      @db.update_employee(1, name: "Joven")
      expect(@employee1[:name]).to eq("Joven")
    end

    it 'can be destroyed' do
      @db.destroy_employee(1)
      expect(@db.employees[1]).to eq(nil)
    end

  end

  context 'employee_projects is defined' do

    before(:each) do
      @new_project = @db.create_project({ :name => "Pizza Party Planning" })
      @new_task = @db.create_task({ description: "Find Pizza", pid: 1, priority: 1 })
      @db.create_employee( {name: "Jason" })
      @employee1 = @db.get_employee(1)
      @employee2 = @db.create_employee( {name: "Rogger" })
    end

    it 'updates when an employee is assigned to a project' do
      @db.update_membership(pid: 1, eid: 1, add: true)
      expect(@db.employee_projects[1]).to eq({eid: 1, id: 1, pid: 1 })
    end

    it 'can remove an employee from a project' do
      @db.update_membership(pid: 1, eid: 1, add: true)
      @db.update_membership(pid: 1, eid: 1)
      expect(@db.employee_projects[1]).to eq(nil)
    end

    it 'can retrieve a membership hash' do
      @db.update_membership(pid: 1, eid: 1, add: true)
      expect(@db.get_membership(1)).to eq([1])
    end

    it 'can destroy a membership' do
      @db.destroy_membership(1)
      expect(@db.get_membership(1)).to eq([])
    end


  end

end
