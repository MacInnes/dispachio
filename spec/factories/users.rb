FactoryBot.define do
  factory :user do
    username {"MacInnes"}
    email {"test@test.com"}
    password {"password"}
    role {1}
  end
end
