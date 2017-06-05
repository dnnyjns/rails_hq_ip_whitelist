require 'test_helper'

class IPWhitelistTest < ActionDispatch::IntegrationTest
  test "Blocks all IPs except whitelist if a whitelist exists" do
    ::ApplicationController.class_eval do
      def current_user
        User.new(ip_whitelist: ["1.2.3.4"])
      end
    end

    get "/", { headers: { "REMOTE_ADDR": "4.3.2.1"} }
    assert_equal 500, status
  end

  test "Allow IPs in the whitelist" do

    ::ApplicationController.class_eval do
      def current_user
        User.new(ip_whitelist: ["1.2.3.4"])
      end
    end

    get "/", { headers: { "REMOTE_ADDR": "1.2.3.4"} }
    assert_equal 200, status
  end

  test "Allow all IPs if a whitelist does not exist" do

    ::ApplicationController.class_eval do
      def current_user
        User.new(ip_whitelist: nil)
      end
    end

    get "/", { headers: { "REMOTE_ADDR": "1.2.3.4"} }
    assert_equal 200, status
  end
end
