class CreateIcecreamReviewJoinTable < ActiveRecord::Migration[5.2]
  def change
    Review.left_outer_joins(:ice_creams)
  end
end



