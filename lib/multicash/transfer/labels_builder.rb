module Multicash
  module Transfer
    class LabelsBuilder

      def self.build transfer
        case transfer
        when Multicash::CreditTransfer
          Labels::CreditTransfer.new(transfer)
        end
      end

    end
  end
end