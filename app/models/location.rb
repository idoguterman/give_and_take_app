class Location < ActiveRecord::Base
  belongs_to :activity
	belongs_to :user
  attr_accessible :country, :state, :address, :latitude, :longitude
  
  geocoded_by :address
  after_validation :geocode, :if => :address_changed? or :state_changed? or :country_changed?
end
