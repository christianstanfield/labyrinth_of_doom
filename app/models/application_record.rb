class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def first_error_message
    errors.full_messages.first
  end
end
