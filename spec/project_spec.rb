require 'spec_helper'

describe 'Project' do
  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  it "allows a new project to be created with a name" do
      shopping = TM::Project.new("Shopping")
      expect(shopping.name).to eq("Shopping")
      expect(shopping.pid).to eq(1)
  end
end
