require 'spec_helper'
describe TM::ShowRemainingTasks do
  before do
    @db = TM.db
  end

  it 'successfully returns remaining tasks for a project' do
    project = @db.create_project('a new project')
    task1 = @db.add_task_to_project('a new task',1, project.id )
    task2 = @db.add_task_to_project('a newer task',2, project.id )
    task3 = @db.add_task_to_project('a newest task',1, project.id )

    completed_task = @db.mark_task_complete(task1.id)

    result = subject.run({pid: project.id})
    expect(result.success?). to eq(true)
    expect(result.remaining_tasks.first.description). to eq('a newer task')
  end

  it 'returns an error if pid doesn\'t exist' do
    created_project = @db.create_project('a new project')
    retrieved_project = @db.get_project(created_project.id)

    result = subject.run(pid: 999)
    expect(result.error?).to eq(true)
    expect(result.error).to eq :project_doesnt_exist
  end

  it 'returns an error if no pid is entered' do
    result = subject.run({pid: nil})
    expect(result.error?).to eq(true)
    expect(result.error).to eq :enter_a_project_id
  end



end
