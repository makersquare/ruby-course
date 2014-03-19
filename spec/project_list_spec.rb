require 'spec_helper'

describe 'Project List' do
  before do
    @pl = TM::ProjectList.new
    @new_project = @pl.create_project('nato')
  end

  it "exists" do
    expect(TM::ProjectList).to be_a(Class)
  end

  it 'can create a project' do

    expect(@new_project).to eq(@pl.project_list)

  end

  it 'can get a project' do
    expect(@pl.get_project(1)).to eq(@new_project[0])

  end



end
