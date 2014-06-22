require 'spec_helper'
require 'pry-debugger'

describe 'ORM' do

  before(:each) do
    TM.orm.instance_variable_set(:@db_adaptor, PG.connect(host: 'localhost', dbname: 'task-manager-test') )
    TM.orm.delete_tables
    TM.orm.add_tables
  end

  let!(:proj1) {TM.orm.add_project('proj1')}
  let!(:proj2) {TM.orm.add_project('proj2')}
  let!(:proj3) {TM.orm.add_project('proj3')}
  let!(:proj4) {TM.orm.add_project('proj4')}
  let!(:emp1) {TM.orm.add_employee('name1')}
  let!(:emp2) {TM.orm.add_employee('name2')}
  let!(:emp3) {TM.orm.add_employee('name3')}
  let!(:emp4) {TM.orm.add_employee('name4')}
  let!(:emp5) {TM.orm.add_employee('name5')}
  let!(:task1_1) {TM.orm.add_task('1', 'first task, highest priority', '1')}
  let!(:task1_2) {TM.orm.add_task(2, 'second task, lower priority', 1)}
  let!(:task1_3) {TM.orm.add_task(1, 'third task, highest priority', 1)}
  let!(:task2_4) {TM.orm.add_task(2, 'fourth task, lower priority', 2)}
  let!(:task2_5) {TM.orm.add_task(2, 'fifth task, lower priority', 2)}
  let!(:task2_6) {TM.orm.add_task(1, 'sixth task, highest priority', 2)}
  before(:each) {TM.orm.update_complete(1,1)}
  before(:each) {TM.orm.update_employee_task(2,2)}
  before(:each) {TM.orm.update_employee_project(1,1)}
  before(:each) {TM.orm.update_employee_project(2,1)}
  # before(:each) {TM.orm.update_employee_project(4,3)}
  # before(:each) {TM.orm.update_employee_project(4,3)}

  # before(:each) do
  #   TM.orm.delete_tables
  #   TM.orm.add_tables
  # end

  after(:all) do
    TM.orm.delete_tables
  end

  it "should be an ORM" do
    expect(TM.orm).to be_a(TM::ORM)
  end

  it 'is created with a db adaptor' do
    expect(TM.orm.db_adaptor).not_to be_nil
  end

  describe 'list_projects' do
    it 'lists all projects in the database' do
      names = TM.orm.list_projects.map { |i| i[1] }
      expect(names).to include('proj1', 'proj2', 'proj3', 'proj4')
    end
  end

  describe 'add_project' do
    it 'creates a project as a Project object' do
      expect(proj1).to be_a(TM::Project)
    end
  end

  describe 'list_tasks' do
    it 'lists all tasks in the database' do
      tasks = TM.orm.list_tasks.map { |i| i[2] }
      expect(tasks.length).to eq(6)
    end
  end

  describe 'list_incomplete_tasks' do
    it 'lists tasks marked as incomplete for a given project' do
      expect(TM.orm.list_incomplete_tasks(2).length).to eq(3)
    end
  end

  describe 'list_completed_tasks' do
    it 'lists tasks marked as complete for a given project' do
      expect(TM.orm.list_completed_tasks(1).length).to eq(1)
    end
  end

  describe 'list_project_staffing' do
    it 'lists all employees assigned to a project' do
      TM.orm.update_employee_project(2,1)
      TM.orm.update_employee_project(2,2)
      staff = TM.orm.list_project_staffing(2)
      expect(staff[0][0]).to eq('2')
    end
  end

  describe 'add_task' do
    it 'creates a task as a Task object' do
      expect(task1_1).to be_a(TM::Task)
    end
  end

  describe 'update_employee_project' do
    it 'assigns a project to an employee by PID and EID' do
      expect(TM.orm.update_employee_project(3,3)[0][2]).to eq('3')
      expect(TM.orm.update_employee_project(4,3)[0][2]).to eq('3')
    end
  end

  describe 'update_complete' do
    it 'changes the status of a task to complete' do
      expect(task1_1.update_complete).to eq('complete')
    end
  end

  describe 'list_employees' do
    it 'lists all employees in the database' do
      employees = TM.orm.list_employees.map { |i| i }
      expect(employees.length).to eq(5)
    end
  end

  describe 'add_employee' do
    it 'creates an employee as an Employee object' do
      expect(emp1).to be_a(TM::Employee)
    end
  end

  describe 'list_employee_projects' do
    it 'lists all projects assigned to a particular employee' do
      employee_projects = TM.orm.list_employee_projects(3).map { |i| i }
      expect(employee_projects.length).to eq(3)
    end
  end

  # describe 'list_employee_tasks' do
  #   it 'lists all tasks assigned to a particular employee' do
  #     TM.orm.update_employee_task(4,4)
  #     employee_tasks = TM.orm.list_employee_tasks(4).map { |i| i }
  #     expect(employee_tasks.length).to eq(1)
  #   end
  # end

  describe 'update_employee_task' do
    it 'assigns a task to an employee by TID and EID' do
      expect(TM.orm.update_employee_task(2,2)[0]).to eq('2')
    end
  end

  describe 'list_employee_history' do
    it 'shows completed tasks for employee by EID' do
      TM.orm.update_complete(1,1)
      complete = TM.orm.list_employee_history(1)
      expect(complete[0][5]).to eq('complete')
    end
  end
end
