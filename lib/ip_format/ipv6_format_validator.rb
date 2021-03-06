class Ipv6FormatValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ Resolv::IPv6::Regex
      record.errors[attribute] << (options[:message] || "is invalid")
    end
  end
end
