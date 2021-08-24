require "test_helper"

class SlackNotifierJobTest < ActiveJob::TestCase
  test "it notifies slack when a request comes in" do
    assert_enqueued_jobs 1, only: SlackNotifierJob do
      WhitelistRequest.create(
        user: users(:one), agree_rules: true, referred_by: "king"
      )
    end
  end

  # test "it pings slack when it is enqueued" do
  #   perform_enqueued_jobs do
  #     VCR.use_cassette("jobs/slack_notifier/ping") do
  #       assert_nothing_raised do
  #         WhitelistRequest.create(
  #           user: users(:one), agree_rules: true, referred_by: "king"
  #         )
  #       end
  #     end
  #   end
  # end
end
