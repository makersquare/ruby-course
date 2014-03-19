require 'spec_helper'

describe 'Project List' do
  before do
    @pl = TM::ProjectList.new
  end

  it "exists" do
    expect(TM::ProjectList).to be_a(Class)
  end

  it 'can create a project' do
    new_project = @pl.create_project('nato')

    expect(new_project).to eq(@pl.project_list)

  end

end
