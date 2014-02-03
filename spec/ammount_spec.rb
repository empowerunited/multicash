require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Multicash::Ammount" do
  context "validations" do
    it "valid when all required attributes are submited" do
      expect(Multicash::Ammount.new(value: 222.12, currency: 'BGN')).to be_valid
    end

    it "not be valid when currency is not in allowed format" do
      expect(Multicash::Ammount.new(value: 222.122, currency: 'BGN')).to_not be_valid
    end

    it "not be valid when currency is not in allowed range" do
      expect(Multicash::Ammount.new(value: 222.122, currency: 'VVN')).to_not be_valid
    end
  end
end