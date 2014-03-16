require_relative 'spec_helper'

describe Event do
  describe '.initialize' do
    it 'this it block should run' do
      event = Event.new('The Talk', 1000)
      # puts event.capacity
      expect(event.title).to eq('The Talk')
    end
  end
end

describe Clicker do
  it 'this block should also run' do
    clicker = Clicker.new
  end
end