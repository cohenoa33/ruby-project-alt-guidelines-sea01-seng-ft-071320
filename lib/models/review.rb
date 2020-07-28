class Review < ActiveRecord::Base
    belongs_to :icecream
    belongs_to :user
end