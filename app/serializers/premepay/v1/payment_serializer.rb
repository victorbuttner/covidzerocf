module Premepay
  module V1

    class PaymentSerializer < ActiveModel::Serializer
      attributes :type, :installments
      attribute :card_id, key: "cardId"


      def card_id
        return object.card.id
      end
    end
  end
end