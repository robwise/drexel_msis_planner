shared_examples_for "an object with a quarter code" do
  subject { model_with_quarter }

  describe "valid codes" do
    it "should cause it to be valid" do
      good_quarters = [201515, 201525, 201535, 201545, 198115, 199025, 202415]
      good_quarters.each do |good_quarter|
        subject.quarter = good_quarter
        expect(subject).to be_valid
      end
    end
  end
  describe "invalid codes" do
    it "should be cause it to be invalid" do
      bad_quarters = [190015, 201416, 20145, 2014159, 201460, 2014, 201400]
      bad_quarters.each do |bad_quarter|
        subject.quarter = bad_quarter
        expect(subject).not_to be_valid
      end
    end
  end
end

