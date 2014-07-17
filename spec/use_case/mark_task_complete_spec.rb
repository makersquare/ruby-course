require 'spec_helper.rb'
 describe TM::MarkTaskComplete do
  before do
    @db = TM.db
    @project = @db.create_project("Test")
  end

  it "marks a task complete" do
    task = @db.create_task("New task", 1, @project.project_id)

    expect(task).to be_a(TM::Task)

    result = subject.run({ :task_id => task.task_id })
    expect(result.task.complete).to eq(true)
    expect(result.success?).to eq(true)

  end

  it "returns error if task id does not exist" do
    result = subject.run({ :task_id => 1000 })
    expect(result.error?).to eq(true)
    expect(result.error).to eq :task_does_not_exist
  end
 end
