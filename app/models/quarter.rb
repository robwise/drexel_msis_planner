class Quarter
  include Comparable

  @@valid_seasons = [15,25,35,45]

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

  private

    def bad_length?
      @code.to_s.length != 6
    end

    def bad_year?
      year = @code / 100
      (year > (Time.now.year + 10)) || year < 1980
    end

    def bad_season?
      season = @code % 100
      not @@valid_seasons.include?(season)
    end

end