class DonationCheckoutController < ApplicationController
  include Premepay::V1
  skip_before_action :verify_authenticity_token #temp

  def show
    @donation = Donation.find(params[:id])
    @project = @donation.project
  end

  def create
    donation_params = params.require(:donation).permit(:id, order: [:description, :amount, customer: [:first_name, :surname, :cpf, 
    :birthdate, :email, :phone, address: [:street, :number, :zipcode, :reference, :district, :city, :state, :country]],
    payment: [card: [:holder_name, :expiration_month, :expiration_year, :card_number, :security_code]]])
    
    order = Order.new(donation_params[:order])

    if order.valid?
      begin
        credential = Credential.new
        credential.authenticate!
        order.create!(credential.token)
        render json: order, status: :created
      rescue PremeIntegrationError => ex
        render json: ex, status: 500
      end
    else
      render json: order.errors, status: :unprocessable_entity
    end

    @donation = Donation.find(donation_params[:id])
  end

end
