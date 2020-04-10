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
    @donation.update(donation_params[:order][:customer].except(:address))
    address_info = donation_params[:order][:customer][:address]
    @donation.update(address_street: address_info[:street],address_number: address_info[:number], address_zipcode: address_info[:zipcode], address_reference: address_info[:reference], address_district: address_info[:district] , address_city: address_info[:city], address_state: address_info[:state], address_country: 'BRL'  )
  end

end
