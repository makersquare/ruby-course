require 'spec_helper'

module TM
  describe 'Project' do
    it "exists" do
      expect(Project).to be_a(Class)
    end

    it "can be created with a name" do
      project1 = Project.new("Maim Bob")
      expect(project1.name).to eq("Maim Bob")
    end


  end
end
