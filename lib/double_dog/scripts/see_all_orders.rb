module DoubleDog
  class SeeAllOrders < TransactionScript

    include DoubleDog::Mixins::AdminSession

    def run(params)
      return failure(:not_admin) unless admin_session?(params[:admin_session])

      orders = DoubleDog.db.all_orders
      return success(orders: orders)
    end

  end
end