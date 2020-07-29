class User < ActiveRecord::Base
    has_many :reviews
    has_many :ice_creams, through: :reviews
end