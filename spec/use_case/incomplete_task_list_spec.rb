require 'spec_helper.rb'
describe TM::IncompleteTaskList do
  before do
    @db = TM.db
    @project = @db.create_project("test")
  end

  it "Lists all incomplete projects" do
    task1 = @db.create_task("A fun task", 5, @project.project_id)
    task2 = @db.create_task("A fun task", 5, @project.project_id)
    task3 = @db.create_task("A fun task", 5, @project.project_id)
    task4 = @db.create_task("A fun task", 5, @project.project_id)
    task5 = @db.create_task("A fun task", 5, @project.project_id)
    task6 = @db.create_task("A fun task", 5, @project.project_id)
    task7 = @db.create_task("A fun task", 5, @project.project_id)



    @db.mark_task_complete(task1.task_id)
    @db.mark_task_complete(task4.task_id)
    @db.mark_task_complete(task7.task_id)

    result = subject.run({ :project_id => @project.project_id })
    expect(result.success?).to eq(true)
    expect(result.tasks.size).to eq(4)
    expect(result.tasks.last.task_id).to eq(task6.task_id)
  end

  it "returns error if project does not exist" do
    result = subject.run({ :project_id => 999 })
    expect(result.error?).to eq(true)
    expect(result.error).to eq(:project_does_not_exist)
  end
end
