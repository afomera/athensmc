module VcrHelper
  require "vcr"

  VCR.configure do |config|
    config.cassette_library_dir = "test/vcr_cassettes"
    config.hook_into :webmock

    config.ignore_localhost = true
    config.debug_logger = File.open(Rails.root.join("log", "vcr.log"), "w")

    %w[SLACK_TOKEN].each do |var|
      config.filter_sensitive_data("<#{var}>") { ENV[var] }
    end
  end
end
