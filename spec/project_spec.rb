require 'spec_helper'

describe 'Project' do

  let(:klass) { TM::Project }

  let(:args ) { { :id => 1, :name => 'Test Project' } }

  let(:project) { klass.new(args) }

  it "exists" do
    expect(klass).to be_a(Class)
  end

  it "initialize accepts an arg hash with id and name" do
    expect(project.id).to eq(1)
    expect(project.name).to eq('Test Project')
  end
end
