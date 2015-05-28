FactoryGirl.define do
  factory :quarter do
    quarter { Time.current.year * 100 + 15 }
    initialize_with { new(quarter) }

    factory :past_quarter do
      quarter { Quarter.current_quarter.previous_quarter }
      initialize_with { new(quarter) }
    end
    factory :future_quarter do
      quarter { Quarter.current_quarter.next_quarter }
      initialize_with { new(quarter) }
    end
    factory :current_quarter do
      quarter { Quarter.current_quarter }
      initialize_with { new(quarter) }
    end
  end
end
