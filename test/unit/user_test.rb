require 'test_helper'

module Afo
  class UserTest < MiniTest::Unit::TestCase

    def test_to_initial
      u = ::FactoryGirl.create(:user)
      assert_equal "A.", u.to_initial
    end

  end
end