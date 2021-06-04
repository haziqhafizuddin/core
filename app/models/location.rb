class Location < ApplicationRecord
  validates :name, :external_id, :category, presence: true

  # NOTE: category wil be represent as `locationcategoryid`
  enum category: %i[state district town touristdest waters]
end
