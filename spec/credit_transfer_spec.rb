require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Multicash::CreditTransfer" do
  let(:ordering_account) { Multicash::Account.new({ name: 'Company',
    city: 'Ordering City',
    address: 'Ordering Address',
    iban: 'BG84UNCR70001521287097',
    bank_name: 'Bank name'})
  }

  let(:destination_account) { Multicash::Account.new({ name: 'Jonh Doe',
    city: 'Destination City',
    address: 'Destination Address',
    iban: 'BG84UNCR70001521287097',
    bank_name: 'Destination Bank name'})
  }

  let(:ammount) { Multicash::Ammount.new(value: 222.12, currency: 'BGN') }
  let(:payment) { Multicash::Payment.new( ammount: ammount, details: 'Details', charges: 'SHA') }

  context "validations" do
    it "valid with correct message_id" do
      expect(Multicash::CreditTransfer.new(ordering_account: ordering_account,
        destination_account: destination_account,
        payment: payment,
        payment_system: 'BISER')
      ).to be_valid
      expect(Multicash::CreditTransfer.new(ordering_account: ordering_account,
        destination_account: destination_account,
        payment: payment,
        payment_system: 'BISER').message_id
      ).to eq('CRED')
    end
  end

  context "generate" do
    it "correct header" do
      transfer = Multicash::CreditTransfer.new(ordering_account: ordering_account,
        destination_account: destination_account,
        payment: payment,
        payment_system: 'BISER')

      expect(transfer.header.size).to eq(54)
    end

    it "correct extended body" do
      transfer = Multicash::CreditTransfer.new(ordering_account: ordering_account,
        destination_account: destination_account,
        payment: payment,
        payment_system: 'BISER')

      transfer.header + transfer.body
    end
  end
end