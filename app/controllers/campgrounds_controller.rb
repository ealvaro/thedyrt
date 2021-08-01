# frozen_string_literal: true

# Controller for the Campgrounds
class CampgroundsController < ApplicationController
  before_action :set_campground, only: %i[show update destroy]

  # GET /campgrounds/by_price
  # GET /campgrounds/by_price.json
  def by_price
    campgrounds_by_price_params
    order = params["order"] || "low_to_high"
    price_range
    @campgrounds = @campgrounds.sort {|a, b| a[:lowest] <=> b[:lowest] }
    if order == "low_to_high"
      @campgrounds
    else
      @campgrounds.reverse!
    end
  end

  # GET /campgrounds/available
  # GET /campgrounds/available.json
  def available
    campgrounds_available_params
    start_date = params["start_date"].to_date
    end_date = params["end_date"].to_date

    unless valid_checkin_dates(start_date, end_date)
      render json: {status: :unprocessable_entity,
                    message: "Start Date must be less then End Date and in the future"} and return
    end

    @campgrounds = []
    Campground.all.includes(:campsites).each do |cg|
      @campgrounds << cg if cg.available(start_date, end_date)
    end
  end

  # GET /campgrounds/future_booked_dates
  # GET /campgrounds/future_booked_dates.json
  def future_booked_dates
    @campgrounds = []
    Campground.all.includes(:campsites).each do |cg|
      @campgrounds << {campground: cg.name, campsites: cg.future_booked_dates}
    end
    render :campgrounds
  end

  # GET /campgrounds/price_range
  # GET /campgrounds/price_range.json
  def price_range
    @campgrounds = []
    Campground.all.includes(:campsites).each do |cg|
      lowest, highest = cg.price_range
      @campgrounds << {campground: cg.name, lowest: lowest, highest: highest}
    end
    render :campgrounds
  end

  # GET /campgrounds
  # GET /campgrounds.json
  def index
    @campgrounds = Campground.all.includes(:campsites)
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
    if !campground_params["name"].nil? && @campground.update(campground_params)
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

  def campgrounds_by_price_params
    params.require(:order)
  end

  def campgrounds_available_params
    params.require(:start_date)
    params.require(:end_date)
  end

  # Valid date range and in the future
  def valid_checkin_dates(start_date, end_date)
    return true if start_date < end_date && start_date >= Date.today

    false
  end
end
