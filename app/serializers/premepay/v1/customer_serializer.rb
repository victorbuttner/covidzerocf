module Premepay
  module V1
    class CustomerSerializer < ActiveModel::Serializer
      attribute :first_name, key: 'firstName'
      attributes :surname, :cpf, :birthdate, :email, :phone, :address


      def address
        return AddressSerializer.new(object.address)
      end
    end
  end
end
