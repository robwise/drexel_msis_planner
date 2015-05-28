class Quarter
  # Drexel is on a quarter system and refers to each quarter by its quarter
  # code. The first four digits are the year in which the quarter appears, and
  # the trailing two digits represent the season.
  #
  # Quarter codes are Drexel's existing concept, so despite the issues inherent
  # with encoding values in this manner, it is best to use them for user
  # familiarity.

  # Generates all quarters between first and last given quarters
  def self.from(args)
    current_quarter = Quarter.new(args[:first])
    last_quarter = Quarter.new(args[:last])
    quarters = []
    while current_quarter <= last_quarter
      quarters << current_quarter
      current_quarter = current_quarter.next_quarter
    end
    quarters
  end

  def self.get_date_from(object)
    if object.class? == String
      return Date.parse(date)
    elsif object.class? == Date && object.valid_date?
      return object
    else
      fail ArgumentError,
           "'#{object}' is invalid. Must be a valid date string or object",
           caller
    end
  end

  def self.current_quarter
    Time.current.month
    season_hash = Quarter::MONTHS.select { |season, month_range| month_range.include?(Time.current.month) }
    season = season_hash.keys.first
    season_code = VALID_SEASONS[season]
    year_code = season.to_s == "fall" ? Time.current.year : Time.current.year - 1
    new(year_code * 100 + season_code)
  end

  # Takes two quarters and finds the number of quarters between them
  def self.num_quarters_between(first, last)
    Quarter.new(last) - first
  end

  include Comparable
  VALID_SEASONS = { fall: 15, winter: 25, spring: 35, summer: 45 }
  MONTHS = { fall: 9..12, winter: 1..3, spring: 4..5, summer: 6..8 }
  attr_accessor :code

  def initialize(arg)
    arg = arg.code if code.is_a?(Quarter) # will work if passed a qtr
    @code = arg.to_s.to_i # will work for integer, symbol, or string arg
    fail ArgumentError, "#{@code} is not a valid code" if !valid?
  end

  def <=>(other)
    code <=> other.code
  end

  def humanize
    "#{season.to_s.titleize} #{year}"
  end

  def season_code
    code % 100
  end

  def season
    VALID_SEASONS.key(season_code)
  end

  def year_code
    code / 100
  end

  def year
    to_date.year
  end

  # Pass an optional argument of true to get ending month's date
  # (default is false)
  def to_date(last_month = false)
    date_month = last_month ? MONTHS[season].last : MONTHS[season].first
    date_year = season_code == 15 ? year_code : year_code + 1
    if last_month
      Date.new(date_year, date_month).end_of_month
    else
      Date.new(date_year, date_month)
    end
  end

  def future?
    to_date > Time.current
  end

  def past?
    to_date(true) < Time.current
  end

  def next_quarter
    if 45 == season_code
      Quarter.new((year_code + 1) * 100 + 15)
    else
      Quarter.new(year_code * 100 + season_code + 10)
    end
  end

  def previous_quarter
    if 15 == season_code
      Quarter.new((year_code - 1) * 100 + 45)
    else
      Quarter.new(year_code * 100 + season_code - 10)
    end
  end

  def to_s
    @code.to_s
  end

  # Returns the number of quarters from the quarter to the given operand
  def -(other)
    other_quarter = Quarter.new(other)
    seasons = season_difference(other_quarter)
    years = year_difference(other_quarter)
    years * 4 + seasons
  end

  def quarter_rank
    season_code / 10
  end

  private

  def valid?
    !(code.nil? || bad_season? || bad_year? || bad_length?)
  end

  def season_difference(other_quarter)
    quarter_rank - other_quarter.quarter_rank
  end

  def year_difference(other_quarter)
    year_code - other_quarter.year_code
  end

  def bad_length?
    code.to_s.length != 6
  end

  def bad_year?
    (year > (Time.current.year + 10)) || year < 1980
  end

  def bad_season?
    !VALID_SEASONS.values.include?(season_code)
  end
end
