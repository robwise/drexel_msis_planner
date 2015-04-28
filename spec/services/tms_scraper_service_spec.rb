describe TMSScraperService do

  let!(:course) do
    create :course, level: "530", description: "a silly description"
  end

  describe "#update_course_with_scraped_data" do
    it "updates the course description" do
      old_description = course.description
      expect(course.level).not_to be_nil
      subject.update_course_with_scraped_data(course.level)
      expect(course.reload.description).not_to eq old_description
    end
  end
end
