class Place < ApplicationRecord

    # geocoded_by :address, :longitude => :title
    geocoded_by :address do |obj, results|
        if geo = results.first
            # puts '-------------------------------'
            # puts obj.inspect
            # puts '********'
            # puts results.inspect
            # puts [results[0].latitude, results[0].longitude].inspect
            obj.latitude = geo.latitude
            obj.longitude = geo.longitude
        end
    end
    after_validation :geocode, if: ->(obj){ obj.address.present? and obj.address_changed? }

    def Place::create_place!(place_hash)
        return new(place_hash)
    end


end
