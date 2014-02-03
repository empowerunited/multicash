module Multicash
  class Account
    extend  ActiveModel::Naming
    include ActiveModel::Validations
    include Multicash::Utils

    attr_accessor :name, :city, :address, :iban, :bank_name
    attr_reader :bae, :errors

    validates :name, presence: true, allow_blank: false
    validates :city, presence: true, allow_blank: false
    validates :address, presence: true, allow_blank: false
    validates :iban, presence: true, format: /[A-Z0-9]{2}\d{2}[A-Z0-9]{4}\d{4}[A-Z0-9]{10}/

    def initialize attributes = {}
      @name = attributes[:name]
      @city = attributes[:city] || "CITY"
      @address = attributes[:address] || "ADDRESS"
      @bank_name = attributes[:bank_name] || "BANK NAME"
      @iban = attributes[:iban]
      @errors = ActiveModel::Errors.new(self)
    end

    def bae
      calc_bae(iban)
    end
  end
end