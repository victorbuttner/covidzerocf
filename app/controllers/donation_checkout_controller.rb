class DonationCheckoutController < ApplicationController

  def show
    @donation = Donation.find(params[:id])
    @project = @donation.project
  end

  def create
    
  end

end
