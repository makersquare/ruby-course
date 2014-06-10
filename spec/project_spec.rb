require 'pry-debugger'
require 'spec_helper'

describe 'Project' do
  before(:each) {TM::Project.class_variable_set :@@id, 0}
  let(:proj) {TM::Project.new('proj1')}
  let(:proj2) {TM::Project.new('proj2')}

  describe '.initialize' do
    it "exists" do
      expect(TM::Project).to be_a(Class)
    end

    it "creates a new project with a name" do
      expect(proj.name).to eq('proj1')
    end

    it "automatically generates and assigns the project a unique id" do
      expect(proj.id).to eq(1)
      expect(proj2.id).to eq(2)
    end
  end

  describe '.add_task' do
    it "allows user to add tasks" do
      proj.add_task('something to do', 2)
      proj.add_task('something else', 1)
      proj2.add_task('another thing', 1)
      expect(proj.tasks.size).to eq(2)
      expect(proj2.tasks.size).to eq(1)
    end
  end

  describe '.list_all_tasks' do
      before do
        $stdout = StringIO.new
      end

      after(:all) do
        $stdout = STDOUT
      end
    it "lists all tasks and their associated indices" do
      proj.add_task('something to do', 2)
      proj.add_task('something else', 1)
      proj.list_all_tasks
      expect($stdout.string).to match('Task ID 0: something to do\nTask ID 1: something else')
    end
  end

  describe '.list_completed_tasks' do
    it "can retrieve a list of complete tasks sorted by creation date" do
      task1 = proj.add_task('something to do', 2)
      task2 = proj.add_task('should be the last thing', 1)
      task3 = proj.add_task('something else', 1)

      time1 = Time.parse("12:00")
      time2 = Time.parse("15:00")
      Time.stub(:now).and_return(time1)
      Time.stub(:now).and_return(time2)

      proj.tasks[1].creation_date = time2
      proj.tasks[2].creation_date = time1

      proj.tasks[1].mark_complete
      proj.tasks[2].mark_complete
      expect(proj.list_completed_tasks).to eq([proj.tasks[2], proj.tasks[1]])
    end
  end

  describe '.list_incomplete_tasks' do
    context "no ties" do
      it "can retrieve a list of incomplete tasks sorted by priority" do
        task1 = proj.add_task('something to do', 2)
        task2 = proj.add_task('something else', 1)
        expect(proj.list_incomplete_tasks).to eq([proj.tasks[1], proj.tasks[0]])
      end
    end

    context "two tasks are tied" do
      it "prioritizes older tasks if two are tied" do
        task1 = proj.add_task('something to do', 2)
        task2 = proj.add_task('something else', 1)
        task3 = proj.add_task('should be the second thing', 1)

        time1 = Time.parse("12:00")
        time2 = Time.parse("15:00")
        Time.stub(:now).and_return(time1)
        Time.stub(:now).and_return(time2)

        proj.tasks[1].creation_date = time2
        proj.tasks[2].creation_date = time1

        expect(proj.list_incomplete_tasks).to eq([proj.tasks[2], proj.tasks[1], proj.tasks[0]])
      end
    end
  end
end
