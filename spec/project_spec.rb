require 'spec_helper'
# require 'pry-debugger'

describe 'Project' do
  it "exists" do
    expect(TM::Project).to be_a(Class)
  end
  describe "During initialization" do
    it 'create a name and id' do
      project1 = TM::Project.new("project1")
      expect(project1.name).to eq("project1")
      expect(project1.id).to eq(1)

      project2 = TM::Project.new("project2")
      expect(project2.name).to eq("project2")
      expect(project2.id).to eq(2)
    end
  end
  describe "Make a new task"
    it 'creates a new task' do
      project1 = TM::Project.new("project1")

      expect(project1.tasks.size).to eq(0)
      project1.create_task("task1", 3)

      expect(project1.tasks.size).to eq(1)

      project1.create_task("task2", 1)
      expect(project1.tasks.size).to eq(2)
    end
  end

  context "sort tasks" do
    it 'by priority number' do
    end
  end

  context 'sort tasks' do
    it 'sorts tasks by completion date' do
    end
  end

  context 'retrieves list' do
    it 'of completed tasks' do
    end
  end

  context 'retrives list'
  it 'retrives a list of all incomplete tasks' do
  end
end

  it 'sorts the tasks in an incomplete list by priorty number' do
  end

  it 'sorts tasks in an incomplete list by creation date if the priority number is the same' do
  end

end



