class Venue
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :coordinates, type: Array

  attr_accessor :latitude, :longitude
  index({ coordinates: '2dsphere' })

  after_validation :set_coordinates

  private
    def set_coordinates
      self.coordinates = [longitude.to_f, latitude.to_f]
    end
end
