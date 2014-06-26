require 'spec_helper'
require 'pry'

describe "Datebase" do

  it 'exist' do
    expect(Database).to be_a(Class)
  end

end
