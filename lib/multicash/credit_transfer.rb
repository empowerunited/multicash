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

      transfer_labels = Multicash::Transfer::LabelsBuilder.build(self)

     "#{transfer_labels.header}#{transfer_labels.body}"
    end
  end
end