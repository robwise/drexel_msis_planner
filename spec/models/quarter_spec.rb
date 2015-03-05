describe Quarter do
  subject { quarter }

  let(:quarter)         { described_class.new(201415) }
  let(:earlier_quarter) { described_class.new(quarter.code - 5000) }
  let(:later_quarter)   { described_class.new(quarter.code + 5000) }

  it { should respond_to(:valid?) }
  it { should respond_to(:code) }
  it { should respond_to(:between?) }
  it { should respond_to(:humanize) }
  it { should respond_to(:season) }
  it { should respond_to(:season_code) }
  it { should respond_to(:year) }
  it { should respond_to(:to_date) }
  it { should respond_to(:future?) }
  it { should respond_to(:past?) }

  describe "valid examples" do
    it "is valid" do
      good_codes = [201515, 201525, 201535, 201545, 198115, 199025, 202415]
      good_codes.each do |good_code|
        subject.code = good_code
        expect(subject).to be_valid
      end
    end
  end
  describe "invalid examples" do
    it "is invalid" do
      bad_codes = [190015, 201416, 20145, 2014159, 201460, 2014, 201400]
      bad_codes.each do |bad_code|
        subject.code = bad_code
        expect(subject).not_to be_valid
      end
    end
  end
  describe "comparing" do
    context "to a quarter with the same code" do
      it "is equal" do
        expect(quarter).to eq(described_class.new(quarter.code))
      end
    end
    context "to a quarter with an earlier code" do
      it "is greater" do
        expect(quarter).to be > earlier_quarter
      end
    end
    context "to a quarter with a later code" do
      it "is lesser" do
        expect(quarter).to be < later_quarter
      end
    end
    context "is between two quarters with large and small codes" do
      it "#between is true" do
        expect(quarter.between?(earlier_quarter, later_quarter)).to eq(true)
      end
    end
  end
  describe "#season" do
    it "return the season" do
      expect(quarter.season).to eq(:fall)
    end
  end
  describe "#season=(new_season)" do
    context "with a valid season" do
      it "properly update the quarter code" do
        quarter.season = "fall"
        expect(quarter.season).to eq(:fall)
      end
    end
    context "with an invalid season" do
      it "raise an ArgumentError" do
        expect { quarter.season = "nonsense" }
          .to raise_error(ArgumentError, "Season: 'nonsense' is not valid")
      end
    end
  end
  describe "#season_code" do
    it "return the code" do
      expect(quarter.season_code).to eq(15)
    end
  end
  describe "#humanize" do
    it "return the humanized form of the code" do
      expect(quarter.humanize).to eq("Fall 2014")
    end
  end
  describe "#to_date" do
    it "return a date within the season and year of the quarter" do
      expect(quarter.to_date).to eq(Date.new(2014, 9))
    end
  end
  describe "#past?" do
    it "returns false if quarter is in future" do
      quarter = build :future_quarter
      expect(quarter.past?).to be false
    end
    it "returns true if quarter is in past" do
      quarter = build :past_quarter
      expect(quarter.past?).to be true
    end
  end
  describe "#future?" do
    it "returns false if quarter is in past" do
      quarter = build :past_quarter
      expect(quarter.future?).to be false
    end
    it "returns true if quarter is in future" do
      quarter = build :future_quarter
      expect(quarter.future?).to be true
    end
  end
end
