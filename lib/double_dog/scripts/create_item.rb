module DoubleDog
  class CreateItem < TransactionScript

    include DoubleDog::Mixins::AdminSession

    def run(params)
      return failure(:not_admin) unless admin_session?(params[:session_id])
      return failure(:invalid_name) unless valid_name?(params[:name])
      return failure(:invalid_price) unless valid_price?(params[:price])

      item = DoubleDog.db.create_item(:name => params[:name], :price => params[:price])
      return success(:item => item)
    end

    def valid_name?(name)
      name != nil && name.length >= 1
    end

    def valid_price?(price)
      price != nil && price >= 0.50
    end

  end
end
