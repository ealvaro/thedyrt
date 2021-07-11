# frozen_string_literal: true

# This controller handles the 404 error
class ErrorsController < ApplicationController
  def error_404
    @requested_path = request.path
    render json: { routing_error: @requested_path }, status: 404
  end
end
