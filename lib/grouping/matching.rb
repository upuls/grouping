module Grouping
  module Matching
    def self.get_matching(matching_type:)
      Grouping::Matching.const_get(matching_type)
    end
  end
end
