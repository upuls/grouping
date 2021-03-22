module Grouping
  module Matching 
    class Phone


      PATTERN = /(?:1-)?\(?\d{3}\)?(?:[\s\.-])?\d{3}[\s.-]?\d{4}/ 

      def self.match(input:)

        matches = input.scan(PATTERN)
        ->{yield matches if block_given?}[] unless matches.empty?

        matches
      end
    end
  end
end
