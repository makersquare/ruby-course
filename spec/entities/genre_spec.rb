require_relative '../spec_helper.rb'

describe Songify::Genre do
	
	let(:genre) { Songify::Genre.new('fake_genre') }

	it 'will initialize with 1 attribute and nil id' do
		expect(genre.name).to eq('fake_genre')
		expect(genre.id).to be_nil
	end

end