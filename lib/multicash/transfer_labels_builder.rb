module Multicash
  class TransferLabelsBuilder
    def self.build transfer
      case transfer
      when Multicash::CreditTransfer
        Labels::CreditTransfer.new(transfer)
      end
    end
  end
end