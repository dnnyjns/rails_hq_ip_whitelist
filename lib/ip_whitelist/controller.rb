# typed: false
# frozen_string_literal: true

module IPWhitelist
  module Controller
    def check_ip_whitelist
      if current_user && current_user.respond_to?(:ip_whitelist) && current_user.ip_whitelist.present?
        # Since requests can come through cloudflare, try that IP first.
        ip = IPAddr.new(request.headers["CF-Connecting-IP"] || request.remote_ip)

        return if current_user.ip_whitelist.detect  do |ip_or_range|
          # Check if the IP is equal to the whitelisted IP, or is within the
          # whitelisted IP range.
          (ip_or_range.is_a?(IPAddr) ? ip_or_range : IPAddr.new(ip_or_range)) === ip
        end

        Rails.logger.info("#{current_user.username}'s IP (#{ip}) is not in authorized list (#{current_user.ip_whitelist.join(", ")})")

        if (redirect = IPWhitelist.redirect)
          redirect_to redirect
        else
          render plain: "Not Authorized", status: :unauthorized
        end
      end
    end
  end
end
