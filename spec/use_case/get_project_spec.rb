require 'spec_helper'

module TM
  describe GetProject do
    it "returns an error if the project is not found" do
      result = GetProject.run(99)
      expect(result.success?).to eq(false)
      expect(result.error).to eq(:project_not_found)
    end

    it "returns a project if it's found" do
      project = CreateProject.run("Kill Bob")
      result = GetProject.run(project[:project].id)
      expect(result.success?).to eq(true)
      expect(result[:project].name).to eq("Kill Bob")
    end
  end
end
