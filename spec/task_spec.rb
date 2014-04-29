require 'spec_helper'

describe 'Task' do
	describe "initialize method" do
		it "exists" do
			expect(TM::Task).to be_a(Class)
		end

		it "can be initialized with a name" do

		end

		it "has a default name of 'default' if name not specified" do

		end

		it "creates a unique ID is created starting with id=1" do

		end

		it "has a project ID that defults to nil (unassigned)" do

		end

		it "creates multiple unique IDS in numerical order" do

		end

		it "can be initialized with a description" do

		end

		it "has default description of 'none'" do

		end

		it "has a priority number" do

		end

		it "has a default priority number of 1" do

		end

		it "has a creation date" do

		end

		it "creation date works with Time.now" do

		end

		it "has a completed boolean variable with default value false" do

		end

		it "has a completed date with default value nil" do 
		end


	end
end
