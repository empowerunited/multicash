module Multicash
  module Labels
    class PaymentOrder
      include Multicash::Utils
      attr_reader :payment_order

      def initialize payment_order
        @payment_order = payment_order
      end

      def label_20
        label = ":20:"
        value = ""
        value << payment_order.date
        value << sprintf("%010d", print_string(payment_order.transfers.size, -22))


        "#{label}#{value}"
      end

      def label_12
        label = ":12:"
        value = sprintf("%03d", payment_order.transfers.size)

        "#{label}#{value}"
      end

      def label_77E
        label = ":77E:"
        value = ":B01:"
        value << payment_order.date

        "#{label}#{value}"
      end

      def label_B1T
        label = ":B1T:"
        value = sprintf("%03d", payment_order.transfers.size)
        value << payment_order.currency
        value << print_currency_with_comma(payment_order.total_ammount.to_s, -9)

        "#{label}#{value}"
      end
    end
  end
end