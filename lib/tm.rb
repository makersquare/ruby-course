#!/usr/bin/env ruby

require_relative 'task-manager.rb'

TM::Client.welcome

begin
  ('%s> ' % '>').display
  input = gets.chomp
  args = input.split /\s/

  TM::Client.process_command(args)
end while TM::Client.running?
