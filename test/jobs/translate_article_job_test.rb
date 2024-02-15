require "test_helper"

class TranslateArticleJobTest < ActiveJob::TestCase

  test 'enque' do
    a = FactoryBot.build(:article)

    assert_enqueued_jobs 1 do
      a.save
    end
  end
end
