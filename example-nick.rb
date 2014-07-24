class PuppyContainer
	@container = {}
end

price_list = {
	:boxer => 5000,
	:pit => 10000
}

@container = {
	:boxer => {
		:price => 5000,
		:list => [pup1,pup2]
	},
	:pit => {
		:price => 10000,
		:list => [pup3, pup4]
	}
}

atlas = Puppy.new(:lab, "atlas", 50)

def add_puppy_to_puppy_container(puppy)
	if @container.has_key?(puppy.breed)
		# do somestuff here
	else
		@container[puppy.breed] = {:price => :unknown, :list => [puppy]}
end