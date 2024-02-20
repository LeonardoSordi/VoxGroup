FactoryBot.define do
  factory :author do
    name {"Nome autore"}
    surname {"Cognome autore"}
    mailaddress {"test@test.org"}
  end

  factory :author_no_surname do
    name {"Nome autore"}
    mailaddress {"test@test.org"}
  end
end
