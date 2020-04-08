module Premepay
  module V1

    class CardSerializer < ActiveModel::Serializer
      attribute :holder_name, key: "holderName"
      attribute :expiration_month, key: "expirationMonth"
      attribute :expiration_year, key: "expirationYear"
      attribute :card_number, key: "cardNumber"
      attribute :security_code, key: "securityCode"
    end
  end
end