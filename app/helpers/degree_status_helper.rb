module DegreeStatusHelper
  def degree_progress_statistics(user)
    [
      { label: "Required Courses",
        statistic: progress_bar_for(user, :required_course) },
      { label: "Distribution Courses",
        statistic: progress_bar_for(user, :distribution_requirement) },
      { label: "Free Elective Courses",
        statistic: progress_bar_for(user, :free_elective) },
      { label: "Total",
        statistic: progress_bar_for(user, :total_credits) }
    ]
  end

  def degree_general_statistics(user)
    [
      { label: "Duration",
        statistic: user.degree_statistics.duration_pretty },
      { label: "Average Courses Per Quarter",
        statistic: user.taken_courses.size / user.degree_statistics.duration_in_quarters },
      { label: "GPA", statistic: "4.0" }
    ]
  end

  private

  # progress_type takes a symbol or String argument (:required_course, :free_elective,
  # :distribution_course, or :total_credits)
  def progress_bar_for(user, progress_type)
    numerator = user.degree_statistics.send(progress_type.to_s + "_count")
    denominator = user.degree_statistics.send(progress_type.to_s + "_count_needed")
    build_progress_bar(numerator, denominator)
  end
end
