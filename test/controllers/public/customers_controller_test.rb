require "test_helper"

class Public::CustomersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get public_customers_show_url
    assert_response :success
  end

  test "should get edit" do
    get public_customers_edit_url
    assert_response :success
  end

  test "should get check" do
    get public_customers_check_url
    assert_response :success
  end

  test "should get reject_customers" do
    get public_customers_reject_customers_url
    assert_response :success
  end
end
