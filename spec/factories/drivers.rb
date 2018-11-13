FactoryBot.define do
  factory :driver do
    username {"MacInnes"}
    email {"test@test.com"}
    password {"password"}
    destination {"1331 17th Street, Denver, CO 80202"}
    lat {'39.750845'}
    long {'-104.996534'}
  end
end
