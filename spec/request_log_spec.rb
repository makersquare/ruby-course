require_relative 'spec_helper.rb'
require 'pry-byebug'

describe PuppyBreeder::RequestLog do
  it 'creates a new inventory' do
    test = PuppyBreeder::RequestLog.new

    expect(test.class).to eq(PuppyBreeder::RequestLog)
  end
  it 'adds a request to the request log' do
    request = PuppyBreeder::PurchaseRequest.new("Schnauzer")
    log = PuppyBreeder::RequestLog.new
    log.add_request(request)

    expect(log.request_log.first).to eq(request)

  end
end