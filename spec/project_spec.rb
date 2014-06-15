require 'pry-debugger'
require 'spec_helper'

describe 'Project' do
  before(:each) {TM::Project.class_variable_set :@@projects, []}
  before(:each) {TM::Task.class_variable_set :@@tasks, []}

  let!(:proj1) {TM::Project.new('proj1')}
  let!(:proj2) {TM::Project.new('proj2')}
  let!(:task0) {proj1.add_task(3, 'proj 1 tid 0')}
  let!(:task1) {proj1.add_task(1, 'proj 1 tid 1')}
  let!(:task2) {proj1.add_task(1, 'proj 1 tid 2')}
  let!(:task3) {proj2.add_task(3, 'proj 2 tid 3')}
  let!(:task4) {proj2.add_task(2, 'proj 2 tid 4')}
  let!(:task5) {proj2.add_task(2, 'proj 2 tid 5')}

  describe '.initialize' do

    it "creates a new project with a name" do
      expect(proj1.name).to eq('proj1')
    end

    it "automatically generates and assigns the project a unique id" do
      expect(proj1.pid).to eq(0)
      expect(proj2.pid).to eq(1)
    end

  end

  describe '.add_task' do
    it "allows user to add tasks" do
      expect(proj1.tasks.size).to eq(3)
      expect(proj2.tasks.size).to eq(3)
    end
  end

  describe '.list_all_tasks' do
      before do
        $stdout = StringIO.new
      end

      after(:all) do
        $stdout = STDOUT
      end

    it "lists all tasks and their associated IDs" do
      proj1.list_all_tasks
      expect($stdout.string).to match('TID 0: Priority 3, proj 1 tid 0\nTID 1: Priority 1, proj 1 tid 1\nTID 2: Priority 1, proj 1 tid 2')
    end
  end

  describe '.list_completed_tasks' do
    before do
      $stdout = StringIO.new
    end

    after(:all) do
      $stdout = STDOUT
    end

    it "can retrieve a list of complete tasks sorted by creation date" do

      time1 = Time.parse("12:00")
      time2 = Time.parse("15:00")
      Time.stub(:now).and_return(time1)
      Time.stub(:now).and_return(time2)

      proj1.tasks[1].creation_date = time2
      proj1.tasks[2].creation_date = time1

      proj1.tasks[1].mark_complete
      proj1.tasks[2].mark_complete
      proj1.list_completed_tasks
      expect($stdout.string).to match('TID 2: proj 1 tid 2\nTID 1: proj 1 tid 1')
    end
  end

  describe '.list_incomplete_tasks' do
    before do
      $stdout = StringIO.new
    end

    after(:all) do
      $stdout = STDOUT
    end

    it "can retrieve a list of incomplete tasks sorted by priority, prioritizing older tasks if two are tied" do
      time1 = Time.parse("12:00")
      time2 = Time.parse("15:00")
      Time.stub(:now).and_return(time1)
      Time.stub(:now).and_return(time2)

      proj2.tasks[1].creation_date = time2
      proj2.tasks[2].creation_date = time1
      proj2.list_incomplete_tasks
      expect($stdout.string).to match('TID 5: Priority 2, proj 2 tid 5\nTID 4: Priority 2, proj 2 tid 4\nTID 3: Priority 3, proj 2 tid 3')
    end
  end

  describe 'list_projs' do
    before do
      $stdout = StringIO.new
    end

    after(:all) do
      $stdout = STDOUT
    end

    it "lists all projects and associated ids" do
      proj1.list_projs
      expect($stdout.string).to match('PID 0: proj1\nPID 1: proj2')
    end
  end
end
