class OrdersController < ApplicationController
  before_action :set_order_context, only: [:new, :create]

  def new
    @order                  = Order.new(order_params)
    @order.shipping_address = current_user.shipping_addresses.first
    @shipping_address       = ShippingAddress.new
  end

  def create
    @order      = Order.new(order_params)
    @order.user = current_user
    @order.first_order! if current_user.no_orders_yet?
    @order.compute_total_price_ht!

    if @order.save
      ::GoogleDriveServices::Orders::AddOrderToSpreadsheetService.new(@order).call
      ::Mailers::Orders::SendConfirmationToUser.new(@order, current_user).call
      redirect_to order_success_path(@order)
    else
      @order.order_details.build if @order.order_details.empty?
      @shipping_address = ShippingAddress.new

      flash.now[:alert] = "Il y a eu un problème avec votre commande. Vérifiez les informations fournies."
      render 'new'
    end
  end

  def success
    @order = Order.find_by(id: params[:id])
  end

  private
  def order_params
    params.require(:order).permit(:shipping_address_id, :observations,
      :order_details_attributes => [:product_id, :quantity]
    )
  end

  def set_order_context
    @products           = Product.all
    @shipping_addresses = current_user.shipping_addresses
  end
end
