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

  # describe '.list_completed_tasks' do
  #   before do
  #     $stdout = StringIO.new
  #   end

  #   after(:all) do
  #     $stdout = STDOUT
  #   end

  #   it "can retrieve a list of complete tasks sorted by creation date" do

  #     time1 = Time.parse("12:00")
  #     time2 = Time.parse("15:00")
  #     Time.stub(:now).and_return(time1)
  #     Time.stub(:now).and_return(time2)

  #     proj1.tasks[1].creation_date = time2
  #     proj1.tasks[2].creation_date = time1

  #     proj1.tasks[1].mark_complete
  #     proj1.tasks[2].mark_complete
  #     proj1.list_completed_tasks
  #     expect($stdout.string).to match('TID 2: proj 1 tid 2\nTID 1: proj 1 tid 1')
  #   end
  # end

  # describe '.list_incomplete_tasks' do
  #   before do
  #     $stdout = StringIO.new
  #   end

  #   after(:all) do
  #     $stdout = STDOUT
  #   end

  #   it "can retrieve a list of incomplete tasks sorted by priority, prioritizing older tasks if two are tied" do
  #     time1 = Time.parse("12:00")
  #     time2 = Time.parse("15:00")
  #     Time.stub(:now).and_return(time1)
  #     Time.stub(:now).and_return(time2)

  #     proj2.tasks[1].creation_date = time2
  #     proj2.tasks[2].creation_date = time1
  #     proj2.list_incomplete_tasks
  #     expect($stdout.string).to match('TID 5: Priority 2, proj 2 tid 5\nTID 4: Priority 2, proj 2 tid 4\nTID 3: Priority 3, proj 2 tid 3')
  #   end
  # end

  # describe 'list_projs' do
  #   before do
  #     $stdout = StringIO.new
  #   end

  #   after(:all) do
  #     $stdout = STDOUT
  #   end

  #   it "lists all projects and associated ids" do
  #     proj1.list_projs
  #     expect($stdout.string).to match('PID 0: proj1\nPID 1: proj2')
  #   end
  # end
end
