require 'spec_helper'

describe 'Project' do
  # before block to reset id_generator
  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  let(:project1) {TM::Project.new("Portfolio")}
  let(:project2) {TM::Project.new("Website")}

  describe '#initialize' do
    it "is a Project" do
      expect(project1).to be_a(TM::Project)
    end
    it "creates a unique project id" do # reset class variablo for all tests
      expect(project1.project_id).to eq(1)
      expect(project2.project_id).to eq(2)
    end
    it "accepts a name argument" do
      expect(project1.name).to eq("Portfolio")
    end
    it "creates an array to store tasks" do
      expect(project1.tasks).to be_a(Array)
    end
    it "the array is empty" do
      expect(project1.tasks.count).to eq(0)
    end
  end

  describe '.list_projects' do
    it "lists all projects" do
      expect(TM::Project.list_projects.count).to eq(6)
    end
  end

  describe '#add_task' do
    it "adds a task to the tasks array" do
      project1.add_task("Design a wireframe", 5)

      expect(project1.tasks.count).to eq(1)
    end
  end

  describe '#list_complete' do
    context "when all tasks are complete" do
      it "sorts by creation time" do
        project1.add_task("Use foundation for framework", 4, 987654321)
        project1.add_task("Design a wireframe", 5, 123456789)
        project1.tasks.select { |task| task.complete = true }
        project1.list_complete

        expect(project1.completed_tasks.first.description).to eq("Use foundation for framework")
      end
    end
  end

  describe '#list_incomplete' do
    context "when all tasks are incomplete" do
      it "sorts by priority" do
        project1.add_task("Use foundation for framework", 4, 0)
        project1.add_task("Design a wireframe", 3, 0)
        project1.add_task("Begin building", 5, 0)
        project1.list_incomplete

        expect(project1.incompleted_tasks.first.description).to eq("Begin building")
      end
    end
  end

  describe '.mark task' do
    it "marks a task as complete" do
      project_test = TM::Project.list_projects.first
      project_test.add_task("This is a description", 5)
      project_test.add_task("This is another description", 4)
      TM::Project.complete_task(0, 0)

      expect(project_test.tasks[0].complete).to eq(true)
    end
  end

end
