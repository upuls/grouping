require "grouping/version"

Dir.glob(File.join(__dir__, '**/*.rb')).each { |f| require f }

module Grouping
  class Error < StandardError; end
end
