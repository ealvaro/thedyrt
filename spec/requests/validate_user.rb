# frozen_string_literal: true

require 'rails_helper'
# This tests the Users controller endpoints
RSpec.describe 'UsersController', type: :request do
  let!(:t_college) { College.create(name: 'Test University') }
  let!(:t_exam) { Exam.create(title: 'Test Exam', college: t_college) }
  let!(:t_exam_window) { ExamWindow.create(start_time: Time.now, end_time: Time.now + 1.hour, exam: t_exam) }
  let!(:t_user) { User.create(first_name: 'John', last_name: 'Doe', phone_number: '954-555-1212', college: t_college) }
  let(:valid_input) do
    {
      "first_name": t_user.first_name,
      "last_name": t_user.last_name,
      "phone_number": t_user.phone_number,
      "college_id": t_college.id,
      "exam_id": t_exam.id,
      "start_time": t_exam_window.start_time + (1 * 60)
    }
  end
  let(:invalid_input) { valid_input.except!(:last_name) }
  let(:invalid_input2) { invalid_input.except!(:college_id) }

  describe 'a correct user validation with :id param' do
    it 'returns http success' do
      post "/users/#{t_user.id}/validate", valid_input
      # 'response' is a special object which contain HTTP response received after a request is sent
      # response.body is the body of the HTTP response, which here contain a JSON string
      expect(response.body).to eq('{"response":"Valid User"}')

      # we can also check the http status of the response
      expect(response.status).to eq(200)
    end
  end

  describe 'a correct user validation without :id param' do
    it 'returns http success' do
      post '/users/validate', valid_input
      expect(response.body).to eq('{"response":"Valid User"}')
      expect(response.status).to eq(200)
    end
  end

  describe 'user validation with :id param failed due to missing last name' do
    it 'returns http 400' do
      post "/users/#{t_user.id}/validate", invalid_input
      expect(response.body).to eq('{"validation_error":["Missing/Invalid Last Name"]}')
      expect(response.status).to eq(400)
    end
  end

  describe 'user validation without :id param failed due to missing last name' do
    it 'returns http 400' do
      post '/users/validate', invalid_input
      expect(response.body).to eq('{"validation_error":["Missing/Invalid User"]}')
      expect(response.status).to eq(400)
    end
  end

  describe 'user validation failed due to additional stuff missing' do
    it 'returns http 400' do
      post "/users/#{t_user.id}/validate", invalid_input2
      expect(response.body).to eq('{"validation_error":["Missing/Invalid Last Name","Missing/Invalid College ID"]}')
      expect(response.status).to eq(400)
    end
  end
end
