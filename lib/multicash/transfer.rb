module Multicash
  class Transfer
    extend  ActiveModel::Naming
    include ActiveModel::Validations

    MESSAGE_IDS = %w{CRED}
    PAYMENT_SYSTEMS = %w{DTYPE PORD OPER RINGS BISER}


    attr_accessor :ordering_account, :destination_account, :payment, :payment_system, :reference_counter
    attr_reader :errors, :today, :reference_counter, :currency, :ammount, :payment_details, :payment_charges, :order_reference,
    :ordering_iban, :ordering_bae, :ordering_name, :ordering_bank_name, :destination_iban, :destination_bae, :destination_name, :destination_bank_name

    def initialize attributes = {}
      @ordering_account = attributes[:ordering_account]
      @destination_account = attributes[:destination_account]
      @payment = attributes[:payment]
      @payment_system = attributes[:payment_system]
      @errors = ActiveModel::Errors.new(self)
      @today = Time.now.strftime('%y%m%d')
      @reference_counter = 1
    end

    validate :validate_associated
    # validates :payment_system, presence: true #, format: {with: /DTYPE|PORD|OPER|RINGS|BISER/}

    def ammount
      payment.ammount_value.to_s
    end

    def currency
      payment.ammount_currency
    end

    def destination_bank_name
      @destination_bank_name = "DESTINATION BANK NAME"
    end

    def destination_name
      destination_account.name
    end

    def destination_iban
      destination_account.iban
    end

    def destination_bae
      destination_account.bae
    end

    def ordering_bank_name
      @ordering_bank_name = "ORDERING BANK NAME"
    end

    def ordering_name
      ordering_account.name
    end

    def ordering_bae
      ordering_account.bae
    end

    def ordering_iban
      ordering_account.iban
    end

    def order_reference
      @order_reference
    end

    def payment_details
      payment.details
    end

    def payment_charges
      payment.charges
    end

    def payment_system
      @payment_system.is_a?(Array) ? "/#{@payment_system.join("/")}" : "/#{@payment_system}"

    end

    private

    def validate_associated
      [:ordering_account, :destination_account, :payment].each do |associated|
        self.errors.add(associated, send(associated).errors.full_messages) unless self.send(associated).valid?
      end
    end
  end
end