class QuarterValidator < ActiveModel::EachValidator

  # Quarter codes are YYYY-QQ, where QQ is 15 (Fall), 25 (Winter), 35 (Spring)
  # and 45 (Summer)
  def validate_each(record, attribute, value)
    quarter = value
    unless quarter.nil? || quarter.blank?
      year = quarter / 100
      season = (quarter - (year * 100))
      bad_year = (year > (Time.now.year + 1)) || year < 1980
      bad_season = season % 15 > 0 || !season.between?(15, 45)
      bad_length = quarter.to_s.length != 6
      if bad_year || bad_season || bad_length
        record.errors[attribute] << (options[:message] || "is not a valid quarter code")
        return false
      else
        return true
      end
    end
  end

end