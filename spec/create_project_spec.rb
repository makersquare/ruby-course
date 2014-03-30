require 'spec_helper'

module TM

  describe CreateProject do
    it "returns an error if no name is passed" do
      result = CreateProject.run("")
      expect(result.success?).to eq(false)
      expect(result.error).to eq(:name_field_empty)
    end

    it "can create a project" do
      result = CreateProject.run("Maim Bob")
    end
  end
end
