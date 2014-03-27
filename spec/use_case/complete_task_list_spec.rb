require 'spec_helper.rb'
describe TM::CompleteTaskList do
  before do
    @db = TM.db
    @project = @db.create_project("Test")
  end

  it "Lists all complete projects" do
    10.times { @db.create_task("A fun task", 5, @project.project_id) }

    @db.mark_task_complete(5)
    @db.mark_task_complete(7)
    @db.mark_task_complete(10)

    result = subject.run({ :project_id => @project.project_id })
    expect(result.success?).to eq(true)
    expect(result.tasks.last.task_id).to eq(10)
  end

  it "returns error if project does not exist" do
    result = subject.run({ :project_id => 1000 })
    expect(result.error?).to eq(true)
    expect(result.error).to eq(:project_does_not_exist)
  end
end
