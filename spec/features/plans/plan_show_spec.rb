feature "Visiting the plan page" do
  let(:user) { create :user }
  let(:plan) { create :plan, user: user }

  scenario "as a user with taken and planned courses" do
    taken_course = create :taken_course, user: user
    course = create :course,
                    :required,
                    :with_unfulfillable_prerequisite,
                    :with_unfulfillable_corequisite
    planned_course = create :planned_course, course: course, plan: plan
    create :planned_course, :distribution, plan: plan
    create :planned_course, :free_elective, plan: plan
    create :taken_course, :required, user: user
    create :taken_course, :distribution, user: user
    create :taken_course, :free_elective, user: user
    signin_user(user)
    visit plan_path(plan)
    expect(page).to have_title(full_title(plan.name))
    expect(page).to have_css("h1", "#{ plan.name }")
    expect(page).to have_content(taken_course.full_id)
    expect(page).to have_content(planned_course.full_id)
    expect(page).to have_content(course.prerequisite)
    expect(page).to have_content(course.corequisite)

    expect(page.find("#required-courses-count")).to have_content "2/9"
    expect(page.find("#distribution-courses-count")).to have_content("2/4")
    expect(page.find("#free-elective-courses-count")).not_to have_content("2/2")
    expect(page.find("#problems")).to have_content("1")

    expect(page.find("#degree-duration")).not_to have_content "0"
    expect(page.find("#planned_completion")).not_to have_content("No Courses Planned")
    expect(page.find("#quarters-remaining")).not_to have_content(" 0")
    expect(page.find("#problems")).not_to have_content("0")
  end
  scenario "as a user without taken and planned courses" do
    signin_user(user)
    visit plan_path(plan)

    expect(page.find("#required-courses-count")).to have_content "0/9"
    expect(page.find("#distribution-courses-count")).to have_content("0/4")
    expect(page.find("#free-elective-courses-count")).to have_content("0/2")
    expect(page.find("#problems")).to have_content("0")

    expect(page).to have_title(full_title(plan.name))
    expect(page).to have_css("h1", "#{ plan.name }")
    expect(page.find("#degree-duration")).not_to have_content "N/A"
    expect(page.find("#planned-completion")).to have_content("No Courses Planned")
    expect(page.find("#quarters-remaining")).to have_content("0")
    expect(page.find("#problems")).to have_content("0")
  end
  scenario "as a user with completed degree" do
    create_list :taken_course, 9, :required, user: user
    create_list :taken_course, 4, :distribution, user: user
    create_list :taken_course, 2, :free_elective, user: user
    signin_user(user)
    visit plan_path(plan)

    expect(page.find("#required-courses-count")).to have_content "9/9"
    expect(page.find("#distribution-courses-count")).to have_content("4/4")
    expect(page.find("#free-elective-courses-count")).to have_content("2/2")
    expect(page.find("#problems")).to have_content("0")

    expect(page).to have_title(full_title(plan.name))
    expect(page).to have_css("h1", "#{ plan.name }")
    expect(page.find("#degree-duration")).not_to have_content "N/A"
    expect(page.find("#planned-completion")).not_to have_content("No Courses Planned")
    expect(page.find("#quarters-remaining")).to have_content("0")
    expect(page.find("#problems")).to have_content("0")
  end
end
