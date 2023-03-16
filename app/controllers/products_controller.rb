class ProductsController < ApplicationController
    before_action :set_product, only: [:show, :update, :destroy]

    # GET /products
    def index
        @products = Product.all
        render json: @products
    end

    # GET /products/:id
    def show
        if @product
          render json: @product
        else
          render json: { error: "Product not found" }, status: :not_found
        end
    end

    # POST /products
    def create
        @product = Product.new(product_params)
    
        if @product.save
          render json: @product, status: :created
        else
          render json: { error: @product.errors.full_messages.join(", ") }, status: :unprocessable_entity
        end
    end

    # PATCH/PUT /products/:id
    def update
        if @product.update(product_params)
          render json: @product
        else
          render json: { error: @product.errors.full_messages.join(", ") }, status: :unprocessable_entity
        end
    end

    # DELETE /products/:id
    def destroy
        if @product.destroy
          head :no_content
        else
          render json: { error: "Product deletion failed" }, status: :unprocessable_entity
        end
    end

    # GET /products/:length/:width/:height/:weight
    def find_by_dimensions
      
      # Get the maximum dimensions of the package
      package_length = params[:length].to_i + 1
      package_width = [params[:width].to_i, params[:height].to_i].max + 1
      package_height = [params[:width].to_i, params[:height].to_i].min + params[:height].to_i + 1
      package_weight = params[:weight].to_i + 1
      
      # Search for a package that can fit the product
      product = Product.where(:length.gte => package_length, :width.gte => package_width, :height.gte => package_height, :weight.gte => package_weight).first

      if product.nil?
        # No package found
        return { message: "No package found for dimensions #{length}x#{width}x#{height} and weight #{weight} lbs." }
      else
        # Package found
        return product.to_json
      end
      
    end
    

    private

    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :type, :length, :width, :height, :weight)
    end
  
end
