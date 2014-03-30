require 'spec_helper'

describe TM::AddTaskToProject do
  it 'successfully adds a task to a project' do
    project = TM.db.create_project('a new project')
    result = subject.run(description: 'a new task', priority: 1, pid: project.id)

    expect(result.success?).to eq(true)

    retrieved_task = TM.db.get_task(result.added_task.id)

    expect(result.added_task.description).to eq(retrieved_task.description)

  end
end
