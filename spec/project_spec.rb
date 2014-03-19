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

  it "can retrieve a list of all completed tasks, sorted by creation date" do

    # The add_task method returns the task object.
    #
    # Thus we can set the returned task objects to variables:
    # task_1, task_2, task_3
    #
    task_1 = project.add_task("collect 20 hats", 2)
    task_2 = project.add_task("watch a funny video", 3)
    task_3 = project.add_task("sell rolex watch", 1)

    project.mark_as_complete(task_1.id)
    project.mark_as_complete(task_2.id)
    project.mark_as_complete(task_3.id)

    # the array in eq() starts from task_3 because
    # we want it to be sorted starting from most recently created
    expect(project.list_completed_tasks).to eq([task_3, task_2, task_1])
  end

  describe 'retrieve list of incompleted tasks' do

    it "retrieve a list of all incomplete tasks, sorted by priority" do

      # The add_task method returns the task object.
      #
      # Thus we can set the returned task objects to variables:
      # task_1, task_2, task_3
      #
      task_1 = project.add_task("collect 20 hats", 2)
      task_2 = project.add_task("watch a funny video", 3)
      task_3 = project.add_task("sell rolex watch", 1)

      # the array in eq() starts from task_2 because
      # we want it to be sorted starting from highest priority created
      expect(project.list_incomplete_tasks).to eq([task_2, task_1, task_3])
    end

    context "if two or more tasks have same priority number" do
      it "the older task gets priority" do
        task_1 = project.add_task("put on cologne", 1)
        task_2 = project.add_task("smell some roses", 3)
        task_3 = project.add_task("draw stick figure", 1)
        task_4 = project.add_task("chill out", 3)


        expect(project.list_incomplete_tasks).to eq([task_2, task_4, task_1, task_3])
      end
    end
  end

end
