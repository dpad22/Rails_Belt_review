require 'date'

class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true

    def future_dated
        if date.present? && date< Date.today
            errors.add(:date, "date cannot be in the past!")
        end
    end
end