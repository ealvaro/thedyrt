# frozen_string_literal: true

# Controller for the Campgrounds
class CampgroundsController < ApplicationController
  before_action :set_campground, only: %i[show update destroy]

  # GET /campgrounds/available
  # GET /campgrounds/available.json
  def available
    campgrounds_available_params
    start_date = params['start_date'].to_date
    end_date = params['end_date'].to_date
    @campgrounds = []

    unless valid_checkin_dates(start_date, end_date)
      raise ArgumentError, 'Start Date must be less then End Date and in the future'
    end

    Campground.all.each do |cg|
      @campgrounds << cg if cg.available(start_date, end_date)
    end
  end

  # GET /campgrounds/future_booked_dates
  # GET /campgrounds/future_booked_dates.json
  def future_booked_dates
    @campgrounds = []
    Campground.all.each do |cg|
      @campgrounds << { campground: cg.name, campsites: cg.future_booked_dates }
    end
  end

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
    if !campground_params['name'].nil? && @campground.update(campground_params)
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

  def campgrounds_available_params
    params.require(:start_date)
    params.require(:end_date)
  end

  # Valid date range and in the future
  def valid_checkin_dates(start_date, end_date)
    return true if start_date < end_date && start_date >= Date.today
  end
end
