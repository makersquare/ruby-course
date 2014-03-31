require 'spec_helper'

describe TM::CreateProject do
  before do
    @db = TM.db
  end
  it 'exists' do
    expect(TM::CreateProject).to be_a(Class)
  end

  it 'creates a project' do

    result = subject.run({:project_name => 'a project name'})
    expect(result.success?). to eq(true)
    expect(result.project.project_name).to eq('a project name')
  end

  it 'fails if no name is provided' do
    result = subject.run({:project_name => ''})
    expect(result.error?).to eq(true)
    expect(result.error).to eq :please_provide_a_project_name
  end

end
