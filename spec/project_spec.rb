require 'spec_helper'
require 'pry'

describe 'Project' do
  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  let(:project) { TM::Project.new('Moving') }

  before(:each) do
    reset_class_variables(TM::Project)
  end

  describe '.initialize' do
    it "requires a name" do
      expect { TM::Project.new }.to raise_error(ArgumentError)
      expect { project }.not_to raise_error
    end

    it "assigns a unique id" do
      expect(project.id).to eq(0)
      expect(TM::Project.new('Second').id).to eq(1)
    end
  end

  describe '.generate_id' do
    it 'generates a unique id' do
      expect(TM::Project.generate_id).to eq(0)
      expect(TM::Project.generate_id).to eq(1)
      expect(TM::Project.generate_id).to eq(2)
    end
  end
end
