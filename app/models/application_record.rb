# frozen_string_literal: true

# Model class all models inherit from. Singleton
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
