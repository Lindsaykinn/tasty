Requirements:
Use the Ruby on Rails framework.

Your models must:

[X] 1. Include at least one has_many, at least one belongs_to, and at least two has_many :through relationships
        DELIVERY: category has_many :recipes / user belongs_to :category / category has_many :instructions, through: :recipes / user has_many :recipes, through: :categories

[X] 2. Include a many-to-many relationship implemented with has_many :through associations. The join table must include a user-submittable attribute — that is to say, some attribute other than its foreign keys that can be submitted by the app's user
        DELIVERY: steps in instructions

[X] 3. Your models must include reasonable validations for the simple attributes. You don't need to add every possible validation or duplicates, such as presence and a minimum length, but the models should defend against invalid data.
        DELIVERY: validation of names and/or titles

[X] 4. You must include at least one class level ActiveRecord scope method  a. Your scope method must be chainable, meaning that you must use ActiveRecord Query methods (Links to an external site.) within it (such as .where and .order) rather than native ruby methods (such as #find_all or #sort).
        DELIVERY

[X] 5. Your application must provide standard user authentication, including signup, login, logout, and passwords.

[X] 6. Your authentication system must also allow login from some other service. Facebook, Twitter, Foursquare, Github, etc...

[X] 7. You must include and make use of a nested resource with the appropriate RESTful URLs.

    [X] • You must include a nested new route with form that relates to the parent resource

    [X] • You must include a nested index or show route

[X] 8. Your forms should correctly display validation errors.

    [X] a. Your fields should be enclosed within a fieldswitherrors class

    [X] b. Error messages describing the validation failures must be present within the view.

[ ] 9. Your application must be, within reason, a DRY (Do-Not-Repeat-Yourself) rails app.

    [ ] • Logic present in your controllers should be encapsulated as methods in your models.

    [X] • Your views should use helper methods and partials when appropriate.

    [ ] • Follow patterns in the Rails Style Guide and the Ruby Style Guide.

[X] 10. Do not use scaffolding to build your project. Your goal here is to learn. Scaffold is a way to get up and running quickly, but learning a lot is not one of the benefits of scaffolding.
