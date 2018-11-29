FactoryBot.define do
  factory :user do
    username {"MacInnes"}
    email {"test@test.com"}
    password {"password"}
    role {"driver"}
    destination {"1331 17th Street, Denver, CO 80202"}
    lat {'123.123'}
    long {'-123.123'}
  end
end
