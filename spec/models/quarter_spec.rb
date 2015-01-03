describe Quarter do
  subject { quarter }

  let(:quarter)         { Quarter.new(201415) }
  let(:earlier_quarter) { Quarter.new(quarter.code - 5000) }
  let(:later_quarter)   { Quarter.new(quarter.code + 5000) }

  it { should respond_to(:valid?) }
  it { should respond_to(:code) }
  it { should respond_to(:between?) }
  it { should respond_to(:humanize) }
  it { should respond_to(:season) }
  it { should respond_to(:season_code) }
  it { should respond_to(:year) }
  it { should respond_to(:to_date) }

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
  describe "#season" do
    it "should return the season" do
      expect(quarter.season).to eq(:fall)
    end
  end
  describe "#season=(new_season)" do
    context "with a valid season" do
      it "should properly update the quarter code" do
        quarter.season = "fall"
        expect(quarter.season).to eq(:fall)
      end
    end
    context "with an invalid season" do
      it "should raise an ArgumentError" do
        expect { quarter.season = "nonsense" }
          .to raise_error(ArgumentError, "Season: 'nonsense' is not valid")
      end
    end
  end
  describe "#season_code" do
    it "should return the code" do
      expect(quarter.season_code).to eq(15)
    end
  end
  describe "#humanize" do
    it "should return the humanized form of the code" do
      expect(quarter.humanize).to eq("Fall 2014")
    end
  end
  describe "#to_date" do
    it "should return a date within the season and year of the quarter" do
      expect(quarter.to_date).to eq(Date.new(2014, 9))
    end
  end

end