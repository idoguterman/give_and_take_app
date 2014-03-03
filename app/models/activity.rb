class Activity < ActiveRecord::Base
  belongs_to :user
	has_one :location
  attr_accessible :content, :name
end
