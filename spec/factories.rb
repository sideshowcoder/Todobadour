FactoryGirl.define do

  factory :list do
    title "Shopping for BBQ"
    description "Get everything for out great BBQ tonight"
    slug "bbq"
  end
  
  factory :todo do
    title "BBQ Sauce"
    done false
    association :list
  end
  
end