module Multicash
  class PaymentOrder
    extend  ActiveModel::Naming
    include ActiveModel::Validations

    attr_accessor :reference,  :transfers_number, :errors
    attr_reader :transfers, :total_ammount, :currency, :ordering_bae, :date

    def initialize
      @currency = nil
      @date = Time.now.strftime('%y%m%d')
      @errors = ActiveModel::Errors.new(self)
      @ordering_bae = nil
      @transfers = []
      @total_ammount = 0.00
    end

    def << (transfer)
      if transfer.valid?
        @transfers << transfer
        transfer.reference_counter = @transfers.size
        @total_ammount += (transfer.ammount.to_f)
        @currency ||= transfer.currency
        @ordering_bae ||= transfer.ordering_bae
      else
        errors.add("#{transfer.reference_counter}", transfer.errors.full_messages)
      end
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

      lines.join("\n") + "\n-}"
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

    def save_to_file
      return false unless self.errors.blank?

      bank_file = File.join(Dir.tmpdir, "#{Time.now.strftime('%Y-%m-%d')}.txt")
      File.open(bank_file, "w+", cr_newline: true, external_encoding: Encoding::CP1251) do |file|
        file.write generate.encode("CP1251")
      end

      bank_file
    end
  end
end