# Specifications for the Rails Assessment

Specs:
- [x] Using Ruby on Rails for the project
- [x] Include at least one has_many relationship (x has_many y; e.g. User has_many Recipes)
    user has_many dispensers
- [x] Include at least one belongs_to relationship (x belongs_to y; e.g. Post belongs_to User)
    dispenser belongs_to user
- [x] Include at least two has_many through relationships (x has_many y through z; e.g. Recipe has_many Items through Ingredients)
    plant has_many containers through waterings, container has_many plants through waterings
- [x] Include at least one many-to-many relationship (x has_many y through z, y has_many x through z; e.g. Recipe has_many Items through Ingredients, Item has_many Recipes through Ingredients)
    same as above ^
- [x] The "through" part of the has_many through includes at least one user submittable attribute, that is to say, some attribute other than its foreign keys that can be submitted by the app's user (attribute_name e.g. ingredients.quantity)
    Waterings.vacation_days
- [x] Include reasonable validations for simple model objects (list of model objects with validations e.g. User, Recipe, Ingredient, Item)
    user has secure password, validates presence of name,email,password, unique email
    dispenser validates presence product #, capacity, name, unique product #
    plants validates presence name, location, water q and f
    waterings validates vacation days can't be < 0
- [x] Include a class level ActiveRecord scope method (model object & class method name and URL to see the working feature e.g. User.most_recipes URL: /users/most_recipes)
    Plant.water_soon used for Plant.water_today method and used in other methods
- [x] Include signup (how e.g. Devise)
    signup.html.erb with regular form or omniauth google, bcrypt
- [x] Include login (how e.g. Devise)
    login.html.erb with regular form or omniauth google, bcrypt
- [x] Include logout (how e.g. Devise)
    logout in sessions controller
- [x] Include third party signup/login (how e.g. Devise/OmniAuth)
    omniauth google
- [x] Include nested resource show or index (URL e.g. users/2/recipes)
    dispensers/1/plants
- [x] Include nested resource "new" form (URL e.g. recipes/1/ingredients/new)
    dispensers/1/plants/new
- [x] Include form display of validation errors (form URL e.g. /recipes/new)
    dispensers/1/plants/new

Confirm:
- [x] The application is pretty DRY
- [x] Limited logic in controllers
- [x] Views use helper methods if appropriate
- [x] Views use partials if appropriate
