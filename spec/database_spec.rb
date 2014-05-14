require 'spec_helper'

describe 'Database' do

  let(:db) { TM::DB.new }
  let(:proj1) { db.create_project({id: 1, name: "Project 1"}) }
  let(:proj2) { db.create_project({id: 2, name: "Project 2"}) }
  let(:task1) { db.create_task({pid: 1, desc: "Task 1", pnum: 1, duedate: "2014 1 1"}) }
  let(:task2) { db.create_task({pid: 1, desc: "Task 2", pnum: 2, duedate: "2014 6 6"}) }
  let(:task3) { db.create_task({pid: 1, desc: "Task 3", pnum: 2, duedate: "2014 3 1"}) }
  let(:emp1) { db.create_employee({eid: 1, name: "Katrina"}) }
  let(:emp2) { db.create_employee({eid: 2, name: "Alex"}) }

# Projects ---------------------------------------

  describe '#create_project' do
    it 'should return an instance of the TM::Project class' do
      expect(proj1.pid).to eq(1)
      expect(proj1.name).to eq("Project 1")
    end

    it 'should create a project in a project hash' do
      proj1
      expect(db.projects).to eq(1=>{:id=>1, :name=>"Project 1"})
    end
  end

  describe '#get_project' do
    it 'should return an instance of the TM::Project class with the project id' do
      result = db.get_project(proj1.pid)
      expect(result.pid).to eq(1)
      expect(result.name).to eq("Project 1")
    end
  end

  describe '#update_project' do
    it 'should update the projects name in the projects hash given the id of the project' do
      proj1
      db.update_project(proj1.pid, name: "New Project")
      expect(db.projects[1][:name]).to eq("New Project")
    end
  end

  describe '#destroy_project' do
    it 'should delete a project from the projects hash given the id of the project' do
      proj1
      result = db.destroy_project(proj1.pid)
      expect(db.projects).to eq({})
    end

    it 'should delete all the tasks assocaited with the deleted project' do
      proj1
      task1
      task2
      db.destroy_project(proj1.pid)
      db.destroy_task(task1.pid)
      db.destroy_task(task2.pid)
      expect(db.projects).to eq({})
      expect(db.tasks).to eq({})
    end
  end

  describe '#complete_tasks' do
    it 'should return an array of hashes of complete tasks sorted by date created' do
      task1
      task2
      db.update_task(task2.tid, complete: true, date: "2014 1 1")
      db.update_task(task1.tid, complete: true, date: "2014 3 1")
      expect(db.complete_tasks(proj1.pid)).to eq([{:pid=>1, :desc=>"Task 2", :pnum=>2, :duedate=>"2014 6 6", :tid=>2, :complete=>true, :date=>"2014 1 1"}, {:pid=>1, :desc=>"Task 1", :pnum=>1, :duedate=>"2014 1 1", :tid=>1, :complete=>true, :date=>"2014 3 1"}])
    end
  end

  describe '#incomplete_tasks' do
    it 'should return an array of hashes of incomplete tasks sorted by priority number and then duedate' do
      task1
      task2
      task3
      expect(db.incomplete_tasks(1)).to eq([{:pid=>1, :desc=>"Task 1", :pnum=>1, :duedate=>"2014 1 1", :tid=>1, :complete=>false, :date=>"2014 5 14"}, {:pid=>1, :desc=>"Task 3", :pnum=>2, :duedate=>"2014 3 1", :tid=>3, :complete=>false, :date=>"2014 5 14"}, {:pid=>1, :desc=>"Task 2", :pnum=>2, :duedate=>"2014 6 6", :tid=>2, :complete=>false, :date=>"2014 5 14"}])
    end
  end

  describe '#overdue_tasks' do
    it 'should return an array of hashes of overdue tasks' do
      task1
      task3
      expect(db.overdue_tasks(1)).to eq([{:pid=>1, :desc=>"Task 1", :pnum=>1, :duedate=>"2014 1 1", :tid=>1, :complete=>false, :date=>"2014 5 14"}, {:pid=>1, :desc=>"Task 3", :pnum=>2, :duedate=>"2014 3 1", :tid=>2, :complete=>false, :date=>"2014 5 14"}])
    end
  end

  describe '#percent_done' do
    xit 'should return a number that is the percent of done tasks for a project' do
      task1
      task2
      db.update_task(task1.tid, complete: true)
      expect(db.percent_done(1)).to eq(50)
    end
  end

  describe '#percent_overdue' do
    xit 'should return a number that is the percent of overdue tasks for a project' do
        task2
        task3
        expect(db.percent_overdue(1)).to eq(50)
    end
  end

  describe '#list_projects' do
    xit 'should return an array with a hash of each project' do

    end
  end

# Tasks ---------------------------------------

  describe '#create_task' do
    it 'should return an instance of the TM::Task class' do
      task1
      t = Time.now
      expect(task1.pid).to eq(1)
      expect(task1.tid).to eq(1)
      expect(task1.desc).to eq("Task 1")
      expect(task1.pnum).to eq(1)
      expect(task1.duedate).to eq("2014 1 1")
      expect(task1.date).to eq("#{t.year} #{t.month} #{t.day}")
      expect(task1.complete).to eq(false)
    end

    it 'should make a new task in the tasks hash' do
      task1
      t = Time.now
      expect(db.tasks).to eq(1=>{:pid=>1, :desc=>"Task 1", :pnum=>1, :duedate=>"2014 1 1", :tid=>1, :date => "#{t.year} #{t.month} #{t.day}", :complete => false})
    end
  end

  describe '#get_task' do
    it 'should return an instance of TM::Task class given the task id' do
      task1
      t = Time.now
      result = db.get_task(task1.tid)
      expect(result.pid).to eq(1)
      expect(result.tid).to eq(1)
      expect(result.desc).to eq("Task 1")
      expect(result.pnum).to eq(1)
      expect(result.duedate).to eq("2014 1 1")
      expect(result.date).to eq("#{t.year} #{t.month} #{t.day}")
      expect(result.complete).to eq(false)
    end
  end

  describe '#update_task' do
    it 'should update the given data in the correct task in the task hash' do
      task1
      task2
      db.update_task(task2.tid, complete: true)
      db.update_task(task1.tid, desc: "new description", complete: true)
      expect(db.tasks[2][:complete]).to eq(true)
      expect(db.tasks[1][:desc]).to eq("new description")
      expect(db.tasks[1][:complete]).to eq(true)
    end
  end

  describe '#destroy_task' do
    it 'should delete a task from the task hash' do
      task1
      db.destroy_task(task1.tid)
      expect(db.tasks).to eq({})
    end
  end

# Employees ---------------------------------------

  describe '#create_employee' do
    it 'should return an instance of the TM::Employee class' do
      expect(emp1.eid).to eq(1)
      expect(emp1.name).to eq("Katrina")
    end

    it 'should create a employee in a employee hash' do
      emp1
      expect(db.employees).to eq(1=>{:eid=>1, :name=>"Katrina"})
    end
  end

  describe '#get_employee' do
    it 'should return an instance of the TM::Employee class with an employee id' do
      result = db.get_employee(emp1.eid)
      expect(result.eid).to eq(1)
      expect(result.name).to eq("Katrina")
    end
  end

  describe '#update_employee' do
    it 'should update the employees name in the employees hash given the id of the employee' do
      emp1
      db.update_employee(emp1.eid, name: "Raquel")
      expect(db.employees[1][:name]).to eq("Raquel")
    end
  end

  describe '#destroy_employee' do
    it 'should delete an employee from the employees hash given the id of the employee' do
      emp1
      result = db.destroy_employee(emp1.eid)
      expect(db.employees).to eq({})
    end
  end

# Employees_Projects ---------------------------------------

  describe '#create_proj_emp' do
    it 'should be able to add employees to projects and projects to employees in the employees_projects hash' do
      emp1
      emp2
      proj1
      proj2
      db.create_proj_emp(:pid => proj1.pid, :eid => emp1.eid)
      db.create_proj_emp(:pid => proj1.pid, :eid => emp2.eid)
      expect(db.employees_projects).to eq(1 => {:id => 1, :pid => 1, :eid => 1}, 2 => {:id => 2, :pid => 1, :eid => 2})
      db.create_proj_emp(:pid => proj2.pid, :eid => emp2.eid)
      expect(db.employees_projects).to eq(1 => {:id => 1, :pid => 1, :eid => 1}, 2 => {:id => 2, :pid => 1, :eid => 2}, 3 => {:id => 3, :pid => 2, :eid => 2})
    end
  end

  describe '#get_intask_by_emp' do
    it 'should list tasks for an employee' do
      task1
      task2
      emp1
      db.create_task_emp(:tid => task1.tid, :eid => emp1.eid)
      db.create_task_emp(:tid => task2.tid, :eid => emp1.eid)
      expect(db.get_inctask_by_emp(emp1.eid)).to eq([{:tid=>1, :desc=>"Task 1", :duedate=>"2014 1 1", :pnum=>1}, {:tid=>2, :desc=>"Task 2", :duedate=>"2014 6 6", :pnum=>2}])
    end
  end

  describe '#get_emp_by_proj' do
    it 'should list all employees for a project' do
      proj1
      emp1
      emp2
      db.create_proj_emp(:pid => proj1.pid, :eid => emp1.eid)
      db.create_proj_emp(:pid => proj1.pid, :eid => emp2.eid)
      expect(db.get_emp_by_proj(proj1.pid)).to eq([{eid: 1, name: "Katrina"},{eid: 2, name: "Alex"}])
    end
  end

  describe '#destroy_proj_emp' do
    it 'should delete a project/employee hash in the employees_projects hash' do
      emp1
      proj1
      db.create_proj_emp(:pid => proj1.pid, :eid => emp1.eid)
      expect(db.employees_projects).to eq(1 => {:id => 1, :pid => 1, :eid => 1})
      db.destroy_proj_emp(proj1.pid, emp1.eid)
      expect(db.employees_projects).to eq({})
    end
  end

# Employees_Tasks ---------------------------------------

describe '#create_task_emp' do
  it 'should be able to add employees to tasks and tasks to employees in the employees_tasks hash' do
    emp1
    emp2
    task1
    task2
    db.create_task_emp(:tid => task1.tid, :eid => emp1.eid)
    db.create_task_emp(:tid => task1.tid, :eid => emp2.eid)
    expect(db.employees_tasks).to eq(1 => {:id => 1, :tid => 1, :eid => 1}, 2 => {:id => 2, :tid => 1, :eid => 2})
    db.create_task_emp(:tid => task2.tid, :eid => emp2.eid)
    expect(db.employees_tasks).to eq(1 => {:id => 1, :tid => 1, :eid => 1}, 2 => {:id => 2, :tid => 1, :eid => 2}, 3 => {:id => 3, :tid => 2, :eid => 2})
  end
end

describe '#get_proj_by_emp' do
  xit 'should list projects for an employee' do
    proj1
    proj2
    emp1
    db.create_proj_emp(:pid => proj1.pid, :eid => emp1.eid)
    db.create_proj_emp(:pid => proj2.pid, :eid => emp1.eid)
    expect(db.get_proj_by_emp(emp1.eid)).to eq([{pid: 1, name: "Project 1", percent_done: 0, percent_over: 0},{pid: 2, name: "Project 2", percent_done: 0, percent_over: 0}])
  end
end

describe '#get_emp_by_proj' do
  xit 'should list all employees for a project' do
    proj1
    emp1
    emp2
    db.create_proj_emp(:pid => proj1.pid, :eid => emp1.eid)
    db.create_proj_emp(:pid => proj1.pid, :eid => emp2.eid)
    expect(db.get_emp_by_proj(proj1.pid)).to eq([{eid: 1, name: "Katrina"},{eid: 2, name: "Alex"}])
  end
end

describe '#destroy_proj_emp' do
  xit 'should delete a project/employee hash in the employees_projects hash' do
    emp1
    proj1
    db.create_proj_emp(:pid => proj1.pid, :eid => emp1.eid)
    expect(db.employees_projects).to eq(1 => {:id => 1, :pid => 1, :eid => 1})
    db.destroy_proj_emp(proj1.pid, emp1.eid)
    expect(db.employees_projects).to eq({})
  end
end

end
