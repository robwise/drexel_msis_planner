describe RequisiteParser do
  let(:requisite) { create :prerequisite }
  let(:passing_history) { Course.all }
  let(:course1) { create :course }
  let(:course2) { create :course }
  let(:failing_history) { Course.where(department: "") }

  before do
    requisite.raw_text = "#{course1.full_id} Minimum Grade: C"
  end

  describe "fulfilled?" do
    it "is true if course exists in history" do
      parser = described_class.new(passing_history, requisite)
      expect(parser.fulfilled?).to eq true
    end
    it "is false if course does not exist in history" do
      parser = described_class.new(failing_history, requisite)
      expect(parser.fulfilled?).to eq false
    end
    context "when requisite has 'and' term" do
      before do
        requisite.raw_text = "#{build_raw_text(course1)} and " \
          "#{build_raw_text(course2)}"
      end

      it "is true if both courses exist in history" do
        parser = described_class.new(passing_history, requisite)
        expect(parser.fulfilled?).to eq(true)
      end
    end
    context "when requisite has 'or' term" do
      before do
        requisite.raw_text = "#{build_raw_text(course1)} or " \
          "#{build_raw_text(course2)}"
      end

      it "is true if one of the courses exists in history" do
        parser =  described_class.new(passing_history, requisite)
        expect(parser.fulfilled?).to eq(true)
      end
    end
    context "when requisite has terms in parentheses" do
      before do
        requisite.raw_text = "#{build_raw_text(course1)} and (BLAH 999 Minimum"\
          " Grade: C or #{build_raw_text(course2)})"
      end

      it "is properly parses grouped expressions" do
        parser = described_class.new(passing_history, requisite)
        expect(parser.fulfilled?).to eq(true)
      end
    end
  end

  private

  def build_raw_text(course)
    "#{course.department} #{course.level} Minimum Grade: C"
  end
end
