require 'spec_helper'

class TestCompany < TestModel
  validates :orgno, :orgno => true
end

class TestCompanyAllowsNil < TestModel
  validates :orgno, :orgno => {:allow_nil => true}
end

class TestCompanyAllowsNilFalse < TestModel
  validates :orgno, :orgno => {:allow_nil => false}
end

class TestCompanyWithMessage < TestModel
  validates :organisasjonsnummer, :orgno => {:message => 'is not looking very good!'}
end

describe OrgnoValidator do

  describe "validation" do
    context "given the valid orgno" do
      %W(810243562 948776901 957929621).each do |orgno|
        it "#{orgno.inspect} should be valid" do
          TestCompany.new(:orgno => orgno).should be_valid
        end
      end
    end

    context "given the invalid orgno" do
      %W(810243561 948776900 957929620).each do |orgno|
        it "#{orgno.inspect} should not be valid" do
          TestCompany.new(:orgno => orgno).should_not be_valid
        end
      end
    end

    context "given a string with 9 characters" do
      %W(abcdefghi uytrewqas).each do |orgno|
        it "#{orgno.inspect} should not be valid" do
          TestCompany.new(:orgno => orgno).should_not be_valid
        end
      end
    end


  end

  describe "error messages" do
      context "when the message is not defined" do
        subject { TestCompany.new :orgno => '948776900' }
        before { subject.valid? }

        it "should add the default message" do
          subject.errors[:orgno].should include "is invalid"
        end
      end

      context "when the message is defined" do
        subject { TestCompanyWithMessage.new :organisasjonsnummer => '948776900' }
        before { subject.valid? }

        it "should add the customized message" do
          subject.errors[:organisasjonsnummer].should include "is not looking very good!"
        end
      end
    end

  describe "nil orgno" do
    it "should not be valid when :allow_nil option is missing" do
      TestCompany.new(:orgno => nil).should_not be_valid
    end

    it "should be valid when :allow_nil options is set to true" do
      TestCompanyAllowsNil.new(:orgno => nil).should be_valid
    end

    it "should not be valid when :allow_nil option is set to false" do
      TestCompanyAllowsNilFalse.new(:orgno => nil).should_not be_valid
    end
  end
end