require 'pry-debugger'
require 'spec_helper'


describe 'Project' do

# RSPEC::Mocks::setup(self)

  before(:each) do
    TM.orm.instance_variable_set(:@db_adaptor, PG.connect(host: 'localhost', dbname: 'task-manager-test') )
    TM.orm.delete_tables
    TM.orm.add_tables
  end

  before(:each) do
    TM.orm.delete_tables
    TM.orm.add_tables
  end

  after(:all) do
    TM.orm.delete_tables
  end

  it 'exists' do
    expect(TM::Project).to be_a(Class)
  end

  describe '.initialize' do
    it 'automatically generates and assigns the project a unique id' do
      proj1 = TM.orm.add_project('proj1')
      proj2 = TM.orm.add_project('proj2')

      expect(proj1.pid).to eq('1')
      expect(proj1.name).to eq('proj1')
      expect(proj2.pid).to eq('2')
      expect(proj2.name).to eq('proj2')
    end
  end

  describe '.list_projects' do
    it 'lists all projects in the database' do
      proj1 = TM.orm.add_project('proj1')
      proj2 = TM.orm.add_project('proj2')

      expect(TM::Project.list_projects.size).to eq(2)
    end
  end

  describe '.add_project' do
    it 'lists all projects in the database' do
      proj1 = TM::Project.add_project('proj1')

      expect(proj1).to be_a(TM::Project)
    end
  end

  describe '.list_project_tasks' do
    it 'lists all tasks associated with a project' do
      proj1 = TM.orm.add_project('proj1')
      proj2 = TM.orm.add_project('proj2')

      emp1 = TM.orm.add_employee('name1')
      emp2 = TM.orm.add_employee('name2')

      task1 = TM.orm.add_task('1', 'first task, highest priority', '1')
      task2 = TM.orm.add_task('2', 'second task, high priority', '1')
      task3 = TM.orm.add_task('3', 'third task, medium priority', '1')
      task4 = TM.orm.add_task('6', 'fourth task, low priority', '2')
      task5 = TM.orm.add_task('8', 'fifth task, lowest priority', '2')
      task6 = TM.orm.add_task('1', 'sixth task, highest priority', '2')

      expect(TM::Project.list_project_tasks(1).size).to eq(3)
      expect(TM::Project.list_project_tasks(2).size).to eq(3)
    end
  end

  describe '.list_incomplete_tasks' do
    it 'lists all incomplete tasks for a project by PID' do
      proj1 = TM.orm.add_project('proj1')

      emp1 = TM.orm.add_employee('name1')

      task1 = TM.orm.add_task('1', 'first task, highest priority', '1')
      task2 = TM.orm.add_task('2', 'second task, high priority', '1')
      task3 = TM.orm.add_task('3', 'third task, medium priority', '1')

      expect(TM::Project.list_incomplete_tasks(1).length).to eq(3)
    end
  end

  describe '.list_completed_tasks' do
    it 'lists all complete tasks for a project by PID' do
      proj1 = TM.orm.add_project('proj1')

      emp1 = TM.orm.add_employee('name1')

      task1 = TM.orm.add_task('1', 'first task, highest priority', '1')
      task2 = TM.orm.add_task('2', 'second task, high priority', '1')
      task3 = TM.orm.add_task('3', 'third task, medium priority', '1')

      TM.orm.update_complete(1,1)

      expect(TM::Project.list_completed_tasks(1).length).to eq(1)
    end
  end

  describe '.list_project_staffing' do
    it 'lists employees assigned to a project by PID' do
      proj1 = TM.orm.add_project('proj1')
      proj2 = TM.orm.add_project('proj2')

      emp1 = TM.orm.add_employee('name1')
      emp2 = TM.orm.add_employee('name2')

      task1 = TM.orm.add_task('1', 'first task, highest priority', '1')
      task2 = TM.orm.add_task('2', 'second task, high priority', '1')
      task3 = TM.orm.add_task('3', 'third task, medium priority', '1')
      task4 = TM.orm.add_task('6', 'fourth task, low priority', '2')
      task5 = TM.orm.add_task('8', 'fifth task, lowest priority', '2')
      task6 = TM.orm.add_task('1', 'sixth task, highest priority', '2')

      TM.orm.update_employee_project(2,1)
      TM.orm.update_employee_project(2,2)
      staff = TM::Project.list_project_staffing(2)

      expect(staff[0][0]).to eq('2')
    end
  end

  describe '.update_employee_project' do
    it 'assigns an employee to a project by PID and EID' do
      proj1 = TM.orm.add_project('proj1')
      proj2 = TM.orm.add_project('proj2')

      emp1 = TM.orm.add_employee('name1')
      emp2 = TM.orm.add_employee('name2')

      expect(TM::Project.update_employee_project(1,2)[0][2]).to eq('2')
      expect(TM::Project.update_employee_project(2,2)[0][2]).to eq('2')
    end
  end

  describe '.add_task' do
    it 'allows user to add tasks' do
      proj1 = TM::Project.add_project('proj1')
      proj2 = TM::Project.add_project('proj2')

      emp1 = TM.orm.add_employee('name1')
      emp2 = TM.orm.add_employee('name2')

      task1 = TM::Project.add_task('1', 'first task, highest priority', '1')
      task2 = TM::Project.add_task('2', 'second task, high priority', '1')
      task3 = TM::Project.add_task('3', 'third task, medium priority', '1')
      task4 = TM::Project.add_task('6', 'fourth task, low priority', '2')
      task5 = TM::Project.add_task('8', 'fifth task, lowest priority', '2')
      task6 = TM::Project.add_task('1', 'sixth task, highest priority', '2')

      expect(TM::Project.list_project_tasks(1).size).to eq(3)
      expect(TM::Project.list_project_tasks(2).size).to eq(3)
    end
  end

  describe '.update_employee_task' do
    it 'assigns an employee to a task by EID and TID' do
      proj1 = TM.orm.add_project('proj1')
      proj2 = TM.orm.add_project('proj2')

      emp1 = TM.orm.add_employee('name1')
      emp2 = TM.orm.add_employee('name2')

      task1 = TM.orm.add_task('1', 'first task, highest priority', '1')
      task2 = TM.orm.add_task('2', 'second task, high priority', '1')
      task3 = TM.orm.add_task('3', 'third task, medium priority', '1')
      task4 = TM.orm.add_task('6', 'fourth task, low priority', '2')
      task5 = TM.orm.add_task('8', 'fifth task, lowest priority', '2')
      task6 = TM.orm.add_task('1', 'sixth task, highest priority', '2')

      update = TM::Project.update_employee_task(2,2)

      expect(update[0]).to eq('2')
      expect(TM.orm.list_employee_projects(2).length).to eq(1)
    end
  end

  describe 'update_complete' do
    it 'changes the status of a task to complete by PID and TID' do
      proj1 = TM.orm.add_project('proj1')
      proj2 = TM.orm.add_project('proj2')

      emp1 = TM.orm.add_employee('name1')
      emp2 = TM.orm.add_employee('name2')

      task1 = TM.orm.add_task('1', 'first task, highest priority', '1')
      task2 = TM.orm.add_task('2', 'second task, high priority', '1')
      task3 = TM.orm.add_task('3', 'third task, medium priority', '1')
      task4 = TM.orm.add_task('6', 'fourth task, low priority', '2')
      task5 = TM.orm.add_task('8', 'fifth task, lowest priority', '2')
      task6 = TM.orm.add_task('1', 'sixth task, highest priority', '2')

      update = TM::Project.update_complete(2,4)

      expect(update[0][5]).to eq('complete')
    end
  end

  describe 'list_employees' do
    it 'lists all employees in the database' do
      emp1 = TM.orm.add_employee('name1')
      emp2 = TM.orm.add_employee('name2')

      employees = TM::Project.list_employees.map { |i| i }
      expect(employees.length).to eq(2)
    end
  end

  describe 'add_employee' do
    it 'creates an employee as an Employee object' do
      emp1 = TM::Project.add_employee('name1')

      expect(emp1).to be_a(TM::Employee)
    end
  end

  describe 'list_employee_projects' do
    it 'lists all projects assigned to a particular employee' do
      proj1 = TM.orm.add_project('proj1')
      proj2 = TM.orm.add_project('proj2')

      emp1 = TM.orm.add_employee('name1')
      emp2 = TM.orm.add_employee('name2')

      task1 = TM.orm.add_task('1', 'first task, highest priority', '1')
      task2 = TM.orm.add_task('2', 'second task, high priority', '1')
      task3 = TM.orm.add_task('3', 'third task, medium priority', '1')
      task4 = TM.orm.add_task('6', 'fourth task, low priority', '2')
      task5 = TM.orm.add_task('8', 'fifth task, lowest priority', '2')
      task6 = TM.orm.add_task('1', 'sixth task, highest priority', '2')

      TM.orm.update_employee_project(2,2)

      employee_projects = TM::Project.list_employee_projects(2).map { |i| i }
      expect(employee_projects.length).to eq(1)
    end
  end

  describe 'list_employee_tasks' do
    it 'lists all tasks assigned to a particular employee' do
      proj1 = TM.orm.add_project('proj1')
      proj2 = TM.orm.add_project('proj2')

      emp1 = TM.orm.add_employee('name1')
      emp2 = TM.orm.add_employee('name2')
      task1 = TM.orm.add_task('1', 'first task, highest priority', '1')
      task2 = TM.orm.add_task('2', 'second task, high priority', '1')
      task3 = TM.orm.add_task('3', 'third task, medium priority', '1')
      task4 = TM.orm.add_task('6', 'fourth task, low priority', '2')
      task5 = TM.orm.add_task('8', 'fifth task, lowest priority', '2')
      task6 = TM.orm.add_task('1', 'sixth task, highest priority', '2')

      TM.orm.update_employee_task(2,2)
      TM.orm.update_employee_task(4,2)

      employee_tasks = TM::Project.list_employee_tasks(2)

      expect(employee_tasks.length).to eq(2)
    end
  end

  describe 'list_employee_history' do
    it 'shows completed tasks for employee by EID' do
      proj1 = TM.orm.add_project('proj1')
      proj2 = TM.orm.add_project('proj2')

      emp1 = TM.orm.add_employee('name1')
      emp2 = TM.orm.add_employee('name2')

      task1 = TM.orm.add_task('1', 'first task, highest priority', '1')
      task2 = TM.orm.add_task('2', 'second task, high priority', '1')
      task3 = TM.orm.add_task('3', 'third task, medium priority', '1')
      task4 = TM.orm.add_task('6', 'fourth task, low priority', '2')
      task5 = TM.orm.add_task('8', 'fifth task, lowest priority', '2')
      task6 = TM.orm.add_task('1', 'sixth task, highest priority', '2')

      update = TM.orm.update_employee_task(2,2)
      TM.orm.update_complete(1,2)

      complete = TM.orm.list_employee_history(2)

      expect(complete[0][5]).to eq('complete')
    end
  end
end
