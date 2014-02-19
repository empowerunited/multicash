module Multicash
  class Transfer::LabelsBuilder
    def self.build transfer
      case transfer
      when Multicash::CreditTransfer
        Labels::CreditTransfer.new(transfer)
      end
    end
  end
end