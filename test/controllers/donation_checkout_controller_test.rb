require 'test_helper'

class DonationCheckoutControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get donation_checkout_show_url
    assert_response :success
  end

end
