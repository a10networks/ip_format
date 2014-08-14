require 'spec_helper'

describe IpFormatValidator do

  let(:fake_model) { FakeModel.new }

  context "with valid macs" do

    let(:valid_ips) { %w(192.68.1.1 fde4:8dba:82e1::) }

    it "should be happy" do
      valid_ips.each do |ip|
        fake_model.ip = ip
        expect(fake_model.valid?).to be_truthy
      end
    end
  end

  context "with invalid ips" do

    let(:invalid_ips) { %w(1231231231231231 1922.68.1.1 fde4:8dba:82z1::) }

    it "shouldn't be happy" do
      invalid_ips.each do |ip|
        fake_model.ip = ip
        expect(fake_model.valid?).to be_falsey
      end
    end
  end

  context "with allow_blank: true" do

    let(:fake_model)   { FakeModelWithBlankIp.new }
    let(:blank_ips) { ['', nil, ' '] }

    it "should allow blank ips" do
      blank_ips.each do |blank_ip|
        fake_model.ip = blank_ip
        expect(fake_model.valid?).to be_truthy
      end
    end
  end
end
