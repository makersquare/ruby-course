require 'spec_helper'

describe 'Project' do
  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  let(:project1) {TM::Project.new("Portfolio")}
  let(:project2) {TM::Project.new("Website")}

  describe '#initialize' do
    it "is a Project" do
      expect(project1).to be_a(TM::Project)
    end
    it "creates a unique project id" do
      expect(project1.project_id.to_s.length).to eq(9)
      expect(project2.project_id).not_to eq(project1.project_id)
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



  describe '#add_task' do
    it "adds a task to the tasks array" do
      project1.add_task("Design a wireframe", 5, 123456789)

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
      it "sorts by priority & creation time" do
        project1.add_task("Use foundation for framework", 4, 987654321)
        project1.add_task("Design a wireframe", 5, 123456789)
        project1.add_task("Begin building", 5, 123453429)
        project1.list_incomplete

        expect(project1.incompleted_tasks.first.description).to eq("Use foundation for framework")
      end
    end
  end

end
