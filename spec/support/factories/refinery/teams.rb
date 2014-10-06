
FactoryGirl.define do
  factory :team, :class => Refinery::Teams::Team do
    sequence(:fullname) { |n| "refinery#{n}" }
  end
end

