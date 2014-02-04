require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Multicash::Payment" do
  let(:attributes) {
    { ammount: Multicash::Ammount.new(value: 222.12, currency: 'BGN'),
      details: 'Payment details',
      charges: 'SHA',
    }
  }

  context "validations" do
    it "valid when required attributes are submited" do
      expect(Multicash::Payment.new(attributes)).to be_valid
    end

    it "not valid if ammount is not valid" do
      attributes[:ammount] = Multicash::Ammount.new(value: 222.12222222, currency: 'BGN')
      expect(Multicash::Payment.new(attributes)).to_not be_valid
    end

    it "not valid if charges are not in allowed range" do
      attributes[:charges] = 'FRR'
      expect(Multicash::Payment.new(attributes)).to_not be_valid
    end
  end
end