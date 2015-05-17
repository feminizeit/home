require 'sinatra/base'
$stdout.sync  = true
$logger       = Logger.new(STDOUT)
$logger.level = Logger.const_get ENV['LOG_LEVEL'] || 'DEBUG'

require './app'
run Feminizeit::Application
