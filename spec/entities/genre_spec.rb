require_relative '../spec_helper.rb'

describe 'Songify::Genre' do
	it 'will initialize a genre with two attributes' do
		genre = Songify::Genre.new('electro')
		expect(genre.name).to eq('electro')
		expect(genre.id).to eq(nil)
	end
	
end