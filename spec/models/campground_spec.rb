# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
require 'rails_helper'

RSpec.describe Campground, type: :model do
  let(:valid_campground) do
    { name: 'Test Campground' }
  end
  let(:repeated_campground) do
    { name: 'Test Campground' }
  end
  let(:valid_campsite1) do
    { name: 'Test Campsite I', price: 39 }
  end
  let(:valid_campsite2) do
    { name: 'Test Campsite II', price: 59 }
  end
  let(:valid_booked_dates) do
    { check_in_date: Date.today, check_out_date: Date.today + 2.days }
  end
  let(:past_booked_dates) do
    { check_in_date: Date.today - 5.days, check_out_date: Date.today - 2.days }
  end

  describe '#name' do
    it { is_expected.to validate_uniqueness_of(:name) }
  end

  describe 'Create valid Campground' do
    it 'saves it in the database' do
      campground = Campground.create! valid_campground
      expect(campground).to be_valid
      expect(Campground.count).to eq(1)
    end
  end

  describe 'Not create invalid Campground' do
    it 'does not save it in the database' do
      Campground.create! valid_campground
      subject.name = repeated_campground[:name]
      subject.validate
      expect(subject.errors[:name]).to include('has already been taken')
    end
  end

  describe 'Campground Price Range' do
    it 'is correctly calculated' do
      cg = Campground.create! valid_campground
      cs1 = Campsite.create! valid_campsite1.merge({ campground_id: cg.id })
      expect(cs1).to be_valid
      expect(cg.price_range).to eq(39..39)
      cs2 = Campsite.create! valid_campsite2.merge({ campground_id: cg.id })
      expect(cs2).to be_valid
      cg.reload
      expect(cg.price_range).to eq(39..59)
    end
  end

  describe 'Booked Campground Available' do
    it 'is false' do
      cg = Campground.create! valid_campground
      cs1 = Campsite.create! valid_campsite1.merge({ campground_id: cg.id })
      BookedDate.create! valid_booked_dates.merge({ campsite_id: cs1.id })
      expect(cg.available(valid_booked_dates[:check_in_date],
                          valid_booked_dates[:check_out_date])).to eq(false)
    end
  end

  describe 'Empty Campground Available' do
    it 'has campsites not booked' do
      cg = Campground.create! valid_campground
      cs1 = Campsite.create! valid_campsite1.merge({ campground_id: cg.id })
      BookedDate.create! past_booked_dates.merge({ campsite_id: cs1.id })
      cs2 = Campsite.create! valid_campsite2.merge({ campground_id: cg.id })
      BookedDate.create! valid_booked_dates.merge({ campsite_id: cs2.id })
      expect(cg.available(valid_booked_dates[:check_in_date],
                          valid_booked_dates[:check_out_date])).to eq(true)
      expect(cg.campsites_not_booked?).to eq(true)
    end
  end
end
# rubocop:enable Metrics/BlockLength
