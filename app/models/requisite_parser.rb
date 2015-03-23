# Parses a given requisite rule formatted as seen on Drexel's Term Master
# Schedule website to determine whether a given course history (assumed to be
# and ActiveRecord::Association) fulfills the requisite. Users of this object
# will need to take care to ensure the course history only includes those
# courses from quarters prior to the requisite course (prerequisite) or prior to
# and including the quarter of the requiring course (corequisite).
class RequisiteParser
  attr_reader :course_history, :requisite

  def initialize(course_history, requisite)
    @course_history = course_history
    @requisite = requisite
  end

  def fulfilled?
    # The format used on the TMS can actually be evaluated by Ruby once we
    # substitute out the courses with a 'true' or 'false' corresponding to
    # the course's existence in the course history or not, respectively.
    eval sub_courses_with_existence_in_history(@requisite.raw_text.strip)
  end

  private

  def sub_courses_with_existence_in_history(string)
    Kernel.loop do
      return string if string.sub!(course_regex) do |match|
        level = match.match(level_regex)[1]
        department = match.match(department_regex)[1]
        @course_history.exists?(department: department, level: level).to_s
      end.nil?
    end
  end

  def course_regex
    /([A-Z]{2,4} \d\d\d Minimum Grade: C)/
  end

  def level_regex
    /[A-Z]{2,4} (\d\d\d) Minimum Grade: C/
  end

  def department_regex
    /([A-Z]{2,4}) \d\d\d Minimum Grade: C/
  end
end
