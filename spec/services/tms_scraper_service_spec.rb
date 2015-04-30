describe TMSScraperService do
  let(:course) do
    create :course, level: "530", description: "a silly description"
  end
  let(:other_course) do
    create :course, level: "605", description: "other silly description"
  end

  describe "#update_course_with_scraped_data" do
    it "updates the course description" do
      expect { subject.update_all_courses_with_scraped_data }
        .to change { course.reload.description }
    end
  end

  describe "#update_all_courses_with_scraped_data" do
    it "updates the course descriptions" do
      old_description = course.description
      other_old_description = other_course.description
      subject.update_all_courses_with_scraped_data
      expect(course.reload.description).not_to eq old_description
      expect(other_course.reload.description).not_to eq other_old_description
    end
  end
end
