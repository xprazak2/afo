ENV['RACK_ENV'] = 'test'
require "minitest/autorun"
require 'minitest/unit'
require 'mocha/mini_test'

$: << File.join(File.dirname(__FILE__), '..', 'lib')

require "afo_testing"
require 'rack/test'
require 'factory_girl_init'
require 'factories'

