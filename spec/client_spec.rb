require 'spec_helper'

describe 'Client' do

  it "exists" do
    expect(TM::Client).to be_a(Class)
  end

  it "responds to 'welcome' by printing out the command list" do
    expect( TM::Client.respond_to?(:welcome) ).to eq(true)
  end

  it "responds to 'process_command' given an args hash by printing out the results" do
    expect( TM::Client.respond_to?(:process_command) ).to eq(true)
  end

  it "responds to 'running?' by returning true or false given the state of the program" do
    expect( TM::Client.respond_to?(:running?) ).to eq(true)
  end
end
