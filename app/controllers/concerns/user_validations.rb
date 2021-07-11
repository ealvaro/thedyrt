# frozen_string_literal: true

# Module that takes care of the User Validations
module UserValidations
  include ActiveSupport::Concern

  INVALID = 'Missing/Invalid'
  # rubocop:disable Metrics/AbcSize
  def validations
    @errors = []
    @errors << "#{INVALID} User" and return false if @user.nil?

    fn_same?(params[:first_name])         &
      ln_same?(params[:last_name])        &
      college_same?(params[:college_id])  &
      exam_same?(params[:exam_id])        &
      time_same?(params[:exam_id], params[:start_time])
  end
  # rubocop:enable Metrics/AbcSize

  def fn_same?(first)
    @errors << "#{INVALID} First Name" if first.nil? || @user.first_name != first # This one is mandatory
    @errors.empty?
  end

  def ln_same?(last)
    @errors << "#{INVALID} Last Name" if last.nil? || @user.last_name != last   # This one is mandatory
    @errors.empty?
  end

  def college_same?(id)
    @errors << "#{INVALID} College ID" if id.nil? || @user.college.id != id.to_i
    @errors.empty?
  end

  def exam_same?(id)
    @errors << "#{INVALID} Exam ID" if id.nil? || !@user.college.has_exam?(id.to_i)
    @errors.empty?
  end

  def time_same?(exam_id, start)
    return if exam_id.nil?

    @errors << "#{INVALID} Start Time" if start.nil? || !found_time_slot(exam_id, start)
    @errors.empty?
  end

  def found_time_slot(exam_id, start)
    found = false
    Exam.find(exam_id).exam_windows.each do |ew|
      found ||= ew.within_time_slot(start)
    end
    found
  end
end
