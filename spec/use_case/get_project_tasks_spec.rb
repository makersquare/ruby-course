require 'spec_helper.rb'
describe TM::GetProjectTasks do
  before do
    @db = TM.db
    @project = @db.create_project("Test")
    @task1 = @db.create_task("Cool task", 5, @project.project_id)
    @task2 = @db.create_task("Cool task", 5, @project.project_id)
    @task3 = @db.create_task("Cool task", 5, @project.project_id)
    @task4 = @db.create_task("Cool task", 5, @project.project_id)
    @task5 = @db.create_task("Cool task", 5, @project.project_id)
  end

  it "returns tasks for a project" do
    result = subject.run({ :project_id => @project.project_id })
    expect(result.success?).to eq(true)
    expect(result.tasks.size).to eq(5)
    puts result.tasks.size
    puts result.tasks
    puts result.tasks.class
    expect(result.tasks[4].task_id).to eq(@task5.task_id)
  end

  it "returns an error if project_id does not exist" do
    result = subject.run({ :project_id => 9999 })
    expect(result.error?).to eq(true)
    expect(result.error).to eq(:project_does_not_exist)
  end
end
