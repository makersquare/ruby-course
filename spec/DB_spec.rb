require 'spec_helper'

describe 'DB' do
  it 'exists' do
    expect(TM::DB).to be_a(Class)
  end

  before do
    @__db = TM::DB.new
  end

  describe 'initialize' do
    it 'has 4 hashes initialized for project, task, id, members' do
      expect(@__db.projects).to eq ({})
      expect(@__db.tasks).to eq ({})
      expect(@__db.employees).to eq ({})
      expect(@__db.memberships).to eq ({})
    end
  end

  describe 'creates a new project and stores in the database' do
    it 'creates a new project' do
      @__db.create_project('project_name')
      expect(@__db.projects[1].name).to eq('project_name')
    end
  end

  describe 'get Project by pid' do
    it 'returns a project object based on the pid' do
      new_project = @__db.create_project('project_name')
      result = @__db.get_project(1)
      expect(result).to eq new_project
    end
  end

end
