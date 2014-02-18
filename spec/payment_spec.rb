require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Multicash::Payment" do
  let(:ammount) { Multicash::Ammount.new(value: 222.12, currency: 'BGN') }
  let(:details) { 'Payment details' }
  let(:charges) { 'OUR' }

  context "validations" do
    it "valid when required attributes are submited" do
      expect(Multicash::Payment.new(ammount, details, charges)).to be_valid
    end

    it "not valid if ammount is not valid" do
      ammount = Multicash::Ammount.new(value: 222.12222222, currency: 'BGN')
      details = "Payment details"
      charges = 'OUR'
      expect(Multicash::Payment.new(ammount, details, charges)).to_not be_valid
    end

    it "not valid if charges are not in allowed range" do
      charges = 'FRR'
      expect(Multicash::Payment.new(ammount, details, charges)).to_not be_valid
    end
  end
end