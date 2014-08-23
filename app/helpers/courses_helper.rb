module CoursesHelper
  def requirements
    Course.degree_requirements.collect do |requirement|
      [ requirement[0].humanize, requirement[0] ]
    end
  end
end
