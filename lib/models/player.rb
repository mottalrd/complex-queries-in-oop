class Player < ActiveRecord::Base
  scope :right_foot, -> { where(preferred_foot: 'right') }
  scope :left_foot, -> { where(preferred_foot: 'left') }
end
