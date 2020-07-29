class Review < ActiveRecord::Base
    belongs_to :ice_cream, foreign_key: :icecream_id
    belongs_to :user
end