module PuppyBreeder
  class Data
    class << self
      attr_accessor :allpuppies, :allrequests, :cost
    end

    @cost = {}
    @allpuppies = []
    @allrequests = []

  end
end