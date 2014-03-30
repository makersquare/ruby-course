require 'spec_helper'
describe TM::AddTaskToProject do
  before do
    @db = TM.DB
  end

  it "adds a task to project2" do
    project = @db.create_project('project_name')
    project2 = @db.get_project(project.id)
    task = @db.create_task('description')
    result = subject.run(:pid => project2.id, :description => task.description)
    expect(result.success?).to eq true
    expect(result.tasks.pid).to eq project2.id
  end

  it 'fails if no id is provided' do
    result = subject.run(:pid => nil, :description => 'desription')
    expect(result.error?).to eq true
    expect(result.error).to eq :provide_a_project_id
  end

  it 'fails if no description is provided' do
    result = subject.run({:pid => 2,  :description => nil})
    expect(result.error?).to eq true
    expect(result.error).to eq :provide_a_task_description
  end

  it 'fails if project does not exist' do
    project = @db.create_project('project_name')
    result = subject.run(:pid => 10000, :description => 'description')
    expect(result.error?).to eq true
    expect(result.error).to eq :project_doesnt_exist
  end
end
