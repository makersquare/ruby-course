require 'spec_helper'

describe TM::ShowCompletedTasks do
  before do
    @db = TM.db
  end
  it 'succesfully retrieves a list of completed tasks'do
    project = @db.create_project('a new project')
    task1 = @db.add_task_to_project('a new task',1, project.id )
    task2 = @db.add_task_to_project('a newer task',2, project.id )
    task3 = @db.add_task_to_project('a newest task',1, project.id )

    completed_task = @db.mark_task_complete(task1.id)
    completed_task2 = @db.mark_task_complete(task3.id)


    result = subject.run({pid: project.id})
    expect(result.success?). to eq(true)
    expect(result.completed_tasks.first.description).to eq('a new task')
    expect(result.completed_tasks.last.description).to eq('a newest task')
  end

  it 'returns an error if the project does not exist' do
      result = subject.run({pid: 999})
      expect(result.error?).to eq(true)
      expect(result.error).to eq :project_doesnt_exist
  end


end
