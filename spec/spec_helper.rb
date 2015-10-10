APP_ROOT = File.dirname(__FILE__)
require_relative '../lib/punches'
require_relative '../lib/timeclock'

require 'csv'
require 'time'
require 'yaml'
require 'fileutils'

RSpec.configure do |config|
  def rm_punches_csv
    FileUtils.rm("#{APP_ROOT}/punches.csv")
  end

  config.after(:suite) do
    rm_punches_csv
  end
end
