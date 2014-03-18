require 'spec_helper'

describe 'Task' do
  it "exists" do
    expect(TM::Task).to be_a(Class)
  end

  describe 'Is created with project id with creation date and priority' do
    before do
      @project = TM::Project.new("d")
      @task = TM::Task.new()
    end
    it 'created with project id' do
      expect(@task.id).to eq(@task.object_id)

    end





  end



end

