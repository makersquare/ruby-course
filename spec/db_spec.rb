require 'spec_helper'

module TM
  describe 'database' do
    it "can create a project" do
      project1 = TM.db.create_project("Maim Bob")
      expect(TM.db.get_project(project1.id)).to eq(project1)
    end


    xit "keeps a record of all created projects" do
    end

  end
end
