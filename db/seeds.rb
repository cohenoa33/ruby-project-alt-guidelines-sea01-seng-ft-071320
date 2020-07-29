User.destroy_all
IceCream.destroy_all
Review.destroy_all

#user
User.create(
    name: Faker::Name.name
)

#ice cream
IceCream.create(
    name: Faker::Hipster.word, 
    flavors: Faker::Dessert.flavor, 
    toppings: Faker::Dessert.topping
)

#reviews
Review.create(
    user_id: User.all.sample.id, 
    icecream_id: IceCream.all.sample.id, 
    rating: Faker::Number.between(from: 1, to: 10), 
    favorite: Faker::Boolean.boolean
)

binding.pry