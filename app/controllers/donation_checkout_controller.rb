class DonationCheckoutController < ApplicationController
  before_action :authenticate_user!

  def show
    @donation = Donation.find(params[:id])
    @project = @donation.project
  end

end
