require 'factory_girl'
require 'database_cleaner'

class MiniTest::Unit::TestCase
  include FactoryGirl::Syntax::Methods

  DatabaseCleaner.strategy = :truncation
  
  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end 
end