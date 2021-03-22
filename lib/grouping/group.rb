require 'csv'
require 'digest'


module Grouping

  class Group

    def call(input_file:, matching_type:)

      # matching_type = Grouping::Matching::Email
      input_basename = File.basename(input_file)
      output_basename = input_basename.sub(/\./, '_output.')
      output_filename = input_file.sub(input_basename, output_basename)

      matching = Grouping::Matching.get_matching(matching_type: matching_type)
      grouping = do_grouping(input_file: input_file, matching: matching)
      write_output(input_file: input_file, output_file: output_filename, matching: matching, grouping: grouping)

    end # call


    def do_grouping(input_file:, matching:)

      identifiers = Hash.new
      row_idx = 0

      CSV.foreach(input_file, unconverted_fields: true, return_headers: false) do |row|

        matching.match(input: row.join(',')) do |matches|
          matches.each{|match| identifiers[match] = row_idx }
        end

        row_idx += 1
      end

      identifiers
    end # do_grouping

    def write_output(input_file:, output_file:, matching:, grouping:)

      header= true

      CSV.open(output_file, "w") do |csvout|

        CSV.foreach(input_file, unconverted_fields: true, return_headers: true) do |row|

          (row.unshift('id') && header = false) if header

          matches = matching.match(input: row.join(','))
          row.unshift(grouping[matches[0]]) unless matches.empty?

          csvout << row
        end


      end # csv write
    end # write_output

  end # class Group
end # module Grouping
