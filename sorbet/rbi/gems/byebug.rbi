# This file is autogenerated. Do not edit it by hand. Regenerate it with:
#   srb rbi gems

# typed: strong
#
# If you would like to make changes to this file, great! Please create the gem's shim here:
#
#   https://github.com/sorbet/sorbet-typed/new/master?filename=lib/byebug/all/byebug.rbi
#
# byebug-11.0.1
module Byebug
  def self.attach; end
  def self.spawn(host = nil, port = nil); end
end
module Kernel
  def byebug; end
  def debugger; end
  def remote_byebug(host = nil, port = nil); end
end
