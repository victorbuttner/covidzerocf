module Premepay
  module V1

    class AddressSerializer < ActiveModel::Serializer
      attributes :street, :number, :zipcode, :district, :reference, :city, :state, :country


      def state
        return Address::STATES[object.state.to_sym]
      end

      def country
        return Address::COUNTRIES[object.country.to_sym]
      end
    end
  end
end