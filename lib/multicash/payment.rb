module Multicash
  class Payment
    extend  ActiveModel::Naming
    include ActiveModel::Validations

    CHARGES = %w{SHA OUR BEN}

    attr_accessor :ammount, :details, :charges
    attr_reader :errors, :ammount_value, :ammount_currency

    def initialize ammount, details, charges
      @ammount = ammount
      @details = details
      @charges = charges
      @errors = ActiveModel::Errors.new(self)
    end

    validate  :valid_ammount
    validates :ammount, presence: true
    validates :details, presence: true
    validates :charges, presence: true, inclusion: { in: CHARGES }

    def ammount_value
      ammount.value
    end

    def ammount_currency
      ammount.currency
    end

    def valid_ammount
      unless self.ammount.valid?
        self.errors.add(:ammount, self.ammount.errors.full_messages)
      end
    end
  end
end