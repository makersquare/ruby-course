require 'spec_helper'

describe 'Task' do
  before do
    @new_task = TM::Task.new(1, "take out the trash", 1)
  end
  it "exists" do
    expect(TM::Task).to be_a(Class)
  end
  describe '.initialize' do
    it 'is created with a project id' do
      result = @new_task.project_id
      expect(result).to eq(1)
    end
    it 'is created with a description' do
      result = @new_task.description
      expect(result).to eq("take out the trash")
    end

    it 'is created with a priority number' do
      result = @new_task.priority
      expect(result).to eq(1)
    end

  end
end
