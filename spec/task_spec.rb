require 'spec_helper'

describe 'Task' do
  before(:each) do
    @t1 = TM::Task.new('t1', 'learning things', 1)
    @t2 = TM::Task.new('t2','learning moar things', 2)
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



  xit 'can be marked as complete, specified by id' do
    fancy = TM::Task.new('id', 'learning things', 1)

    expect(fancy.priority_number).to eq(1)
  end
end


