class Project < ApplicationRecord
    mount_uploader :photo, PhotoUploader
    has_many :donations

    def donation_total
        donations.paid.sum(:value)
    end
end
