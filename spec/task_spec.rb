require 'spec_helper'

describe 'Task' do
  before(:each) do
    @t1 = TM::Task.new('t1', 'learning things', 1)
    @t2 = TM::Task.new('t2','learning moar things', 2)
    @t3 = TM::Task.new('t3','learning moar things', 3)
  end

  it "exists" do
    expect(TM::Task).to be_a(Class)
  end

  it 'can be created with a description, and priority number' do
    expect(@t1.name).to eq('t1')
    expect(@t1.description).to eq('learning things')
    expect(@t1.priority_number).to eq(1)

    expect(@t2.name).to eq('t2')
    expect(@t2.description).to eq('learning moar things')
    expect(@t2.priority_number).to eq(2)
  end

  it 'can be marked as complete' do

    expect(@t1.complete).to eq(true)
    expect(@t2.complete).to eq(true)
    expect(@t3.complete).to eq(true)
  end

end


