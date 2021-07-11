# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BookedDatesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/booked_dates').to route_to('booked_dates#index')
    end

    it 'routes to #show' do
      expect(get: '/booked_dates/1').to route_to('booked_dates#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/booked_dates').to route_to('booked_dates#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/booked_dates/1').to route_to('booked_dates#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/booked_dates/1').to route_to('booked_dates#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/booked_dates/1').to route_to('booked_dates#destroy', id: '1')
    end
  end
end
