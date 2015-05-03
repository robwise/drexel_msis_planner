module ModelSpecsHelpers
  module BehaviorHelpers
    shared_examples_for "a delegator to its associated course" do
      it { should delegate_method(:full_id).to(:course) }
      it { should delegate_method(:level).to(:course) }
      it { should delegate_method(:department).to(:course) }
      it { should delegate_method(:title).to(:course) }
      it { should delegate_method(:description).to(:course) }
      it { should delegate_method(:prerequisite).to(:course) }
    end

    shared_examples_for "an object with a quarter" do
      it "is not valid" do
        bad_quarters = [190015, 201416, 20145, 201520, 201460, 2014, 201400]
        bad_quarters.each do |bad_quarter|
          subject.quarter = bad_quarter
          expect(subject).not_to be_valid
        end
      end
    end
  end
  module GeneralHelpers
    # Builds a requisite text string like we'd see from actual TMS Scraper
    # data inidicating a requisite for the indicated course. Accepts an object
    # responding to the #full_id method or just the department and level values
    def requisite_for(*args)
      postfix_text = " Minimum Grade: C"
      return args[0].full_id + postfix_text if args[0].respond_to?(:full_id)
      department = args[0]
      level = args[1]
      "#{ department } #{ level } Minimum Grade: C"
    end
  end
end
