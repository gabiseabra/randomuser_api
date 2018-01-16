FactoryBot.define do
  factory :user, class: User do
    title 'mr.'
    name 'John Doe'
    email 'john.doe@example.com'
    phone '999-999'
    cel '999-999'    
  end
end