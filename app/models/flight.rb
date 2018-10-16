class Flight < ApplicationRecord
  def self.filter(filter)
    where({direction_type: filter}).order("exact_time asc")
  end
end
