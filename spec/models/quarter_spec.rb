describe Quarter do
  subject { quarter }

  let(:quarter)         { Quarter.new(201415) }
  let(:earlier_quarter) { Quarter.new(quarter.code - 5000) }
  let(:later_quarter)   { Quarter.new(quarter.code + 5000) }

  it { should respond_to(:valid?) }
  it { should respond_to(:code) }
  it { should respond_to(:between?) }

  describe "valid examples" do
    it "should be valid" do
      good_codes = [201515, 201525, 201535, 201545, 198115, 199025, 202415]
      good_codes.each do |good_code|
        subject.code = good_code
        expect(subject).to be_valid
      end
    end
  end
  describe "invalid examples" do
    it "should be invalid" do
      bad_codes = [190015, 201416, 20145, 2014159, 201460, 2014, 201400]
      bad_codes.each do |bad_code|
        subject.code = bad_code
        expect(subject).not_to be_valid
      end
    end
  end
  describe "comparing" do
    context "to a quarter with the same code" do
      it "should be equal" do
        expect(quarter).to eq(Quarter.new(quarter.code))
      end
    end
    context "to a quarter with an earlier code" do
      it "should be greater" do
        expect(quarter).to be > earlier_quarter
      end
    end
    context "to a quarter with a later code" do
      it "should be lesser" do
        expect(quarter).to be < later_quarter
      end
    end
    it "should be between two quarters with large and small codes" do
      expect(quarter.between?(earlier_quarter, later_quarter)).to eq(true)
    end
  end
end