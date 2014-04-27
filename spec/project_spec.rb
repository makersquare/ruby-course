require 'spec_helper'
require 'pry'

describe 'Project' do
  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  let(:project) { TM::Project.new('Moving') }

  describe '.initialize' do
    it "requires a name" do
      expect { TM::Project.new }.to raise_error(ArgumentError)
      expect { project }.not_to raise_error
    end

    it "assigns a unique id" do
      expect(project.id).to eq(1)
      expect(TM::Project.new('Second').id).to eq(2)
    end
  end
end
