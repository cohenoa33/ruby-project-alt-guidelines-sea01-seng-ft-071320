class User < ActiveRecord::Base
    has_many :icecreams, through: :reviews
    has_many :reviews
end