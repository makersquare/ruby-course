require 'spec_helper'

module TM

  describe ListProjects do
    it "returns an error if there are no projects" do
      result = ListProjects.run
      expect(result.success?).to eq(false)
      expect(result.error).to eq(:no_projects_found)
    end

    it "can return a list of projects" do
      CreateProject.run("Maim Bob")
      CreateProject.run("Maim Sue")
      CreateProject.run("Injure Sam")

      result = ListProjects.run
      expect(result.success?).to eq(true)
      expect(result.projects_list).to be_a(Array)
      expect(result.projects_list.length).to eq(3)
    end
  end
end
