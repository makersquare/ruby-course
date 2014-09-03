require 'spec_helper'

describe Bookly::Book do

  describe '#initialize' do
    subject { Bookly::Book.new("Bob", Date.parse('2014-10-20')) }

    specify { expect(subject.name).to eq "Bob" }
    specify { expect(subject.published_at).to eq Date.parse('2014-10-20') }
  end
end
