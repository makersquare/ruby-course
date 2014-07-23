require_relative '../puppy-breeder.rb'

# Note: In these tests we've aliased `you` to the method `it`. This
# is to make the tests easier to read :)


describe "Purchase Request class" do

  it "gives name of person who made the request " do
    request = PurchaseRequest.new("Cristina", :Yorkshire)
    expect(request.name).to eq "Cristina"
  end
  it "gives breed requested " do
      request = PurchaseRequest.new("Cristina", :Yorkshire)
      expect(request.breed).to eq(:Yorkshire)
  end
  it "gives initial status request " do
      request = PurchaseRequest.new("Cristina", :Yorkshire)
      expect(request.status).to eq(:pending)
  end
  it "gives pending " do
      request = PurchaseRequest.new("Cristina", :Yorkshire)
      expect(request.pending?).to be true
  end
  it "gives onhold " do
      request = PurchaseRequest.new("Cristina", :Yorkshire)
      expect(request.onhold?).to be false
  end
  it "gives accepted " do
      request = PurchaseRequest.new("Cristina", :Yorkshire)
      expect(request.accepted?).to be false  
  end
end

describe "Puppy class " do

  it "knows the name of the poppy" do
    puppy_new = Puppy.new(:Yorkshire, 3, "carri")
    expect(puppy_new.name).to eq "carri"
  end

  it "knows the breed of the poppy" do
    puppy_new = Puppy.new(:Yorkshire, 3, "carri")
    expect(puppy_new.breed).to eq (:Yorkshire)
  end
  it "knows the status of the given poppy" do
    puppy_new = Puppy.new(:Yorkshire, 3, "carri")
    expect(puppy_new.age).to eq (3)
  end
end 

  describe "PuppyContainer class " do

  it "gives an empty puppy_container" do
    expect(PuppyContainer.container).to eq ({})
  end
  it "adds puppy to puppy container" do
  puppy_new = Puppy.new(:Yorkshire, 3, "carri")
  x = PuppyContainer.add_puppy_to_puppy_container(puppy_new)
  expect(x).to eq ({:Yorkshire => {:price => :unknown, :list => [puppy_new]}})
  end
end 
  describe "RequestContainer class " do
  it "adds requests to container" do
    request = PurchaseRequest.new("Cristina", :Yorkshire)
    expect(RequestContainer.add_request_to_request_container(request)).to eq ([request])
  end
  it "adds two requests to container" do
    RequestContainer.instance_variable_set :@container, []
    req1 = PurchaseRequest.new("Cristina", :Yorkshire)
    req2 = PurchaseRequest.new("Steve", :Yorkshire)
    RequestContainer.add_request_to_request_container(req1)
    x = RequestContainer.add_request_to_request_container(req2)
    expect(x).to eq ([req1, req2])
  end

  it "accepts requests" do
    request = PurchaseRequest.new("Cristina", :Yorkshire)
    RequestContainer.accept_request(request)
    expect(request.status).to eq (:accepted)
  end
end
describe "RequestContainer class " do
  before(:all) do
    RequestContainer.instance_variable_set :@container, []
  end
  it "returns all accepted requests" do
    req1 = PurchaseRequest.new("Cristina", :Yorkshire)
    req2 = PurchaseRequest.new("Steve", :Yorkshire)
    puppy_new = Puppy.new(:Yorkshire, 3, "carri")
    PuppyContainer.add_puppy_to_puppy_container(puppy_new)
    RequestContainer.add_request_to_request_container(req1)
    RequestContainer.add_request_to_request_container(req2)
    expect(RequestContainer.request_active).to eq ([req1, req2])
  end
  it "accepts the given request" do
    req1 = PurchaseRequest.new("Cristina", :Yorkshire)
    RequestContainer.accept_request(req1)
    expect(req1.status).to eq (:accepted)
  end
  before(:each) do
    RequestContainer.instance_variable_set :@container, []
  end 
  it "shows all active requests" do
    req5 = PurchaseRequest.new("Cristina", :Yorkshire)
    req6 = PurchaseRequest.new("Steve", :Yorkshire)
    RequestContainer.add_request_to_request_container(req5)
    RequestContainer.add_request_to_request_container(req6)
    expect(RequestContainer.request_active).to eq ([req5,req6])
  end 
  it "shows all requests on hold " do
    req1 = PurchaseRequest.new("Cristina", :Yorkshire)
    RequestContainer.accept_request(req1)
    req3 = PurchaseRequest.new("Cristina", :doggy)
    RequestContainer.add_request_to_request_container(req3)
    expect(RequestContainer.request_on_hold).to eq ([req3])
  end    
end



