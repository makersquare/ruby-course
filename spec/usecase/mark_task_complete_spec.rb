require 'spec_helper'

describe TM::MarkTaskComplete do
  it 'successfully marks a task complete' do
    task = TM.db.add_task_to_project('a task', 1, 1)
    result = subject.run(tid: task.id)
    expect(result.completed_task.complete).to eq(true)
    expect(result.completed_task.description).to eq('a task')
  end
end
