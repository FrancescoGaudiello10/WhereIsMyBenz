require 'test_helper'

class ReviewTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = users(:iBuso)
    @item = items(:iPhone)
    # This code is not idiomatically correct.
    @review = Review.new(comment: "AWESOME!", price: 27,99, rating: 5, store: "MyStore", user_id: @user.id, item_id: @item.id)
  end
  
  test "should be valid" do
    assert @review.valid?
  end

  test "user id should be present" do
    @review.user_id = nil
    assert_not @review.valid?
  end
end
