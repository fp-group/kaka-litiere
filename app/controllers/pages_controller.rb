class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :legal, :static_components]

  def home
    @box          = Product.find_by(sku: "litter-box")
    @display_box  = Product.find_by(sku: "display-box")
  end

  def shop
    @products = Product.all
  end

  def legal
  end
end
