shared_examples_for "an object with a quarter code" do
  subject { model_with_quarter }

  describe "valid examples" do
    before { subject.quarter = 201415 }

    it "should be valid" do
      expect(subject).to be_valid
    end
  end
  describe "invalid examples" do
    it "should be invalid" do
      bad_quarters = [190015, 201416, 20145, 2014159, 201460, 2014,
                   201400]
      bad_quarters.each do |bad_quarter|
        subject.quarter = bad_quarter
        expect(subject).not_to be_valid
      end
    end
  end
end

