# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


User.create([
  {name: "Harry",
  email: "thechosenone@gmail.com",
  password: "Ginny"},
  {name: "Anna",
  email: "anna@mail.com",
  password: "anna"}
])

Category.create([
  {name: "Mexican",
  user_id: 1},
  {name: "Appetizer",
  user_id: 2},
  {name: "Sandwich",
  user_id: 2}
])

Recipe.create([
  {title: "Grilled Cheese",
  category_id: 3,
description: "Tasty sandwich"},
  {title: "Tacos",
  category_id: 1,
description: "Mexican staple"},
  {title: "Hummus",
  category_id: 2,
description: "Easy dip"},
])

Instruction.create([
  {step: "Grill bread, cheese, then serve.",
  recipe_id: 1},
  {step: "Blend chick peas with tahini and serve.",
  recipe_id: 3},
  {step: "Brown meat, chop veggies, and serve.",
  recipe_id: 2},
])