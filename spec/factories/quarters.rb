FactoryGirl.define do
  factory :quarter do
    quarter { Time.current.year * 100 + 15 }
    initialize_with { new(quarter) }

    factory :past_quarter do
      quarter { (Time.current.year - 1) * 100 + 15 }
      initialize_with { new(quarter) }
    end
    factory :future_quarter do
      quarter { (Time.current.year + 1) * 100 + 15 }
      initialize_with { new(quarter) }
    end
  end
end
