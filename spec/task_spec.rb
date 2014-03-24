require 'spec_helper'

describe 'Task' do
  it "exists" do
    expect(TM::Task).to be_a(Class)
  end

  describe 'Is created with an id and with description and priority number' do
    before do
      @project = TM::Project.new("d")
      @project.add_task('list')
    end

    it 'project id matches the project id in task' do

      expect(@project.tasks[0].project_id).to eq(@project.project_id)
    end

    it 'created a task with a description' do
      expect(@project.tasks[0].description).to eq('list')
    end

    it 'adds a priority number for the task' do
      expect(@project.tasks[0].priority).to eq(3)
    end

  end



end

