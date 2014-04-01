require 'spec_helper'
describe TM::CreateTask do
  before do
    @db = TM.DB
  end

  it "creates task" do
    project = @db.create_project('youngmoney')
    emp = @db.create_employee('weezy')
    result = subject.run(:pid => project.id, :eid => emp.id, :description => 'description')
    expect(result.success?).to eq true
    expect(result.task.description).to eq 'description'
    expect(result.task.pid).to eq project.id
  end

  it 'fails if no task is provided' do
    result = subject.run({:description => ""})
    expect(result.error?).to eq true
    expect(result.error).to eq :provide_info
  end

end
