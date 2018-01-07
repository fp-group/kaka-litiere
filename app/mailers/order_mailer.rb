class OrderMailer < ApplicationMailer
  def confirmation(order, user)
    @order  = order
    @user   = user

    # @order_details = {
    #   bag_quantity: @order.order_details.find_by(product_id: 1).quantity,
    #   box_quantity: @order.order_details.find_by(product_id: 2).quantity
    # }
    mail(from: 'contact@kaka-litiere.com', to: @user.email, subject: 'Order confirmation')
  end
end
