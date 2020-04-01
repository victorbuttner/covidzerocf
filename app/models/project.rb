class Project < ApplicationRecord
    mount_uploader :photo, PhotoUploader
    mount_uploader :banner, PhotoUploader

    has_many :donations

    def donation_total
        donations.paid.sum(:value)
    end

    def donation_percentage 
        (donation_total.to_f / goal.to_f * 100.0 ).round(1)  
    end
end
