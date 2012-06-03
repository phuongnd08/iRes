class Category < ActiveRecord::Base
  has_many :items

  scope :enabled, where(:enabled => true)

  validates :name, :presence => true, :uniqueness => true
end
