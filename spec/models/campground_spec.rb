# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Campground, type: :model do
  let(:valid_campground) do
    { name: 'Test Campground' }
  end
  let(:invalid_campground) do
    { invalid_name: 'Invalid Campground' }
  end
end
