require 'spec_helper'

describe IpFormatValidator do

  let(:fake_model) { FakeModel.new }

  let(:ipv4_ips)    { %w(192.68.1.1 255.255.255.0 172.68.0.1)           }
  let(:ipv6_ips)    { %w(fde4:8dba:82e1:: 2001:db8::8:800:200c:417a)    }
  let(:invalid_ips) { %w(1231231231231231 1922.68.1.1 fde4:8dba:82z1::) }

  context "with valid ips" do

    it "should be accept ipv6 ips" do
      ipv6_ips.each do |ip|
        fake_model.ip = ip
        expect(fake_model.valid?).to be_truthy
      end
    end

    it "should accept ipv4 ips" do
      ipv4_ips.each do |ip|
        fake_model.ip = ip
        expect(fake_model.valid?).to be_truthy
      end
    end
  end

  context "with only_ipv6: true" do

    let(:fake_model) { FakeModelWithOnlyIpv6.new }

    it "should accept ipv6 ips" do
      ipv6_ips.each do |ip|
        fake_model.ip = ip
        expect(fake_model.valid?).to be_truthy
      end
    end

    it "should not accept ipv4 ips" do
      ipv4_ips.each do |ip|
        fake_model.ip = ip
        expect(fake_model.valid?).to be_falsey
      end
    end
  end

  context "with only_ipv4: true" do

    let(:fake_model) { FakeModelWithOnlyIpv4.new }

    it "should accept ipv4 ips" do
      ipv4_ips.each do |ip|
        fake_model.ip = ip
        expect(fake_model.valid?).to be_truthy
      end
    end

    it "should not accept ipv6 ips" do
      ipv6_ips.each do |ip|
        fake_model.ip = ip
        expect(fake_model.valid?).to be_falsey
      end
    end
  end

  context "with invalid ips" do

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
