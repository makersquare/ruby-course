require 'spec_helper'

describe 'ProjectList' do
  before do
    @project_list = TM::ProjectList.new
  end

  describe '#add_project' do
    it 'adds a project' do

      @project_list.add_project('take out the trash')

      result = @project_list.projects

      expect(result[0].project_name).to eq('take out the trash')
    end
  end

  describe '#list_projects' do
    it 'lists all projects' do
      @project_list.add_project('take over the world')
      @project_list.add_project('write a better javascript engine')
      @project_list.add_project('sleep')

      expect(STDOUT).to receive(:puts).with('take over the world')
      expect(STDOUT).to receive(:puts).with('write a better javascript engine')
      expect(STDOUT).to receive(:puts).with('sleep')

      @project_list.list_projects


    end
  end

end
