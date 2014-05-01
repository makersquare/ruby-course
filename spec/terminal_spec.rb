require 'spec_helper'

describe 'TerminalClient' do

  before(:all) do
    @terminal = TM::TerminalClient.new
  end

  before(:each) do
    TM::Project.reset_class_vars
    TM::Task.reset_class_vars
  end

  describe '.initialize' do
  end

  describe '.get_input' do
  end

  describe '.parse_cmd' do
    it "returns an emtpy args array for single word cmds" do
      result = @terminal.parse_cmd('list')
      expect(result).to eq(['list', []])
    end

    it "returns an args array for cmds that require >1 parameter" do
      expect(@terminal.parse_cmd('create asdf')).to eq(['create', ['asdf']])
      expect(@terminal.parse_cmd('create multi word name')).to eq(['create', ['multi', 'word', 'name']])
      expect(@terminal.parse_cmd('add 1 do some stuff')).to eq(['add', ['1', 'do', 'some', 'stuff']])
    end
  end

  describe 'exec_cmd' do

    describe 'help' do
    end

    describe 'list' do
      it 'lists all projects' do
        list1 = @terminal.exec_cmd(@terminal.parse_cmd('list'))
        expect(list1).to eq([])

        mayhem = TM::Project.new('mayhem')
        list2 = @terminal.exec_cmd(@terminal.parse_cmd('list'))
        expect(list2).to eq([mayhem])

        runway = TM::Project.new('runway')
        list3 = @terminal.exec_cmd(@terminal.parse_cmd('list'))
        expect(list3).to eq([mayhem, runway])
      end
    end

    describe 'create' do
      it "creates a new project with a name" do
        p = @terminal.exec_cmd(@terminal.parse_cmd('create ASDF'))
        expect(p.name).to eq("ASDF")
      end
    end
    describe 'show' do
    end
    describe 'history' do
    end
    describe 'add' do
    end
    describe 'mark' do
    end
    describe 'exit' do
    end

  end

  describe '.list_all_projects' do
  end

  describe '.create_project' do
  end

  describe '.display_incomplete' do
  end

  describe '.create_new_task' do
  end


end
