class Songify::Artist
  attr_reader :name
  def initialize(params)
    @name = params[:name]
  end

end