module PuppyBreeder
  class List
    attr_reader :name, :breed, :list

    def initialize(params)
      @name = params[:name]
      @breed = params[:breed]
      @list = []
    end

    def length
      @list.length
    end

    def add(item)
      @list << item
    end
  end
end