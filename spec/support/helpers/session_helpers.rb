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

    def js_signin_user(user)
      visit new_user_session_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      page.execute_script(click_element('commit'))
    end

    def full_title(partial_title)
      if partial_title.blank?
        "Drexel MSIS Planner"
      else
        "#{partial_title} | Drexel MSIS Planner"
      end
    end

    def fill_course_form(course)
      fill_in 'Department', with: course.department
      fill_in 'Level', with: course.level
      fill_in 'Title', with: course.title
      fill_in 'Description', with: course.description
      select course.degree_requirement.to_s.humanize, from: 'Degree requirement'
      click_button 'Submit'
    end

    def click_element(element_name)
      "
        target = document.getElementsByName('#{element_name}')[0];
        var event = target.ownerDocument.createEvent('MouseEvents');
        event.initMouseEvent('click');
        target.dispatchEvent(event);
      "
      # "
      # function simulatedClick(target, options) {

      #             var event = target.ownerDocument.createEvent('MouseEvents'),
      #                 options = options || {};

      #             //Set your default options to the right of ||
      #             var opts = {
      #                 type: options.type                      || 'click',
      #                 canBubble:options.canBubble             || true,
      #                 cancelable:options.cancelable           || true,
      #                 view:options.view                       || target.ownerDocument.defaultView,
      #                 detail:options.detail                   || 1,
      #                 screenX:options.screenX                 || 0, //The coordinates within the entire page
      #                 screenY:options.screenY                 || 0,
      #                 clientX:options.clientX                 || 0, //The coordinates within the viewport
      #                 clientY:options.clientY                 || 0,
      #                 ctrlKey:options.ctrlKey                 || false,
      #                 altKey:options.altKey                   || false,
      #                 shiftKey:options.shiftKey               || false,
      #                 metaKey:options.metaKey                 || false, //I *think* 'meta' is 'Cmd/Apple' on Mac, and 'Windows key' on Win. Not sure, though!
      #                 button:options.button                   || 0, //0 = left, 1 = middle, 2 = right
      #                 relatedTarget:options.relatedTarget     || null,
      #             }

      #             //Pass in the options
      #             event.initMouseEvent(
      #                 opts.type,
      #                 opts.canBubble,
      #                 opts.cancelable,
      #                 opts.view,
      #                 opts.detail,
      #                 opts.screenX,
      #                 opts.screenY,
      #                 opts.clientX,
      #                 opts.clientY,
      #                 opts.ctrlKey,
      #                 opts.altKey,
      #                 opts.shiftKey,
      #                 opts.metaKey,
      #                 opts.button,
      #                 opts.relatedTarget
      #             );

      #             //Fire the event
      #             target.dispatchEvent(event);
      #         }"
    end
  end
end
