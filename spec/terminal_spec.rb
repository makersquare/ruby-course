require 'spec_helper'
require 'pry'

describe 'TerminalClient' do
  it "exists" do
    expect(TM::TerminalClient).to be_a(Class)
  end
end
