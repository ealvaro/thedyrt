# frozen_string_literal: true

class CampgroundsController < ApplicationController
  before_action :set_campground, only: %i[show update destroy]

  # GET /campgrounds
  # GET /campgrounds.json
  def index
    @campgrounds = Campground.all
  end

  # GET /campgrounds/1
  # GET /campgrounds/1.json
  def show; end

  # POST /campgrounds
  # POST /campgrounds.json
  def create
    @campground = Campground.new(campground_params)

    if @campground.save
      render :show, status: :created, location: @campground
    else
      render json: @campground.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /campgrounds/1
  # PATCH/PUT /campgrounds/1.json
  def update
    if @campground.update(campground_params)
      render :show, status: :ok, location: @campground
    else
      render json: @campground.errors, status: :unprocessable_entity
    end
  end

  # DELETE /campgrounds/1
  # DELETE /campgrounds/1.json
  def destroy
    @campground.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_campground
    @campground = Campground.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def campground_params
    params.require(:campground).permit(:name)
  end
end
