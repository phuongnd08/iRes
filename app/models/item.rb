class Item < ActiveRecord::Base
  belongs_to :category
  scope :enabled, where(:enabled => true)
  validates :name, :presence => true, :uniqueness => true
  validates :price, :presence => true, :numericality => true
end
