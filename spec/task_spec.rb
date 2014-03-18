require 'spec_helper'

describe 'Task' do
  it "exists" do
    expect(TM::Task).to be_a(Class)
  end

  describe 'Is created with an id and with description and priority number' do
    before do
      @project = TM::Project.new("d")
      @task = TM::Task.new("list")
    end

    it 'created task with project id' do
      expect(@task.id).to eq(@task.object_id)
    end

    it 'created task with a description' do

      expect(@task.description).to eq("list")
    end

    it 'has a priority number' do

      expect(@task.priority).to eq(3)
    end

  end



end

