FactoryBot.define do
  factory :author do
    name {"Nome autore"}
    surname {"Cognome autore"}
  end

  factory :author_no_surname do
    name {"Nome autore"}
  end
end
