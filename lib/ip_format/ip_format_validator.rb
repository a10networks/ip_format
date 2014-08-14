class IpFormatValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ Resolv::AddressRegex
      record.errors[attribute] << (options[:message] || "is invalid")
    end
  end
end
