require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  test "Going to /new gives us a new random grid to play with" do
    visit new_url
    assert_selector "h1", text: "Longest Word Game"
    assert_selector "li", count: 10
  end

  test "Submitting an invalid word shows an error message" do
    visit new_url
    fill_in "word", with: "invalidword"
    click_on "Submit"
    assert_text "can't be built out of the given letters"
  end

  test "Submitting a valid word shows a success message" do
    visit new_url
    fill_in "word", with: "valid"
    click_on "Submit"
    assert_text "is a valid English word"
  end
end
