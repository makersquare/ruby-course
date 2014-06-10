require 'spec_helper'

describe 'Project' do
  let(:test){TM::Project.new('first')}
  it "exists" do
    expect(TM::Project).to be_a(Class)
  end
  context 'project is started with a name' do
    it 'has a name' do
      expect(test.name).to eq('first')
    end
  end
  context 'starting a new project' do
    it 'has an id number' do
      expect(test.id).to be_a(Fixnum)
    end
  end
end
