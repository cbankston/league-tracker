require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = File.join('spec', 'fixtures', 'vcr_cassettes')
  config.hook_into :webmock
  config.configure_rspec_metadata!

  config.filter_sensitive_data('<API_KEY>') do
    LolApi::Base.api_key
  end
end
