# frozen_string_literal: true

# Controller for the Booked Dates of a Campsite
class BookedDatesController < ApplicationController
  before_action :set_booked_date, only: %i[show update destroy]

  # GET /booked_dates
  # GET /booked_dates.json
  def index
    @booked_dates = BookedDate.all
  end

  # GET /booked_dates/1
  # GET /booked_dates/1.json
  def show; end

  # POST /booked_dates
  # POST /booked_dates.json
  def create
    @booked_date = BookedDate.new(booked_date_params)

    if @booked_date.save
      render :show, status: :created, location: @booked_date
    else
      render json: @booked_date.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /booked_dates/1
  # PATCH/PUT /booked_dates/1.json
  def update
    if @booked_date.update(booked_date_params)
      render :show, status: :ok, location: @booked_date
    else
      render json: @booked_date.errors, status: :unprocessable_entity
    end
  end

  # DELETE /booked_dates/1
  # DELETE /booked_dates/1.json
  def destroy
    @booked_date.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_booked_date
    @booked_date = BookedDate.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def booked_date_params
    params.require(:booked_date).permit(:check_in_date, :check_out_date, :campsite_id)
  end
end
