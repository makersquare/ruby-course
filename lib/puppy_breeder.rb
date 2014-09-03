# we initialize the module here to use in our other files
module PuppyBreeder
  def self.puppy_container
    @__db_instance ||= PuppyBreeder::PuppyContainer.new
  end
end

require_relative 'puppy_breeder/puppy.rb'
require_relative 'puppy_breeder/purchase_request.rb'
require_relative 'puppy_breeder/puppy_container.rb'
require_relative 'puppy_breeder/purchase_request_container.rb'
