APP_ROOT = File.dirname(__FILE__)
$LOAD_PATH.unshift(File.join(APP_ROOT, 'lib'))

require_relative '../lib/punches'
require_relative '../lib/timeclock'

require 'yaml'
