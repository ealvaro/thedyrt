# frozen_string_literal: true

# Controller for the Campsites
class CampsitesController < ApplicationController
  before_action :set_campsite, only: %i[show update destroy]

  # GET /campsites
  # GET /campsites.json
  def index
    @campsites = Campsite.all.includes(:booked_dates)
  end

  # GET /campsites/1
  # GET /campsites/1.json
  def show; end

  # POST /campsites
  # POST /campsites.json
  def create
    @campsite = Campsite.new(campsite_params)

    if @campsite.save
      render :show, status: :created, location: @campsite
    else
      render json: @campsite.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /campsites/1
  # PATCH/PUT /campsites/1.json
  def update
    if @campsite.update(campsite_params)
      render :show, status: :ok, location: @campsite
    else
      render json: @campsite.errors, status: :unprocessable_entity
    end
  end

  # DELETE /campsites/1
  # DELETE /campsites/1.json
  def destroy
    @campsite.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_campsite
    @campsite = Campsite.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def campsite_params
    params.require(:campsite).permit(:name, :price, :campground_id)
  end
end
