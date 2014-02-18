module Multicash
  module Transfer
    module Helpers

      def ammount
        self.payment.ammount_value.to_s
      end

      def currency
        self.payment.ammount_currency
      end

      def destination_bank_name
        self.destination_account.bank_name ||= "DESTINATION BANK NAME"
      end

      def destination_name
        self.destination_account.name
      end

      def destination_iban
        self.destination_account.iban
      end

      def destination_bae
        self.destination_account.bae
      end

      def ordering_bank_name
        self.ordering_account.bank_name ||= "ORDERING BANK NAME"
      end

      def ordering_name
        self.ordering_account.name
      end

      def ordering_bae
        self.ordering_account.bae
      end

      def ordering_iban
        self.ordering_account.iban
      end

      def payment_details
        self.payment.details
      end

      def payment_charges
        self.payment.charges
      end

    end
  end
end