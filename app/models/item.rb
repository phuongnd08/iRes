class Item < ActiveRecord::Base
  belongs_to :category
  scope :enabled, where(:enabled => true)
end
