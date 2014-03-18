require 'spec_helper'

describe 'Task' do
  it "exists" do
    expect(TM::Task).to be_a(Class)
  end

  before do
    @task = TM::Task.new(1, "description", 2)
  end

  describe "initialize" do
    it "is assigned the task id" do
      result = @task.task_id
      result2 = @task.project_id
      expect(result).to eq 2
      expect(result2).to eq 1
    end

    it "is assigned the description" do
      result = @task.description
      expect(result).to eq 'description'
    end

    it "is assigned the priority" do
      result = @task.priority
      expect(result).to eq 2
    end
  end
end
