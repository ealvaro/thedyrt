# frozen_string_literal: true

require 'rails_helper'
# rubocop:disable Metrics/BlockLength
RSpec.describe BookedDate, type: :model do
  let(:valid_booked_dates) do
    { campsite: Campsite.new, check_in_date: Date.today, check_out_date: Date.today + 2.days }
  end
  let(:invalid_booked_dates) do
    { campsite: Campsite.new, check_in_date: Date.today, check_out_date: Date.today - 2.days }
  end
  let(:past_booked_dates) do
    { campsite: Campsite.new, check_in_date: Date.today - 5.days, check_out_date: Date.today - 2.days }
  end

  describe '#check_in_date' do
    it { is_expected.to validate_presence_of(:check_in_date) }
  end

  describe '#check_out_date' do
    it { is_expected.to validate_presence_of(:check_out_date) }
  end

  describe '#campsite' do
    it { is_expected.to validate_presence_of(:campsite) }
  end

  describe 'Create valid Booked Date' do
    it 'saves it in the database' do
      campsite = BookedDate.create! valid_booked_dates
      expect(campsite).to be_valid
      expect(BookedDate.count).to eq(1)
    end
  end

  describe 'Not create invalid Booked Date' do
    it 'does not save it in the database' do
      subject.check_in_date = invalid_booked_dates[:check_in_date]
      subject.check_out_date = invalid_booked_dates[:check_out_date]
      subject.validate
      expect(subject.errors[:check_out_date]).to include('must be after the check_in date')
    end
  end

  describe 'Booked Date not in the future' do
    it 'return false' do
      campsite = BookedDate.create! past_booked_dates
      expect(campsite).to be_valid
      expect(campsite.in_the_future).to be(false)
    end
  end
end
# rubocop:enable Metrics/BlockLength
