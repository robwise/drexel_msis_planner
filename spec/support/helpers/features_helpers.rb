module Features
  module SessionHelpers
    def sign_up_with(email, password, confirmation)
      visit new_user_registration_path
      fill_in "Email", with: email
      fill_in "Password", with: password
      fill_in "Password confirmation", with: confirmation
      click_button "Sign up"
    end

    def signin(email, password)
      visit new_user_session_path
      fill_in "Email", with: email
      fill_in "Password", with: password
      click_button "Sign in"
    end

    def signin_user(user)
      signin(user.email, user.password)
    end

    def js_signin_user(user)
      visit new_user_session_path
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      page.execute_script(click_element("commit"))
    end

    def full_title(partial_title)
      if partial_title.blank?
        "Drexel MSIS Planner"
      else
        "#{partial_title} | Drexel MSIS Planner"
      end
    end

    def fill_course_form(course)
      fill_in "Department", with: course.department
      fill_in "Level", with: course.level
      fill_in "Title", with: course.title
      fill_in "Description", with: course.description
      select course.degree_requirement.to_s.humanize, from: "Degree requirement"
      click_button "Submit"
    end

    def click_element(element_name)
      "
      target = document.getElementsByName('#{element_name}')[0];
      var event = target.ownerDocument.createEvent('MouseEvents');
      event.initMouseEvent('click');
      target.dispatchEvent(event);
      "
    end

    def fill_taken_course_modal(quarter = "201315", grade = "A+")
      fill_in "Quarter", with: quarter
      select grade, from: "Grade" unless grade == "NONE"
      click_button "Add"
    end

    def fill_planned_course_modal(quarter = nil)
      # Use factory to supply a valid quarter value to use if nil
      quarter ||= build(:planned_course).quarter

      fill_in "Quarter", with: quarter
      click_button "Submit"
    end
  end
end
