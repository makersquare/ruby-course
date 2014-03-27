require 'spec_helper'

describe 'Task' do
  before do
    TM::Task.class_variable_set :@@counter, 0
    @task = TM::Task.new("description")
  end

  it "exists" do
    expect(TM::Task).to be_a(Class)
  end

  describe "initialize" do
    it "is assigned the task id" do
      result = @task.id
      result2 = @task.pid
      expect(result).to eq 1
      expect(result2).to eq nil
    end

    it "is assigned the description" do
      result = @task.description
      expect(result).to eq 'description'
    end

    it "is assigned the priority" do
      result = @task.priority
      expect(result).to eq nil
    end

    it "is assigned a time created by default" do
      time_stub = Time.parse("10 am")
      Time.stub(:now).and_return(time_stub)

      newest_task = TM::Task.new("bla")

      result = newest_task.date_created
      expect(result).to eq(time_stub)
    end

  end


end
