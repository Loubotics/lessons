# == Schema Information
#
# Table name: locations
#
#  id         :integer          not null, primary key
#  teacher_id :integer
#  latitude   :float
#  longitude  :float
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Location < ActiveRecord::Base
  belongs_to :teacher

  geocoded_by :full_street_address

  after_validation :geocode
  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode  # auto-fetch address

  def full_street_address
    self.address
  end
end
