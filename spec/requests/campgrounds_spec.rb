# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
require "rails_helper"

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/campgrounds", type: :request do
  # This should return the minimal set of attributes required to create a valid
  # Campground. As you add validations to Campground, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do
    {name: "Test Campground"}
  end

  let(:invalid_attributes) do
    {first_name: "Invalid Campground", invalid_input: 2_345_356}
  end

  # This should return the minimal set of values that should be in the headers
  # in order to pass any filters (e.g. authentication) defined in
  # CampgroundsController, or in your router and rack
  # middleware. Be sure to keep this updated too.
  let(:valid_headers) do
    {}
  end

  describe "GET /index" do
    it "renders a successful response" do
      Campground.create! valid_attributes
      get campgrounds_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      campground = Campground.create! valid_attributes
      get campground_url(campground), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Campground" do
        expect do
          post campgrounds_url,
               params: {campground: valid_attributes}, headers: valid_headers, as: :json
        end.to change(Campground, :count).by(1)
      end

      it "renders a JSON response with the new campground" do
        post campgrounds_url,
             params: {campground: valid_attributes}, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Campground" do
        expect do
          post campgrounds_url,
               params: {campground: invalid_attributes}, as: :json
        end.to change(Campground, :count).by(0)
      end

      it "renders a JSON response with errors for the new campground" do
        post campgrounds_url,
             params: {campground: invalid_attributes}, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) do
        {name: "Updated Test Campground"}
      end

      it "updates the requested campground" do
        campground = Campground.create! valid_attributes
        patch campground_url(campground),
              params: {campground: new_attributes}, headers: valid_headers, as: :json
        campground.reload
        expect(campground.name).to eq(new_attributes[:name])
      end

      it "renders a JSON response with the campground" do
        campground = Campground.create! valid_attributes
        patch campground_url(campground),
              params: {campground: new_attributes}, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the campground" do
        campground = Campground.create! valid_attributes
        patch campground_url(campground),
              params: {campground: invalid_attributes}, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested campground" do
      campground = Campground.create! valid_attributes
      expect do
        delete campground_url(campground), headers: valid_headers, as: :json
      end.to change(Campground, :count).by(-1)
    end
  end
end
# rubocop:enable Metrics/BlockLength
