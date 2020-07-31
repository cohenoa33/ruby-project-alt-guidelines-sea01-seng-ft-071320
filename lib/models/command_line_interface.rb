
class CommandLineInterface

    def greet 
        UserOutputs.greeting
        gets.strip
    end

    def create_new_user(user_input)
        User.find_or_create_by(name: user_input)
    end
 
    def menu(name)
        UserOutputs.menu_list(name)
    end

    def get_user_input
        gets.strip.downcase
    end
    
    def add_name_to_icecream 
        IceCream.all.each do |icecream|
            if icecream.name == nil
                icecream.update({name: Faker::Hipster.word})
            end
        end
    end

    def new_order(name)
        UserOutputs.flavor
        flavor = get_user_input
        is_flavor = IceCream.all.any? {|icecream| icecream.name == flavor}
        ice_cream_name = IceCream.all.first {|icecream| icecream.name == flavor}
        if !is_flavor 
            UserOutputs.topping
            topping = get_user_input
            IceCream.find_or_create_by(flavors: flavor, toppings: topping)
            add_name_to_icecream
            check_same_orders(name, IceCream.last.id)
        else
            check_same_orders(name, ice_cream_name.id)  
        end
    end

    def add_favorite
        UserOutputs.favorite?
        input = get_user_input
        if input == "yes"
            input = true
        elsif input == "no" 
            input = false
        else
            invalid_command
            add_favorite
        end
        input
    end

    def check_same_orders(name, icecream_id)
        if name.reviews.find_by(icecream_id:IceCream.last.id)
            UserOutputs.updated
            rating = get_user_input
            if rating.to_i >= 1 && rating.to_i <= 10
                favorite = add_favorite
                a = name.reviews.find_by(icecream_id:IceCream.last.id)
                a.update(rating: rating.to_i, favorite: favorite)
                UserOutputs.thanks(name)
            else
                invalid_command
                check_same_orders(name)
            end
        else
            get_review(name)
        end
    end

    def get_review(name)
        UserOutputs.rating(name)
        rating = get_user_input
        if rating.to_i >= 1 && rating.to_i <= 10
            favorite = add_favorite
            Review.create(user_id: name.id, icecream_id: IceCream.last.id, rating: rating.to_i, favorite: favorite)
            UserOutputs.thanks(name)
        else 
            invalid_command
            get_review(name)
        end
    end

    def icecream_list_with_average_rating(name)
        ice_cream_rating = Review.group(:icecream_id).average(:rating)
        sorted_list = ice_cream_rating.map {|key, value| {id: key, rating: value.to_i}}.sort_by{|hash| hash[:rating]}.reverse
        list = sorted_list.slice(0, 5).map do |hash|
            "#{hash[:rating]} => #{IceCream.find(hash[:id]).flavors.downcase} with #{IceCream.find(hash[:id]).toppings.downcase}"
        end
        UserOutputs.top_5
        puts list.join("\n")
        sleep 2
        UserOutputs.any_flavor
        is_menu(name)
    end

    def find_old_review(name, user_input)
        user_input 
        name_review = Review.where(user_id: name.id)
        if name_review.size > 0
            if user_input == "update"
                review = find_review(name, user_input)
                review_update(name, review)
            else 
                review = find_review(name, user_input)
                delete_review(review)
            end
            else
                UserOutputs.first_time
                is_menu(name)
        end
    end

    def review_update(name, review)
        UserOutputs.new_rating
        new_rating = get_user_input
        if new_rating.to_i >= 1 && new_rating.to_i <= 10
            review.update({rating:new_rating})
            UserOutputs.soon(name)
        else 
            invalid_command
            review_update(name, review)
        end
    end

    def find_review(name, action)
        ice_cream_names = name.reviews.collect {|review| review.ice_cream.name}.uniq
        UserOutputs.option(action)
        puts ice_cream_names
        input = get_user_input
        if ice_cream_names.include?(input)
            icecream = IceCream.all.find_by(name: input)
            review = Review.where(user_id: name.id, icecream_id: icecream.id)
        else 
            invalid_command
            review = find_review(name, action)
        end
        review
    end

    def delete_review(review)
        review.destroy_all && UserOutputs.delete_all if review
    end
    
    def menu_select(name)
        user_input = get_user_input
        
        if user_input == 'order'
            is_menu(name)
        elsif user_input == 'top 5'
            icecream_list_with_average_rating(name)
        elsif user_input == 'update'
            find_old_review(name, user_input)
        elsif user_input == 'delete'
            review = find_old_review(name, user_input)
            delete_review(review)
        else
            invalid_command
            menu(name)
            menu_select(name)
        end
    end

    def invalid_command
        UserOutputs.invalid
    end

    def ice_cream_menu(name)
        menu = IceCream.all.map {|icecream| "* #{icecream.name.capitalize} => #{icecream.flavors} with #{icecream.toppings} on top"}
        puts menu
        sleep 2
        new_order(name)
    end

    def is_menu(name)
        UserOutputs.menu?
        user_input = get_user_input
        if user_input == 'yes'
            ice_cream_menu(name)
        elsif user_input == 'no'
            new_order(name)
        else 
            invalid_command
            is_menu(name)
        end
    end
end