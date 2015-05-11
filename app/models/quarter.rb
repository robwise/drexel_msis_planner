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
    new(Time.current.year * 100 + (Time.current.month / 4).ceil * 15)
  end

  # Takes two quarters and finds the number of quarters between them
  def self.num_quarters_between(first, last)
    Quarter.new(last) - first
  end

  include Comparable
  VALID_SEASONS = { fall: 15, winter: 25, spring: 35, summer: 45 }
  MONTHS = { fall: 9..12, winter: 1..3, spring: 4..6, summer: 6..8 }
  attr_accessor :code

  def initialize(arg)
    arg = arg.code if code.kind_of?(Quarter) # will work if passed a qtr
    @code = arg.to_s.to_i # will work for integer, symbol, or string arg
  end

  def valid?
    !(code.nil? || bad_season? || bad_year? || bad_length?)
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

  def season=(new_season)
    season_symbol = new_season.downcase.to_sym
    unless VALID_SEASONS.include?(season_symbol)
      fail ArgumentError, "Season: '#{season_symbol}' is not valid", caller
    end
    @code = (year.to_s + VALID_SEASONS[season_symbol].to_s).to_i
  end

  def year
    code / 100
  end

  def year=(new_year)
    @code = (new_year.to_s + season.to_s).to_i
  end

  # Pass an optional argument of true to get ending month's date
  # (defaults to false)
  def to_date(last_month = false)
    month = last_month ? MONTHS[season].last : MONTHS[season].first
    Date.new(year, month)
  end

  def future?
    to_date > Time.current
  end

  def past?
    to_date < Time.current
  end

  def next_quarter
    if 45 == season_code
      Quarter.new((year + 1) * 100 + 15)
    else
      Quarter.new(year * 100 + season_code + 10)
    end
  end

  def next_quarter!
    @code = next_quarter.code
    self
  end

  def to_s
    @code.to_s
  end

  # Returns the number of quarters from the quarter to the given operand
  def -(operand)
    qtr_operand = Quarter.new(operand)
    season_difference = ((@code % 100 - 5) / 10) - ((qtr_operand.code % 100 - 5) / 10)
    year_difference = (@code / 100 - qtr_operand.code / 100)
    year_difference * 4 + season_difference
  end

  private

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
