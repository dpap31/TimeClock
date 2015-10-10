require 'csv'
require 'time'

APP_ROOT = File.dirname(__FILE__)
require_relative 'lib/punches'
require_relative 'lib/timeclock'

params = {}
params[:action] = ARGV.shift
params[:note] = ARGV.join(' ')

TimeClock.new(params).launch!
