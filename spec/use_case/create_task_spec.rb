require 'spec_helper'

module TM
  describe CreateTask do

    before do
      @project1 = CreateProject.run("Kill Bob").project
    end

    it "returns an error if no description is given" do
      result1 = CreateTask.run({ project_id: @project1.id, priority: 4 })
      expect(result1.success?).to eq(false)
      expect(result1.error).to eq(:no_description_provided)
    end

    it "returns an error if no priority is given" do
      result = CreateTask.run({ project_id: @project1.id, description: "do stuff" })
      expect(result.success?).to eq(false)
      expect(result.error).to eq(:no_priority_provided)
    end

    it "returns an error if project is not found" do
      result = CreateTask.run({ project_id: 99, description: "do stuff", priority: 5 })
      expect(result.success?).to eq(false)
      expect(result.error).to eq(:no_project_found)
    end

    it "adds a task if everything worked out" do
      result = CreateTask.run({ project_id: @project1.id, description: "do stuff", priority: 3 })
      expect(result.success?).to eq(true)
      expect(result.task.description).to eq("do stuff")

    end

  end
end
