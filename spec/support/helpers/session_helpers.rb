module Features
  module SessionHelpers
    def sign_up_with(email, password, confirmation)
      visit new_user_registration_path
      fill_in 'Email', with: email
      fill_in 'Password', with: password
      fill_in 'Password confirmation', :with => confirmation
      click_button 'Sign up'
    end

    def signin(email, password)
      visit new_user_session_path
      fill_in 'Email', with: email
      fill_in 'Password', with: password
      click_button 'Sign in'
    end

    def signin_user(user)
      signin(user.email, user.password)
    end

    def full_title(partial_title)
      if partial_title.blank?
        "Drexel MSIS Planner"
      else
        "#{partial_title} | Drexel MSIS Planner"
      end
    end

    def add_course(course)
      visit new_course_path
      fill_in 'Department', with: course.department
      fill_in 'Level', with: course.level
      fill_in 'Title', with: course.title
      select 'Degree Requirement',
        selection: course.degree_requirement.to_s.humanize.titleize
      fill_in 'Description', with: course.description
    end
  end
end
