# check this https://github.com/iulianu/iban-tools

# Create new transfer for payment order and puts correct labels according the Multicash spec
module Multicash
  class CreditTransfer < Transfer

    attr_reader :message_id

    def initialize attributes = {}
      super

      @message_id = 'CRED'
    end

    def generate
      return self.errors.full_messages.to_sentence unless self.valid?

     "#{self.header}#{self.body}"
    end

    def header
      line = "{1:F01"
      line << self.ordering_bae
      line << "XXXX0000000000}"
      line << "{2:I103"
      line << self.destination_bae
      line << "XXXXN0000}"
      line
    end

    def body
      transfer_labels = Multicash::TransferLabelsBuilder.build(self)
      lines = []
      lines << "{4:"
      lines << transfer_labels.label_20
      lines << transfer_labels.label_23B
      lines << transfer_labels.label_32A
      lines << transfer_labels.label_50K
      lines << transfer_labels.label_52D
      lines << transfer_labels.label_57D
      lines << transfer_labels.label_59
      lines << transfer_labels.label_70
      lines << transfer_labels.label_70_footer
      lines << transfer_labels.label_71A
      lines << transfer_labels.label_72
      lines << transfer_labels.label_72_footer
      lines << "-}"

      lines.join("\x0D\x0A")
    end

    def order_reference
      counter = sprintf("%010d", reference_counter)
      "#{today}#{counter}"
    end
  end
end