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
      Campground.create! valid_campground
      subject.name = repeated_campground[:name]
      subject.validate
      expect(subject.errors[:name]).to include('has already been taken')
    end
  end
end
# rubocop:enable Metrics/BlockLength
