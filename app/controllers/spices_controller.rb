class SpicesController < ApplicationController
  # rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def index
    spice = Spice.all
    render json: spice
  end

  # def show
  #   spice = find_spice
  #   render json: spice
  # end

  def create
    spice = Spice.create(spice_params)
    render json: spice, status: :created
  end

  def update
    spice = Spice.find_by(params[:id])
    if spice
      spice.update(spice_params)
      render json: spice, status: :created
    else
      render_not_found_response
    end
  end

  def destroy
    spice = Spice.find_by(params[:id])
    if spice
        spice.destroy
        head :no_content
      else
        render_not_found_response
      end
  end

  private

  def find_spice
    Spice.find(params:[:id])
  end

  def spice_params
    params.permit(:title, :image, :description, :notes, :rating)
  end

  def render_not_found_response
    render json: { error: "spice not found" }, status: :not_found
  end
end
