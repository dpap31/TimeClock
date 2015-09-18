APP_ROOT = File.dirname(__FILE__)
$:.unshift(File.join(APP_ROOT, 'lib'))

require 'timeclock'
require 'csv'
require 'time'

TimeClock.new('out')
