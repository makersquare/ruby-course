require 'spec_helper'

describe "TM::ProjectList" do
	before  do
		pl = TM::ProjectList.new
	end

	it "exists" do
		expect(TM::ProjectList).to be_a(Class)
	end

end