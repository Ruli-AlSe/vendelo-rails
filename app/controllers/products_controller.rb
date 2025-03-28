class ProductsController < ApplicationController
  skip_before_action :protect_pages, only: [ :index, :show ]

  def index
    @categories = Category.order(name: :asc).load_async

    @pagy, @products = pagy_countless(FindProducts.new.call(product_params_index).load_async, items: 12)
  end

  def show
    product
  end

  def new
    @product = Product.new
  end

  def create
    # This one way to assing products to the current logged user
    # @product = Current.user.products.new(product_params)
    # See other way in product.rb
    @product = Product.new(product_params)

    if @product.save
      redirect_to products_path, notice: t(".created")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize! product
  end

  def update
    authorize! product

    if product.update(product_params)
      product.broadcast
      redirect_to products_path, notice: t(".updated")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize! product

    product.destroy
    redirect_to products_path, notice: t(".destroyed"), status: :see_other
  end

  private

  def product
    @product ||= Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:title, :description, :price, :photo, :category_id)
  end

  def product_params_index
    params.permit(:category_id, :min_price, :max_price, :order_by, :page, :favorites, :user_id)
  end

  # def notify_all_users
  #   ActionCable.server.broadcast(
  #     "product_#{product.id}",
  #     {
  #       action: "updated"
  #     }
  #   )
  # end
end
