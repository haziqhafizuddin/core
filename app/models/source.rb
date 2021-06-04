class Source < ApplicationRecord
  validates :name, :external_id, :condition, :category, presence: true

  # NOTE: condition will be represent as `datasetid`
  enum condition: %i[forecast warning observation]
  # NOTE: category wil be represent as `datacategoryid`
  enum category: %i[general marine windsea cyclone quaketsunami radar satellite windsea2 rain2 cyclone2 quaketsunami2
                    thunderstorm2 thunderstorm rains hourly rain]
end
