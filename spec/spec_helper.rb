require_relative "../game"
require_relative "../board"
require "yaml"

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    #c.syntax = :expect             # disables `should`
    # or
    #c.syntax = :should             # disables `expect`
    # or
    c.syntax = [:should, :expect]  # default, enables both `should` and `expect`
  end
end