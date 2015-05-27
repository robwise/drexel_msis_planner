describe Quarter do
  subject { quarter }

  let(:quarter) { build :quarter }
  let(:past_quarter) { build :past_quarter }
  let(:future_quarter) { build :future_quarter }

  it { should respond_to(:code) }
  it { should respond_to(:between?) }
  it { should respond_to(:humanize) }
  it { should respond_to(:season) }
  it { should respond_to(:season_code) }
  it { should respond_to(:year) }
  it { should respond_to(:to_date) }
  it { should respond_to(:future?) }
  it { should respond_to(:past?) }
  it { should respond_to(:next_quarter) }
  it { should respond_to(:previous_quarter) }
  it { should respond_to(:-) }
  it { should respond_to(:quarter_rank) }

  context "when initialized with a valid code" do
    let(:good_codes) do
      [201515, 201525, 201535, 201545, 198115, 199025, 202415]
    end
    it "is valid" do
      good_codes.each do |good_code|
        expect { described_class.new(good_code) }.not_to raise_exception
      end
    end
  end
  context "when initialized with another quarter" do
    let(:argument) { described_class.new(201515) }
    it "is vaild" do
      expect { described_class.new(argument) }.not_to raise_exception
    end
  end
  describe "invalid examples" do
    it "raise an exception" do
      bad_codes = [190015, 201416, 20145, 2014159, 201460, 2014, 201400]
      bad_codes.each do |bad_code|
        expect { described_class.new(bad_code) }.to raise_exception
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
        expect(quarter).to be > past_quarter
      end
    end
    context "to a quarter with a later code" do
      it "is lesser" do
        expect(quarter).to be < future_quarter
      end
    end
    context "is between two quarters with large and small codes" do
      it "#between is true" do
        expect(quarter.between?(past_quarter, future_quarter)).to eq(true)
      end
    end
  end
  describe "#season" do
    it "return the season" do
      expect(quarter.season).to eq(:fall)
    end
  end
  describe "#season_code" do
    it "return the code" do
      expect(quarter.season_code).to eq(15)
    end
  end
  describe "#humanize" do
    let(:quarter) { build :quarter, quarter: 201415 }
    it "return the humanized form of the code" do
      expect(quarter.humanize).to eq("Fall 2014")
    end
  end
  describe "#to_date" do
    context "with a code of 201415" do
      let(:quarter) { build :quarter, quarter: 201415 }
      it "returns a date equivalent to 09/2014" do
        expect(quarter.to_date).to eq(Date.new(2014, 9))
      end
    end
    context "with a code of 201425" do
      let(:quarter) { build :quarter, quarter: 201425 }
      it "returns a date equivalent to 01/2015" do
        expect(quarter.to_date).to eq(Date.new(2015, 1))
      end
    end
    context "with a code of 20135" do
      let(:quarter) { build :quarter, quarter: 201435 }
      it "returns a date equivalent to 04/2015" do
        expect(quarter.to_date).to eq(Date.new(2015, 4))
      end
    end
    context "with a code of 201445" do
      let(:quarter) { build :quarter, quarter: 201445 }
      it "returns a date equivalent to 06/2015" do
        expect(quarter.to_date).to eq(Date.new(2015, 6))
      end
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
  describe "#next_quarter" do
    it "returns the next quarter" do
      quarter = build :quarter, quarter: 201545
      expect(quarter.next_quarter.code).to eq 201615
    end
  end
  describe "#previous_quarter" do
    it "returns the previous quarter" do
      quarter = build :quarter, quarter: 201515
      expect(quarter.previous_quarter.code).to eq 201445
    end
  end
  describe ".from" do
    let!(:first) { build :quarter, quarter: 201345 }
    let!(:last) { build :quarter, quarter: 201515 }
    it "returns all dates between first and last quarter (inclusive)" do
      expected = [described_class.new(201345),
                  described_class.new(201415),
                  described_class.new(201425),
                  described_class.new(201435),
                  described_class.new(201445),
                  described_class.new(201515)]
      actual = described_class.from(first: first, last: last)
      (0..expected.length).each do |i|
        expect(actual[i]).to eq expected[i]
      end
    end
  end
  describe ".current_quarter" do
    it "returns the current quarter" do
      code = Time.current.year * 100 + (Time.current.month / 4).ceil * 15
      current_quarter = described_class.new(code)
      expect(described_class.current_quarter).to eq(current_quarter)
    end
  end
  describe ".num_quarters_between" do
    context "with a start of 201515 and finish of 201525" do
      let(:start) { 201425 }
      let(:finish) { 201615 }
      it "returns 7" do
        expect(described_class.num_quarters_between(start, finish)).to eq 7
      end
    end
  end
  describe "#-" do
    subject(:subject) { described_class.new(201615) }
    it "returns the number of quarters between it and the operand" do
      expect(subject - 201525).to eq 3
    end
  end
  describe "#quarter_rank" do
    it "is 1 for a quarter ending in 15" do
      quarter = described_class.new(201615)
      expect(quarter.quarter_rank).to eq 1
    end
    it "is 2 for a quarter ending in 15" do
      quarter = described_class.new(201625)
      expect(quarter.quarter_rank).to eq 2
    end
    it "is 3 for a quarter ending in 15" do
      quarter = described_class.new(201635)
      expect(quarter.quarter_rank).to eq 3
    end
    it "is 4 for a quarter ending in 15" do
      quarter = described_class.new(201645)
      expect(quarter.quarter_rank).to eq 4
    end
  end
end
