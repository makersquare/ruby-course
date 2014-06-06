require 'spec_helper'

describe Lucky do
  describe 
  it 'should return true' do
    str = '287935'
    response = Lucky.check(str)
    expect(response).to be true
  end

  it 'should return false' do
    str = '5675612399'
    response = Lucky.check(str)
    expect(response).to be false
  end

  describe 'extensions', :pending => true do
    it 'should handle an odd character count correctly' do
      str = '2871935'
      response = Lucky.check(str)
      expect(response).to be true
    end

    it 'should return :error if string contains non-digits' do
      str = '9a7s7d33'
      response = Lucky.check(str)
      expect(response).to eq(:error)
    end

    it 'should return :error if string is empty' do
      str = ''
      response = Lucky.check(str)
      expect(response).to eq(:error)
    end
  end
end
