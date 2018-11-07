FactoryBot.define do
  factory :user do
    username {"MacInnes"}
    email {"test@test.com"}
    password {"password"}
    role {"driver"}
    destination {"1331 17th Street, Denver, CO 80202"}
  end
end
