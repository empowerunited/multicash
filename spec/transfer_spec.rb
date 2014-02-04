require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Multicash::Transfer" do
  let(:ordering_account) { Multicash::Account.new({ name: 'Jonh Doe',
    city: 'Ordering City',
    address: 'Ordering Address',
    iban: 'BG11UBBS10021041615812',
    bank_name: 'Bank name'})
  }

  let(:destination_account) { Multicash::Account.new({ name: 'Jonh Doe',
    city: 'Destination City',
    address: 'Destination Address',
    iban: 'BG11UBBS100210416158115',
    bank_name: 'Destination Bank name'})
  }

  let(:ammount) { Multicash::Ammount.new(value: 222.12, currency: 'BGN') }
  let(:payment) { Multicash::Payment.new( ammount: ammount, details: 'Details', charges: 'SHA') }

  context "validations" do
    it "valid on valid initilization attributes" do
      expect(Multicash::Transfer.new( ordering_account: ordering_account,
        destination_account: destination_account,
        payment: payment,
        payment_system: ['BISER'])
      ).to be_valid
    end

    it "invalid on invalid ordering_account attribute" do
      ordering_account.name = ''

      expect(Multicash::Transfer.new(ordering_account: ordering_account,
        destination_account: destination_account,
        payment: payment,
        payment_system: ['BISER'])
      ).to_not be_valid
    end

    it "invalid on invalid destination_account attribute" do
      destination_account.name = ''

      expect(Multicash::Transfer.new(ordering_account: ordering_account,
        destination_account: destination_account,
        payment: payment,
        payment_system: ['BISER'])
      ).to_not be_valid
    end

    it "invalid on invalid payment attribute" do
      payment.ammount.value = 'fffff'

      expect(Multicash::Transfer.new(ordering_account: ordering_account,
        destination_account: destination_account,
        payment: payment,
        payment_sysytem: ['BISER'])
      ).to_not be_valid
    end
  end

end
