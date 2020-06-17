module Premepay
  module V1

    class OrderSerializer < ActiveModel::Serializer
      attributes :description, :amount, :payment
      attribute :splits

      def payment
          return PaymentSerializer.new(object.payment)
      end

      def splits
        [ {   splitRuleId: 514    } ]
      end

      def is_production?
        ENV['RAILS_ENV'] == 'production'
      end

    end
  end
end