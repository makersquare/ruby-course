require 'spec_helper'
require 'pry'

describe 'TerminalClient' do
  it "exists" do
    expect(TM::TerminalClient).to be_a(Class)
  end

  context 'a terminal client is initialized' do
    let(:terminal) { TM::TerminalClient.new }

    it 'has an array for projects' do
      expect(terminal.projects).to eq([])
    end
  end

  context 'a new project is created' do
    let(:terminal) { TM::TerminalClient.new }

    it 'can create a new project' do
      terminal.create_project("Project 1")
      expect(terminal.projects.count).to eq(1)
    end

  end
end
