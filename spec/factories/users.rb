# == Schema Information
#
# Table name: users
#
#  confirmation_sent_at   :datetime
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  created_at             :datetime
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :inet
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  id                     :integer          not null, primary key
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :inet
#  name                   :string(255)
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string(255)
#  role                   :integer
#  sign_in_count          :integer          default(0), not null
#  unconfirmed_email      :string(255)
#  updated_at             :datetime
#

FactoryGirl.define do
  factory :user do
    confirmed_at Time.now
    sequence(:email) { |n| "test_user#{n}@example.com" }
    password "please123"

    trait :admin do
      role 'admin'
    end

  end
end
