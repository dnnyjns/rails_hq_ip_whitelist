class User
  attr_accessor :ip_whitelist

  def initialize(ip_whitelist: [])
    self.ip_whitelist = ip_whitelist
  end
end
