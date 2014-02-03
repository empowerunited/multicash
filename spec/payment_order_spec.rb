require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Multicash::PaymentOrder" do
  let(:ordering_account) { Multicash::Account.new({ name: 'Име на наредителя',
    city: 'Град на наредителя',
    address: 'Адрес на наредителя',
    iban: 'BG11UBBS10021041615812',
    bank_name: 'Банка на наредителя'})
  }

  let(:destination_account) { Multicash::Account.new({ name: 'Име на получателя',
    city: 'Град на получателя',
    address: 'Адрес на плучателя',
    iban: 'BG11UBBS100210416158115',
    bank_name: 'Банка на плучателя'})
  }

  let(:ammount) { Multicash::Ammount.new(value: 222.12, currency: 'BGN') }
  let(:payment) { Multicash::Payment.new( ammount: ammount, details: 'Details', charges: 'SHA') }
  let(:transfer) { Multicash::CreditTransfer.new(ordering_account: ordering_account,
    destination_account: destination_account,
    payment: payment,
    payment_system: 'BISER')
  }

  context "generate" do
    subject { Multicash::PaymentOrder.new }

    specify "save to file" do
      subject << transfer
      subject << transfer
      file_name = subject.save_to_file


      expect(File.exist?(file_name)).to be_true
    end
  end
end
