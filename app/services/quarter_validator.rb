# Deprecated....
class QuarterValidator < ActiveModel::EachValidator
  @@valid_seasons = [15,25,35,45]

  # Quarter codes are YYYY-QQ, where QQ is 15 (Fall), 25 (Winter), 35 (Spring)
  # and 45 (Summer)
  def validate_each(record, attribute, value)
    quarter = value
    case
    when quarter.nil? || quarter.blank?
      record.errors[attribute] << (options[:message] || "cannot be null")
      return false
    when bad_length?(quarter)
      record.errors[attribute] << (options[:message] || "is not 6 digits long")
      return false
    when bad_year?(quarter)
      record.errors[attribute] << (options[:message] || "is not a valid year")
      return false
    when bad_season?(quarter)
      record.errors[attribute] << (options[:message] || "is not a valid season")
      return false
    else
      return true
    end
  end

end