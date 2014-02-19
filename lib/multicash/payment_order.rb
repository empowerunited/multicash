module Multicash
  class PaymentOrder
    extend  ActiveModel::Naming
    include ActiveModel::Validations

    attr_accessor :reference,  :transfers_number, :errors
    attr_reader :transfers, :total_ammount, :currency, :ordering_bae, :date

    validate :valid_transfers

    def initialize
      @currency = nil
      @date = Time.now.strftime('%y%m%d')
      @errors = ActiveModel::Errors.new(self)
      @ordering_bae = nil
      @transfers = []
      @total_ammount = 0.00
    end

    def << (transfer)
      @transfers << transfer

      transfer_payment = transfer.payment
      ordering_account = transfer.ordering_account
      transfer.reference_counter = @transfers.size

      @total_ammount += (transfer_payment.ammount_value.to_f)
      @currency ||= transfer_payment.ammount_currency
      @ordering_bae ||= ordering_account.bae
    end

    def header
      first_line = "{1:F01"
      first_line << self.ordering_bae
      first_line << "XXXX0000000000}"
      first_line << "{2:I198"
      first_line << self.ordering_bae
      first_line << "XXXXN0000}"

      "#{first_line}#{header_body}\x0c"
    end

    def header_body
      payment_labels = Multicash::Labels::PaymentOrder.new(self)

      lines = []
      lines << "{4:"
      lines << payment_labels.label_20
      lines << payment_labels.label_12
      lines << payment_labels.label_77E
      lines << payment_labels.label_B1T

      lines.join("\x0D\x0A") + "\x0D\x0A-}"
    end

    def body
      lines = []
      transfers.each do |transfer|
        lines << transfer.generate
      end

      lines.join("\x0C")
    end

    def generate
      return false if transfers.blank?

      "#{header}#{body}"
    end

    def save_to_file encoding = "CP1251"
      return false unless self.errors.blank?

      bank_file = File.join(Dir.tmpdir, "#{Time.now.strftime('%Y-%m-%d')}.txt")
      File.open(bank_file, "w+", cr_newline: false, external_encoding: Kernel.const_get("Encoding::#{encoding}")) do |file|
        file.write generate.encode(encoding)
      end

      bank_file
    end

    private

    def valid_transfers
      transfers.each_with_index do |transfer, index|
        self.errors.add("transfer_#{index}", transfer.errors.full_messages) unless transfer.valid?
      end
    end

  end
end