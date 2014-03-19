require 'spec_helper'

describe 'Project' do

  # the 'let' method creates a local variable like this:
  #
  # project = TM::Project.new("Bird Watching")
  #
  # the neat thing is this local variable can be used throughout this describe block
  let(:project) { TM::Project.new("Bird Watching") }


  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  describe '.initialize' do
    it "gives a name" do
      expect(project.name).to eq("Bird Watching")
    end

    it "generates and assigns an id" do
      expect(TM::Project).to receive(:gen_id).and_return(1)
      expect(project.id).to eq(1)
    end
  end


  it "can add tasks to a tasks array" do
    project.add_task("collect 20 hats", 2)
    task = project.tasks.first

    expect(project.tasks.count).to eq(1)
    expect(task.description).to eq("collect 20 hats")
  end

  it "can mark a task as complete" do
    project.add_task("collect 20 hats", 2)
    first_task = project.tasks.first
    first_task_id = project.tasks.first.id
    project.mark_as_complete(first_task_id)
    expect(first_task.completed).to eq(true)

    # ensure it works with another task added to tasy array
    project.add_task("watch a funny video", 3)
    last_task = project.tasks.last
    last_task_id = project.tasks.last.id
    project.mark_as_complete(last_task_id)
    expect(last_task.completed).to eq(true)

  end
end
