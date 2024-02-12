
FactoryBot.define do
  factory :article do
    title {"titolo articolo"}
    body {"testo articolo italiano"}
    status {"public"}
    language {"it"}
    author { create(:author) }
  end
end
