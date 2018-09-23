class Vote < ApplicationRecord
  ESTIMATIONS_AVAILABLE = [0.5, 1, 3, 5, 8].freeze

  belongs_to :room_user
end
