require "application_system_test_case"

class DonationsTest < ApplicationSystemTestCase
  setup do
    @donation = donations(:one)
  end

  test "visiting the index" do
    visit donations_url
    assert_selector "h1", text: "Donations"
  end

  test "creating a Donation" do
    visit donations_url
    click_on "New Donation"

    fill_in "Payment status", with: @donation.payment_status
    fill_in "Project", with: @donation.project_id
    fill_in "User", with: @donation.user_id
    fill_in "Value", with: @donation.value
    click_on "Create Donation"

    assert_text "Donation was successfully created"
    click_on "Back"
  end

  test "updating a Donation" do
    visit donations_url
    click_on "Edit", match: :first

    fill_in "Payment status", with: @donation.payment_status
    fill_in "Project", with: @donation.project_id
    fill_in "User", with: @donation.user_id
    fill_in "Value", with: @donation.value
    click_on "Update Donation"

    assert_text "Donation was successfully updated"
    click_on "Back"
  end

  test "destroying a Donation" do
    visit donations_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Donation was successfully destroyed"
  end
end
