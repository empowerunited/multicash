module Multicash
  module Utils

    def print_string value, lenght, fill_with = ''
      sprintf("%#{fill_with}#{lenght}s", value)
    end

    def print_number value, lenght
      sprintf("%#{lenght}d", value)
    end

    def print_currency value, lenght
      sprintf("%#{lenght}.2f", value)
    end

    def print_currency_with_comma value, lenght
      value = sprintf("%#{lenght}.2f", value)
      value_with_comma = value.gsub('.', ',')
    end

    def calc_bae iban
      iban[4, 8]
    end
  end
end
