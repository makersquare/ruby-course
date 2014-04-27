require 'spec_helper'

describe 'Project' do
  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  describe '.initialize' do
    it "requires a name" do
      expect { TM::Project.new }.to raise_error(ArgumentError)
      expect { TM::Project.new('new project') }.not_to raise_error
    end
  end
end
