require 'spec_helper'
describe TM::ShowRemainingTasks do
  before do
    @db = TM.DB
  end

  it "shows remaining tasks" do
    project = @db.create_project('project_name')
    task = @db.add_task_to_project('description', 1, project.id)
    task2 = @db.get_task(task.id)
    result = subject.run(:pid => project.id)

    expect(result.success?).to eq true
    expect(result.tasks.first.description).to eq task2.description
  end

  it 'fails if no id is provided' do
    result = subject.run({:pid => nil})
    expect(result.error?).to eq true
    expect(result.error).to eq :provide_a_project_id
  end

  it 'fails if project does not exist' do
    project = @db.create_project('project_name')
    result = subject.run(pid: 10000)
    expect(result.error?).to eq true
    expect(result.error).to eq :project_doesnt_exist
  end
end
