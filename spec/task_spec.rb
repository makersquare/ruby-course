require 'spec_helper'


describe 'Task' do

  before do
    expect(TM::Task).to receive(:generate_id).and_return(0)
    @new_task = TM::Task.new("take out the trash")
  end

  it "exists" do
    expect(TM::Task).to be_a(Class)
  end

  describe '.initialize' do
    it 'is created with a project id' do
      result = @new_task.project_id
      expect(result).to eq(nil)
    end

    it 'is created with a description' do
      result = @new_task.description
      expect(result).to eq("take out the trash")
    end

    it 'is created with a priority number' do
      result = @new_task.priority
      expect(result).to eq(nil)
    end

    it 'has a unique id' do
      result = @new_task.id
      expect(result).to eq(0)
    end

    end

  end
