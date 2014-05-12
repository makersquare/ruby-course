require 'spec_helper'

describe 'Database' do

  let(:db) { TM::DB.new }
  let(:proj1) { db.create_project({id: 1, name: "Project 1"}) }
  let(:task1) { db.create_task({tid: 1, desc: "Task 1", pnum: 1, duedate: "2014 1 1"}) }
  let(:task2) { db.create_task({tid: 2, desc: "Task 2", pnum: 2, duedate: "2014 6 6"}) }

  describe '#create_project' do
    it 'should make an instance of the TM::Project class' do
      expect(proj1.pid).to eq(1)
      expect(proj1.name).to eq("Project 1")
    end

    it 'should create a project in a project hash' do
      proj1
      expect(db.projects).to eq(1=>{:id=>1, :name=>"Project 1"})
    end
  end

  describe '#get_project' do
    it 'should return an instance of the TM::Project class with to project id' do
      result = db.get_project(proj1.pid)
      expect(result.pid).to eq(1)
      expect(result.name).to eq("Project 1")
    end
  end

  describe '#update_project' do
    it 'should update the projects name in the projects hash given the id of the project' do
      proj1
      result = db.update_project(proj1.pid, name: "New Project")
      expect(result.name).to eq("New Project")
    end
  end

  describe '#destroy_project' do
    it 'should delete a project from the projects has given the id of the project' do
      proj1
      result = db.destroy_project(proj1.pid)
      expect(db.projects).to eq({})
    end
  end

  describe '#create_task' do
    xit 'should make a new task in the tasks hash' do
    end

    xit 'should return an instance of the TM::Task class' do
    end
  end

  describe '#get_task' do
    xit 'should return an instance of TM::Task class given the task id' do
    end
  end

  describe '#update_task' do
    xit 'should update the given data in the correct task in the task hash' do
    end

    xit 'should return an instance of the TM::Task class with the updated data' do
    end
  end

  describe '#destroy_task' do
    xit 'should delete a task from the task hash' do
    end
  end

end
