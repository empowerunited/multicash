module Multicash
  class Ammount
    extend  ActiveModel::Naming
    include ActiveModel::Validations

    CURRENCIES = %w{AUD BGN CAD CHF DKK EUR GBP JPY NOK RUR SEK TRL USD}
    CURRENCY_FORMAT = /\A\d{1,11}.\d{1,2}\z/

    attr_accessor :value, :currency
    attr_reader :errors

    validates :value, format: { with: CURRENCY_FORMAT }
    validates :currency, presence: true, inclusion: {in: CURRENCIES}

    def initialize value: 0.00, currency: 'BGN'
      @value = value
      @currency = currency
      @errors = ActiveModel::Errors.new(self)
    end
  end
end