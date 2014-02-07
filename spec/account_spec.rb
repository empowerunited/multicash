require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Multicash::Account" do
  let(:account_attributes) {
    { name: 'Jonh Doe',
      city: 'City',
      address: 'Address',
      iban: 'BG11UBBS10021041615811',
      bank_name: 'Bank name'
    }
  }

  context "validations" do
    it "valid when required attributes are submited" do
      expect(Multicash::Account.new(account_attributes)).to be_valid
    end

    it "not be valid if required attributes are missing" do
      account_attributes[:iban] = "IBAN:BG57FINV915010BGN020QIBIC:FINVBGSF"
      expect(Multicash::Account.new(account_attributes)).to_not be_valid
    end
  end
end