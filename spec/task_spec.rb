require 'spec_helper'

describe 'Task' do
	before do
		@task = TM::Task.new("something cool")
	end
	it "exists" do
    	expect(TM::Task).to be_a(Class)
	end

	it "is created with a project id" do
		expect(@task.id).to eq(@task.object_id)
	end

	it "is created with a description" do
		expect(@task.description).to eq("something cool")
	end
end
