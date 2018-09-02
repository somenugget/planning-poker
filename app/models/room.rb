class Room < ApplicationRecord
  def to_param
    slug
  end
end
