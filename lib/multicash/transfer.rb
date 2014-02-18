module Multicash
  class Transfer

    extend  ActiveModel::Naming
    include ActiveModel::Validations

    MESSAGE_IDS = %w{CRED}
    PAYMENT_SYSTEMS = %w{DTYPE PORD OPER RINGS BISER}


    attr_accessor :ordering_account, :destination_account, :payment, :reference_counter
    attr_reader :errors, :today, :reference_counter,  :payment_system

    def initialize attributes = {}
      @ordering_account = attributes[:ordering_account]
      @destination_account = attributes[:destination_account]
      @payment = attributes[:payment]
      @payment_system = attributes[:payment_system]
      @errors = ActiveModel::Errors.new(self)
      @today = Time.now.strftime('%y%m%d')
      @reference_counter = 0
    end

    validate :validate_associated
    # validates :payment_system, presence: true #, format: {with: /DTYPE|PORD|OPER|RINGS|BISER/}

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