FactoryBot.define do

  factory :comment do
    body {"body commento"}
    status {"public"}
    article {create {:article}}
  end

end