require 'csv'
require 'time'

APP_ROOT = File.dirname(__FILE__)

require_relative 'lib/punches'
require_relative 'lib/timeclock'


args = ARGV.pop.split(' ')

params = {}
params[:action] = args.first.downcase.to_sym
params[:note] = args[1..-1].join(' ')

def action_valid?(symbol = '')
  whitelist = %w(in out last open divider)
  whitelist.include?(symbol.to_s)
end

if action_valid?(params[:action])
  TimeClock.new(params).launch!
else
  error_txt = "Invalid action. Use 'in, 'out', 'last' or 'open'."
  system %( echo "#{error_txt}" )
end

