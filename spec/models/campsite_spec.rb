# frozen_string_literal: true

require "rails_helper"
# rubocop:disable Metrics/BlockLength
RSpec.describe Campsite, type: :model do
  let(:valid_campsite) do
    {campground: Campground.new, name: "Test Campsite", price: 39}
  end
  let(:invalid_campsite) do
    {campground: nil, name: "Test Campsite", price: 39}
  end
  let(:valid_booked_dates) do
    {check_in_date: Date.today, check_out_date: Date.today + 2.days}
  end

  describe "#campground" do
    it { is_expected.to validate_presence_of(:campground) }
  end

  describe "Create valid Campsite" do
    it "saves it in the database" do
      campsite = Campsite.create! valid_campsite
      expect(campsite).to be_valid
      expect(Campsite.count).to eq(1)
    end
  end

  describe "Cannot create invalid Campsite" do
    it "does not validate" do
      subject.name = invalid_campsite[:name]
      subject.price = invalid_campsite[:price]
      subject.campground = invalid_campsite[:campground]
      subject.validate
      expect(subject.errors[:campground]).to include("can't be blank")
    end
  end

  describe "Campsite not booked" do
    it "returns false" do
      campsite = Campsite.create! valid_campsite
      expect(campsite).to be_valid
      expect(campsite.booked?).to be(false)
    end
  end

  describe "Campsite booked" do
    it "returns true" do
      campsite = Campsite.create! valid_campsite
      BookedDate.create! valid_booked_dates.merge(campsite_id: campsite.id)
      expect(campsite).to be_valid
      expect(campsite.booked?).to be(true)
    end
  end
end
# rubocop:enable Metrics/BlockLength
