require 'spec_helper'

describe Lucky do
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

    it 'should raise an error if string contains non-digits' do
      str = '9a7s7d33'
      expect { Lucky.check(str) }.to raise_error
    end

    it 'should raise an error if string is empty' do
      expect { Lucky.check('') }.to raise_error
    end
  end
end
