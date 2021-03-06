module Multicash
  module Labels
    class CreditTransfer

      include Multicash::Utils
      attr_reader :transfer

      def initialize transfer
        @transfer = transfer
      end

      def label_20
        label = ":20:"
        value = sprintf("%010d", transfer.order_reference)

        "#{label}#{value}"
      end

      def label_23B
        label = ":23B:"
        value = ""
        value << transfer.message_id

        "#{label}#{value}"
      end

      def label_32A
        label = ':32A:'
        value = ""
        value << transfer.today
        value << transfer.currency
        value << print_currency_with_comma(transfer.ammount, -10)

        "#{label}#{print_string((value), -22)}"
      end

      def label_50K
        label = ":50K:"
        value = "/"
        value << transfer.ordering_iban
        value << "\r\n"
        value << transfer.ordering_name

        "#{label}#{value}"
      end

      def label_52D
        label = ":52D:"
        value = transfer.ordering_bae
        value << "\r\n"
        value << print_string(transfer.ordering_bank_name, -35)

        "#{label}#{value}"
      end

      def label_57D
        label = ":57D:"
        value = transfer.destination_bae
        value << "\r\n"
        value << print_string(transfer.destination_bank_name, -35)

        "#{label}#{value}"
      end

      def label_59
        label = ":59:"
        value = '/'
        value << transfer.destination_iban
        value << "\r\n"
        value << print_string(transfer.destination_name, -35)

        "#{label}#{value}"
      end

      def label_70
        label = ":70:"
        value = print_string(transfer.payment_details, -35)

        "#{label}#{value}"
      end

      def label_70_footer
        value = "/"
        value << "\r\n"
        value << "/NTYPE/000000000000"
        value << "\r\n"
        value << "/OPNAT/J"

        value
      end

      def label_71A
        label = ":71A:"
        value = ""
        value << transfer.payment_charges

        "#{label}#{value}"
      end

      def label_72
        label = ":72:"
        value = transfer.payment_system

        "#{label}#{value}"
      end

      def label_72_footer
        value = "/BAEREF/000000000000000000"
        value << "\r\n"
        value << "/PROL/NORM"
      end
    end
  end
end