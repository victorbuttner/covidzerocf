module Premepay

    module V1
        
      class PremeIntegrationError < StandardError; end
      
      class Order
        include HTTParty
        include ActiveModel::Validations
        include ActiveModel::Model
        include ActiveModel::Serialization

        base_uri "#{ENV["PREMEPAY_BASEURI"]}/stores/#{ENV["PREMEPAY_STORE_ID"]}"

        attr_accessor :description, :amount, :customer, :payment, :id

        validates :description, presence: true, length: {maximum: 70}
        validates :amount, numericality: {greater_than: 2.5, less_than: 10**6}
        validate :validate_customer
        validate :validate_payment

        def customer=(value)
          @customer = Customer.new(value)
        end

        def payment=(value)
          @payment = Payment.new(value)
        end

        def create!(token)
          return false if !valid?

          @customer.create!(token)
          @payment.card.create!(token: token, customer_id: @customer.id)
          response = self.class.post("/customers/#{@customer.id}/orders", { verify: false,
            body: OrderSerializer.new(self).to_json,
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer #{token}"
            }
          })
          puts "Order Serializer #{OrderSerializer.new(self).to_json}"
          puts "Order Response #{response}"

          if response.created?
            @id = response["id"]
          else
            raise PremeIntegrationError.new("error occurred when saving order: #{response.to_s}")
          end
        end

        private
        def validate_customer
          if not @customer.instance_of?(Customer)
            errors.add(:customer, 'is invalid')
          elsif(!@customer.valid?)
            errors.add(:customer, @customer.errors)
          end
        end

        def validate_payment
          if not @payment.instance_of?(Payment)
            errors.add(:payment, 'is invalid')
          elsif(!@payment.valid?)
            errors.add(:payment, @payment.errors)
          end
        end

      end

      class Payment
        include ActiveModel::Validations
        include ActiveModel::Model
        include ActiveModel::Serialization

        attr_accessor :card
        attr_reader :type, :installments

        validate :validate_card

        def initialize(attributes = {})
          super
          @type = 0
          @installments = 1
        end

        def card=(value)
          @card = Card.new(value)
        end

        private
        def validate_card
          if not @card.instance_of?(Card)
            errors.add(:card, 'is invalid')
          elsif(!@card.valid?)
            errors.add(:card, @card.errors)
          end
        end
        
      end

      class Customer
        include HTTParty
        include ActiveModel::Validations
        include ActiveModel::Model
        include ActiveModel::Serialization

        base_uri "#{ENV["PREMEPAY_BASEURI"]}/stores/#{ENV["PREMEPAY_STORE_ID"]}/customers"

        attr_accessor :first_name, :surname, :cpf, :birthdate,
        :email, :phone, :address, :id
        
        validates :first_name, presence: true, length: {maximum: 45}
        validates :surname, presence: true, length: {maximum: 45}
        validates :cpf, format: {with: /\A\d{11}\z/}
        validates_date :birthdate
        validates :email, format: {with: /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,3}\z/}
        validates :phone, format: {with: /\A(\(?\d{2}\)?\s)?(\d{4,5}\-\d{4})\z/}
        validate :validate_address

        def address=(value)
          @address = Address.new(value)
        end

        def already_exists?(token)
          response = self.class.get("?cpf=#{@cpf}", {verify: false,
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer #{token}"
            }
          })
          if response.length > 0
            @id = response[0]["id"]
            Card.remove!(token: token, customer_id: @id, card_id: response[0]["card"]["id"])
            return true
          else
            return false
          end
        end

        def create!(token)
          return false if !valid?

          if already_exists?(token)
            return;
          end

          response = self.class.post("/", {verify: false,
            body: CustomerSerializer.new(self).to_json,
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer #{token}"
            }
          })
          if response.created?
            @id = response["id"]
          else
            raise PremeIntegrationError.new("error occurred when saving customer: #{response.to_s}")
          end
        end

        private
        def validate_address
          if not @address.instance_of?(Address)
            errors.add(:address, 'is invalid');
          elsif(!@address.valid?)
            errors.add(:address, @address.errors)
          end
        end
      end


      class Address
        COUNTRIES = {
          "BRL": 0       
        }

        STATES = {
          "AC": 0,
          "AL": 1,
          "AP": 2,
          "AM": 3,
          "BA": 4,
          "CE": 5,
          "DF": 6,
          "ES": 7,
          "GO": 8,
          "MA": 9,
          "MT": 10,
          "MS": 11,
          "MG": 12,
          "PA": 13,
          "PB": 14,
          "PR": 15,
          "PE": 16,
          "PI": 17,
          "RJ": 18,
          "RN": 19,
          "RS": 20,
          "RO": 21,
          "RR": 22,
          "SC": 23,
          "SP": 24,
          "SE": 25,
          "TO": 26
        }

        include ActiveModel::Validations
        include ActiveModel::Model
        include ActiveModel::Serialization
        attr_accessor :street, :number, :zipcode, :reference, 
        :district, :city, :state, :country

        validates :street, presence: true, length: {maximum: 70}
        validates :number, format: {with: /\A\d*\z/}
        validates :zipcode, format: {with: /\A\d*\z/}
        validates :reference, length: {maximum: 45}
        validates :district, presence: true, length: {maximum: 70}
        validates :city, presence: true, length: {maximum: 70}
        validates :state, inclusion: {in: STATES.stringify_keys.keys}
        validates :country, inclusion: {in: COUNTRIES.stringify_keys.keys}

      end

    
      class Card
        include HTTParty
        include ActiveModel::Validations
        include ActiveModel::Model
        include ActiveModel::Serialization
        base_uri "#{ENV["PREMEPAY_BASEURI"]}/stores/#{ENV["PREMEPAY_STORE_ID"]}"

        attr_accessor :holder_name, :expiration_month, :expiration_year, :card_number,
        :security_code, :id


        validates :holder_name, presence: true, length: {maximum: 45}
        validates :expiration_month, inclusion: {in: 1..31}
        validates :expiration_year, inclusion: {in: proc {Date.today.year..5.years.from_now.year}}
        validates :card_number, presence: true, format: {with: /\A\d{16}\z/}
        validates :security_code, presence: true, format: {with: /\A\d{3}\z/}

        def self.remove!(token:, customer_id:, card_id:)
          response = HTTParty.delete("#{ENV["PREMEPAY_BASEURI"]}/stores/#{ENV["PREMEPAY_STORE_ID"]}/customers/#{customer_id}/cards/#{card_id}", {
            verify: false, headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer #{token}"
            }
          })
          if !response.ok?
            if response.not_found?
              return
            else
              raise PremeIntegrationError.new("error occurred when saving card: #{response.to_s}")
            end
          end
        end

        def create!(token:, customer_id:)

          return false if !valid?

          response = self.class.post("/customers/#{customer_id}/cards", { verify: false,
            body: CardSerializer.new(self).to_json,
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer #{token}"
            }
          })
          if response.created?
            @id = response["id"]
          else
            raise PremeIntegrationError.new("error occurred when saving card: #{response.to_s}")
          end
        end
      end


      class Credential
        include HTTParty
        base_uri "#{ENV["PREMEPAY_BASEURI"]}/authentication"
        attr_accessor :token, :expiry_at

        def initialize
            @username = ENV["PREMEPAY_USERNAME"]
            @password = ENV["PREMEPAY_PASSWORD"]
            @token = nil,
            @expiry_at = nil
        end

        def authenticate!
            response = self.class.post("/", { verify: false,
              body: {
                  username: @username,
                  password: @password
              }.to_json,
              headers: {
                  "Content-Type": "application/json"
              }
            })
            if not response.ok?
                raise PremeIntegrationError.new("authentication error: #{response.to_s}")
            end
            @token = response["token"]
            @expiry_at = response["expiryAt"]
        end

      end

    end
end