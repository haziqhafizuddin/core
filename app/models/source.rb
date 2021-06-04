class Source < ApplicationRecord
  validates :name, :external_id, :type, :category, presence: true

  # NOTE: type will be represent as `datasetid`
  enum type: %i[forecast warning observation]
  # NOTE: category wil be represent as `datacategoryid`
  enum category: %i[general marine windsea cyclone quaketsunami radar satellite windsea2 rain2 cyclone2 quaketsunami2
                    thunderstorm2 thunderstorm rain hourly]
end
