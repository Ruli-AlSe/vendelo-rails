require "test_helper"

class FetchCountryServiceTest < ActiveSupport::TestCase
  test "it should return ca with ip = 24.48.0.1" do
    stub_request(:get, "http://ip-api.com/json/24.48.0.1").
      to_return(status: 200, body: {
        status: "success",
        countryCode: "CA"
      }.to_json, headers: {})

    assert_equal "ca", FetchCountryService.new("24.48.0.1").perform
  end

  test "it should return nil with and invalid ip" do
    stub_request(:get, "http://ip-api.com/json/fakeip").
      to_return(status: 200, body: {
        status: "fail"
      }.to_json, headers: {})

    assert_nil(FetchCountryService.new("fakeip").perform)
  end
end
