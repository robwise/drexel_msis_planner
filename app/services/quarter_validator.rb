class QuarterValidator < ActiveModel::EachValidator

  # Quarter codes are YYYY-QQ, where QQ is 15 (Fall), 25 (Winter), 35 (Spring)
  # and 45 (Summer)
  def validate_each(record, attribute, value)
    quarter = value
    if quarter.presence
      year = quarter / 100
      season = (quarter - (year * 100))
      if bad_year?(year) || bad_season?(season) || bad_length?(quarter)
        record.errors[attribute] << (options[:message] || "is not a valid quarter code")
        return false
      else
        return true
      end
    else
      record.errors[attribute] << (options[:message] || "cannot be null")
      return false
    end
  end

  private

    def bad_length?(quarter)
      quarter.to_s.length != 6
    end

    def bad_year?(year)
      (year > (Time.now.year + 1)) || year < 1980
    end

    def bad_season?(season)
      not ([15,25,35,45].include? season)
    end

end