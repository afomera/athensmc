require "test_helper"

class CastTest < ActiveSupport::TestCase
  test "should not save cast without episode" do
    cast = Cast.new
    assert_not cast.save, "Saved the cast without an episode"
  end

  test "should not save cast without releasedate" do
    cast2 = Cast.new
    assert_not cast2.save, "Saved the cast without a releasedate"
  end

  test "should not save cast without description" do
    cast3 = Cast.new
    assert_not cast3.save, "Saved the cast without a description"
  end

  test "should not save cast without embedcode" do
    cast4 = Cast.new
    assert_not cast4.save, "Saved the cast without embedcode"
  end
end
