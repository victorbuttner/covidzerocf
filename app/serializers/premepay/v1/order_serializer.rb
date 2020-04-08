module Premepay
  module V1

    class OrderSerializer < ActiveModel::Serializer
      attributes :description, :amount, :payment


      def payment
          return PaymentSerializer.new(object.payment)
      end
    end
  end
end