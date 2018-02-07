module Admin
  class ProductsController < ApplicationController
    before_action :set_product, only: [:edit, :update]
    before_action :verify_admin!

    def index
      @products = Product.all.order(:sku)
    end

    def edit
    end

    def update
      if @product.update(product_params)
        redirect_to admin_products_path, notice: 'Le produit a été mis à jour.'
      else
        render :edit
      end
    end

    private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:designation, :unit_price, :features)
    end

    def verify_admin!
      unless current_user.admin
        redirect_to root_path, alert: "Vous n'êtes pas autorisé(e) à accéder à cette page."
      end
    end
  end
end
