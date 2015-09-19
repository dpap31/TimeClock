APP_ROOT = File.dirname(__FILE__)
$LOAD_PATH.unshift(File.join(APP_ROOT, 'lib'))

require 'timeclock'
require 'csv'
require 'time'

params = {}
params[:action] = ARGV.shift
params[:note] = ARGV.join(' ')

TimeClock.new(params)
