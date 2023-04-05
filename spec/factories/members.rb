FactoryBot.define do
  factory :member do
    first_name { 'John' }
    last_name  { 'Doe' }
    country { 'US' }
    state { 'Ohio' }
    city { 'Kent' }
    team
  end
end 