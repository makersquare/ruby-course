# require 'spec_helper'
# require_relative '../../lib/use-cases/create_project.rb'
describe TM::CreateProjects do
  before do
    @db = TM.DB
  end

  it "creates a project" do
    result = subject.run(:project_name => 'project_name')
    expect(result.success?).to eq true
    expect(result.project.name).to eq 'project_name'
  end

  it 'fails if no name is provided' do
    result = subject.run({:project_name => nil})
    expect(result.error?).to eq true
    expect(result.error).to eq :provide_a_project_name
  end
end
