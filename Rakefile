require "bundler/gem_tasks"
require "rspec/core/rake_task"
require 'grouping'
require "optparse"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec


task :group, [:intpu_file, :matching_type] do |task, args|

  option_parser = OptionParser.new do |opts|
    opts.banner = "usage: rake group FILENAME MATCHING_TYPE=[Email|Phone]"
  end
  input_file = args[:intpu_file] # || "spec/fixtures/data/input2.csv"
  matching_type = args[:matching_type] rescue nil # || 'Email'

  if input_file.empty? || !%w[Email Phone].include?(matching_type)
    ($stderr.puts option_parser.banner; exit(1)) 
  end

  Grouping::Group.new.call(input_file: input_file, matching_type: matching_type)

end
