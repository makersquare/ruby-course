require 'spec_helper'

module TM

  describe "Database" do

    it 'exists' do
      expect(Database).to be_a(Class)
    end

    it 'can add a project' do
      db = Database.new
      new_proj = db.add_project('project 1')

      expect(db.projects[new_proj.project_id]).to eq(1)
    end

    it 'can get a project' do
      db = Database.new
      new_proj = db.add_project('project 1')

      expect(db.get_project[1].name).to eq(new_proj.name)


    end

  end


end
