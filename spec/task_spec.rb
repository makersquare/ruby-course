require 'spec_helper'

describe 'Task' do
  before do
    expect(TM::Task).to receive(:generate_id).and_return(1)
    @task = TM::Task.new("description", 2)
  end

  it "exists" do
    expect(TM::Task).to be_a(Class)
  end

  describe "initialize" do
    it "is assigned the task id" do
      result = @task.id
      result2 = @task.project_id
      expect(result).to eq 1
      expect(result2).to eq nil
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
