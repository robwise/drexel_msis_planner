require_relative './shared/shared_examples_for_quarter_validator'
describe PlannedCourse do
  it { should respond_to(:created_at) }
  it { should respond_to(:updated_at) }
  it { should respond_to(:course) }
  it { should respond_to(:course_id) }
  it { should respond_to(:plan) }
  it { should respond_to(:plan_id) }
  it { should respond_to(:quarter) }
  it { should validate_presence_of(:plan) }
  it { should validate_presence_of(:course) }
  it_should_behave_like "an object with a quarter code" do
    let(:model_with_quarter) { build(:planned_course) }
  end
end
