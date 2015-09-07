require 'test_helper'

module Afo
  class ComicTest < MiniTest::Unit::TestCase
    
    def setup
      @user = FactoryGirl.create(:user)
      @comics = []
      8.times do
        @comics << FactoryGirl.create(:comic, :user => @user)
      end
    end

    def test_next
      c = @comics[4]
      cc = c.next
      assert_equal @comics[5].id, cc.id
    end

    def test_next_on_last
      c = @comics[7]
      cc = c.next
      assert_nil cc
    end

    def test_previous
      c = @comics[4]
      cc = c.previous
      assert_equal @comics[3].id, cc.id
    end

    def test_previous_on_first
      c = @comics[0]
      cc = c.previous
      assert_nil cc
    end
  end
end