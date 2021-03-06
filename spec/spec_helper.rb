require 'rubygems'
require 'bundler/setup'
require 'rspec'
require 'active_model'
require 'ip_format'

class FakeModel
  include ActiveModel::Validations

  attr_accessor :ip

  validates :ip, ip_format: true
end

class FakeModelWithOnlyIpv6
  include ActiveModel::Validations

  attr_accessor :ip

  validates :ip, ipv6_format: true
end

class FakeModelWithOnlyIpv4
  include ActiveModel::Validations

  attr_accessor :ip

  validates :ip, ipv4_format: true
end

class FakeModelWithBlankIp
  include ActiveModel::Validations

  attr_accessor :ip

  validates :ip, ip_format: true, allow_blank: true
end
