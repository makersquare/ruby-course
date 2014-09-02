require_relative 'spec_helper.rb'



describe PuppyBreeder::PurchaseRequest do
  it 'Creates a Puppy Request' do 
    a = PuppyBreeder::PurchaseRequest
    b = PuppyBreeder::PurchaseRequest.new('mix')
    expect(b.request_id).to eq(1)
    expect(b.breed).to eq('mix')
    expect(b.status).to eq(false)
    c = PuppyBreeder::PurchaseRequest.new('mix')
    expect(c.request_id).to eq(2)
  end
end


describe PuppyBreeder::RequestRepository do
  



end