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
    factory :current_quarter do
      quarter { (Time.current.year * 100 + (Time.current.month / 4).ceil * 15) }
    end
  end
end
