require 'spec_helper'

describe 'Task' do
	before do
		@task = TM::Task.new(123, "something cool")
	end
	it "exists" do
    	expect(TM::Task).to be_a(Class)
	end
end
