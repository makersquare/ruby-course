require 'spec_helper'
require 'pry-debugger'

describe 'Project' do
  # before do
  #   project1 = TM::Project.new("project1")
  # end

  it "exists" do
    # project1 = TM::Project.new("project1")
    expect(TM::Project).to be_a(Class)
  end

  describe "#initialize" do
    xit 'create a name and id' do
#change test
      project1 = TM::Project.new("project1")
      expect(project1.name).to eq("project1")
      expect(project1.id).to eq(2)

      project2 = TM::Project.new("project2")
      expect(project2.name).to eq("project2")
      expect(project2.id).to eq(3)
    end
  end

  describe "#task" do
    it 'new task created' do
      project1 = TM::Project.new("project1")
      expect(project1.tasks.size).to eq(0)
      project1.create_task("task1", 3)

      expect(project1.tasks.size).to eq(1)

      project1.create_task("task2", 1)
      expect(project1.tasks.size).to eq(2)
    end
  end

  describe '#mark_complete and #retrieve_completed_tasks' do
    it 'mark a task as completed by id and return a list of completed tasks' do
      project1 = TM::Project.new("project1")

      project1.create_task("task1", 3)
      allow(project1.tasks[0]).to receive(:task_id).and_return(1)
      project1.project_mark_complete(1)

      expect(project1.tasks[0].status).to eq("complete")

      project1.create_task("task2", 4)
      allow(project1.tasks[1]).to receive(:task_id).and_return(3)
      project1.project_mark_complete(3)

      expect(project1.tasks[1].status).to eq("complete")

      project1.create_task("task3", 4)

      expect(project1.tasks.size).to eq(3)

      # binding.pry

      expect(project1.retrieve_completed_tasks.size).to eq(2)
    end
  end
  #test and make sure sorting by creation date - mark complete


  describe "#retrieve_incomplete_tasks" do
    xit 'by priority number then creation date' do
      project1 = TM::Project.new("project1")

      project1.create_task("task1", 3)
      project1.create_task("task2", 4)
      project1.create_task("task3", 4)

      expect(project1.tasks.size).to eq(3)

      expect(project1.retrieve_incomplete_tasks.size).to eq(3)
    end
  end

end



