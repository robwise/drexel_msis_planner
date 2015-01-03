class Quarter
  include Comparable
  @@valid_seasons = { fall: 15, winter: 25, spring: 35, summer: 45 }
  @@months = { fall: 9..12, winter: 1..3, spring: 4..6, summer: 6..8 }
  attr_accessor :code

  def initialize(code)
    @code = code
  end

  def valid?
    not (code.nil? || bad_season? || bad_year? || bad_length?)
  end

  def <=>(other_quarter)
    code <=> other_quarter.code
  end

  def humanize
    "#{season.to_s.titleize} #{year}"
  end

  def season_code
    code % 100
  end

  def season
    @@valid_seasons.key(season_code)
  end

  def season=(new_season)
    season_symbol = new_season.downcase.to_sym
    unless @@valid_seasons.include?(season_symbol)
      raise ArgumentError.new("Season: '#{season_symbol}' is not valid")
    end
    @code = (year.to_s + @@valid_seasons[season_symbol].to_s).to_i
  end

  def year
    code / 100
  end

  def year=(new_year)
    @code = (new_year.to_s + season.to_s).to_i
  end

  def to_date
    month = @@months[season].first
    Date.new(year, month)
  end

  private

    def bad_length?
      code.to_s.length != 6
    end

    def bad_year?
      (year > (Time.now.year + 10)) || year < 1980
    end

    def bad_season?
      not @@valid_seasons.values.include?(season_code)
    end

    def self.get_date_from(object)
      if object.class? == String
       return Date.parse(date)
      elsif object.class? == Date && object.valid_date?
        return object
      else
        raise ArgumentError.new("'#{object}' is invalid. Must be a valid date
                                string or object")
      end
    end

end