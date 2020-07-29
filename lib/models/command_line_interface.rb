class CommandLineInterface 

    def greet 
        puts "Hey, what's the scoop? Tell us your name!"
        gets.strip
    end

    def create_new_user(user_input)
        User.find_or_create_by(name: user_input)
    end
 
    def menu(name)
        puts "Hey #{name.name}, tell as what you want:"
        puts "Order - make a new order"  
        puts "Top 5 - for see our top 5"
        puts "Update - to update your review"
        puts "Delete -  to delete your review"
    end

    def get_user_input
        gets.strip
    end
    #ask user to choose a flavor
    def order
        puts "what's your flavor for today?"
        flavor = gets.strip
        puts "which topping to add?"
        topping = gets.strip
        IceCream.find_or_create_by(flavors: flavor, toppings: topping)
    end

    def add_name_to_icecream 
        IceCream.all.each do |icecream|
            if icecream.name == nil
                icecream.name = Faker::Hipster.word
            end
        end
    end
    
    def update_favorite
        puts "Do you want to add this to your favorite?"
        puts "type 'Yes' or 'No'"
        input = gets.strip
        input == "Yes" ? input = true : input = false
        input
    end

    def get_review(name)
        puts "Enjoy! please rate your ice cream (a number between 1-10)"
        rating = gets.strip
        favorite = update_favorite
        Review.create(user_id: name.id, icecream_id: IceCream.last.id, rating: rating.to_i, favorite: favorite)
        puts "Thanks #{name.name}"
    end
    
    # we are trying to get the names of the ice cream and include that in the top_five method
    def all_reviews_greater_than_number
        new = Review.all.each do |review|
            # review.rating >= 7
        end
        result = new.map {|review| review.ice_cream.id}.uniq
        # binding.pry
        puts result
    end 

    def top_five
        # binding.pry
        Review.all.order(rating: :desc).distinct
        all_reviews_greater_than_number
    end
        
    
    def find_review(name)
        users_review = Review.where(user_id: name.id)
        ice_cream_name = users_review.collect {|review| review.ice_cream.name}
        puts "please enter the icecream name for the review"
        puts ice_cream_name
        input = gets.strip
        icecream = IceCream.all.find_by(name: input)
        review = Review.where(user_id: name.id,icecream_id: icecream.id)
        review
    end
    
    def changed_my_mined(name, review)
        puts "new rating?"
        new_rating = gets.strip
        review.update({rating:new_rating})
        puts "we got ya #{name.name}"
    end
    def delete_review(review)
        review.destroy_all
        puts "We deleted your review"
    end
    
    # def icecream_list_with_average_rating
    
    #     Review.all.map {|review| [:icecream_id] = review.rating} 
    
    #     # Review.all.map {|review| hash[:icecream_id] => [:rating}
    #     # Review.all.map do |review|
    #     #     review.icecream_id
    #     # end
    #     Review.all.map do |review| 
    #         review.sum(:rating)
    #     end
    
    # end
    
    def icecream_list_with_average_rating
        
        rating_count = Review.group(:rating).count
        
        average_rating = rating_count.collect do |key, value|
            (key * value) / value
        end
        binding.pry
        ice_cream_count = Review.group(:icecream_id).count
        ice_cream_count 
    end 
    
    
    #READ :user can see all the other user's review,
    #array with Icecreams name
    
    #UPDATE:user can update favorites and rating 
    
    # def update_ice_cream_name(flavor, topping, new_name)
    #     # icecream = find_ice_cream
    #     icecream.update(name:new_name)
    #     icecream.save
    # end
    
    
    #user can see the ice cream with the highest ratings
    #user can see all his favorites  icecreams
    
    #     #READ: find the ice_cream_id so we can look for reviews for this id
    #     def find_ice_cream(flavor, topping)
    #         icecream = IceCream.find(flavors: flavor, toppings: topping)
    #         icecream.id
    #     end
    #     # READ: find the user_id so we can look for all the favorite icecreams for this user
    #     #array of icecreams names
    #     def find_user_id(name)
    #         user = User.all.find_by(name: name)
    #         binding.pry
    #         user.id
    #     end
    
    #     def update_review(name)
    #         user =  User.all.find_by(name: name)
    #         ice_cream = find_ice_cream
    
    #     end
    
    #     # def find_all_favorites
    #     #     Review.where(favorite: true).find_each  |review|
    #     # end
    
end