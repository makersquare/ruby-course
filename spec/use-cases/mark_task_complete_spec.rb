require 'spec_helper'
describe TM::MarkComplete do
  before do
    @db = TM.DB
  end

  it "mark tasks complete" do
    task = @db.add_task_to_project('description', 1, 2)
    result = subject.run(:tid => task.id)
    expect(result.success?).to eq true
    expect(result.tasks.description).to eq task.description
  end

  it 'fails if task does not exist' do
    result = subject.run(:tid => 10000)
    expect(result.error?).to eq true
    expect(result.error).to eq :task_doesnt_exist
  end
end
