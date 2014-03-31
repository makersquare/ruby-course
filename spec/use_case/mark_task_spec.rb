require 'spec_helper'

module TM
  describe GetTask do
    it "returns an error if the task is not found" do
      result = MarkTask.run(99)
      expect(result.success?).to eq(false)
      expect(result.error).to eq(:task_not_found)
    end

    it "marks a task as complete if it's found" do
      result = CreateProject.run("Kill Bob")
      project = result[:project]
      result = CreateTask.run({ project_id: project.id, description: "Buy gun", priority: 4 })
      task = result[:task]
      result = MarkTask.run(task.id)
      expect(result.success?).to eq(true)
      expect(result[:task].finished?).to eq(true)
    end
  end
end
