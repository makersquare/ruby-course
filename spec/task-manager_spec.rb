require 'spec_helper'
require 'pry'

describe "Datebase" do
  before(:each) do
    @db = TM::Database.new
  end

  it 'exist' do
    expect(TM::Database).to be_a(Class)
  end

  context 'it is initialized' do
    it 'creates an empty projects hash' do
      expect(@db.projects).to eq({})
    end
  end

end
