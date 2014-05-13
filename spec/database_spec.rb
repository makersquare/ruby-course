require 'spec_helper'

describe 'Database' do

  let(:db) { TM::DB.new }
  let(:proj1) { db.create_project({id: 1, name: "Project 1"}) }
  let(:task1) { db.create_task({pid: 1, desc: "Task 1", pnum: 1, duedate: "2014 1 1"}) }
  let(:task2) { db.create_task({pid: 1, desc: "Task 2", pnum: 2, duedate: "2014 6 6"}) }
  let(:emp1) { db.create_employee({eid: 1, name: "Katrina"}) }
  let(:emp2) { db.create_employee({eid: 2, name: "Alex"}) }

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
    it 'should delete a project from the projects has given the id of the project' do
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
      db.update_task(task1.tid, desc: "new description")
      expect(db.tasks[2][:complete]).to eq(true)
      expect(db.tasks[1][:desc]).to eq("new description")
    end
  end

  describe '#destroy_task' do
    it 'should delete a task from the task hash' do
      task1
      db.destroy_task(task1.tid)
      expect(db.tasks).to eq({})
    end
  end

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

  describe '#destroy_project' do
    xit 'should delete a project from the projects has given the id of the project' do
      proj1
      result = db.destroy_project(proj1.pid)
      expect(db.projects).to eq({})
    end
  end

end
