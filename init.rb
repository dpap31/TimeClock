APP_ROOT = File.dirname(__FILE__)
$LOAD_PATH.unshift(File.join(APP_ROOT, 'lib'))

require 'timeclock'
require 'csv'
require 'time'

ACTION = ARGV.shift
QUERY = ARGV.join(' ')
TimeClock.new(ACTION, QUERY)
