require 'spec_helper'

module TM
  describe GetTask do
    it "returns an error if the task is not found" do
      result = GetTask.run(99)
      expect(result.success?).to eq(false)
      expect(result.error).to eq(:task_not_found)
    end

    it "returns a task if it's found" do
      result = CreateProject.run("Kill Bob")
      project = result[:project]
      result = CreateTask.run({ project_id: project.id, description: "Buy gun", priority: 4 })
      task = result[:task]
      result = GetTask.run(task.id)
      expect(result.success?).to eq(true)
      expect(result[:task].description).to eq("Buy gun")
    end
  end
end
