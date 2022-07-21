class SpicesController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
#Get 
    def index
        spices = Spice.all
        render json: spices, except: [:created_at,:updated_at]
    end

    # def show
    #     spice = find_spice_by_id
    #     render json: spice, except: [:created_at,:updated_at]
    # end

    def create
        spice = Spice.create(permit_spice_params)
        render json: spice, status: :created
    end

    def update
        spice = find_spice_by_id
        spice.update(permit_spice_params)
        render json: spice, status: :created
        
    end

    def destroy
        spice = find_spice_by_id
        spice.destroy
        head :no_content
    end




    private

    def permit_spice_params
        params.permit(:title,:image,:description,:notes,:rating)
    end 

    def find_spice_by_id
        Spice.find(params[:id])
    end

    def render_not_found
        render json: {error: "Spice not found"}, status: :not_found
    end
end
