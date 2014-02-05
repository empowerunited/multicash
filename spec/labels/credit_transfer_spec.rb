# require File.expand_path(File.dirname("../#{__FILE__}") + '/spec_helper')
require File.expand_path("../../spec_helper", __FILE__)

describe "Multicash::Labels::CreditTransfer" do
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
  let(:payment) { Multicash::Payment.new(ammount: ammount, details: 'Details', charges: 'SHA') }
  let(:credit_transfer) { Multicash::CreditTransfer.new(ordering_account: ordering_account,
    destination_account: destination_account,
    payment: payment,
    payment_sysytem: ['BISER'])
  }

  context "labels" do
    let(:transfer_labels) { Multicash::Labels::CreditTransfer.new(credit_transfer) }

    specify "label_20" do
      expect(transfer_labels.label_20.size).to eq(20)
    end

    specify "label_23B" do
      expect(transfer_labels.label_23B.size).to eq(9)
    end

    specify "label_32A" do
      expect(transfer_labels.label_32A.size).to eq(27)
    end

    specify "label_50K" do
      expect(transfer_labels.label_50K.size).to eq(38)
    end

    specify "label_52D" do
      expect(transfer_labels.label_52D.size).to eq(50)
    end

    specify "label_57D" do
      expect(transfer_labels.label_57D.size).to eq(50)
    end

    specify "label_59" do
      expect(transfer_labels.label_59.size).to eq(65)
    end

    specify "label_71A" do
      expect(transfer_labels.label_70.size).to eq(39)
    end

    specify "label_72" do
      expect(transfer_labels.label_72.size).to eq(5)
    end
  end
end