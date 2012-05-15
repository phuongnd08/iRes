class Category < ActiveRecord::Base
  has_many :items

  scope :enabled, where(:enabled => true)
end
