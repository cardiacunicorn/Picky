#  Picky

## Notes

- Adding an item to Core Data appears to be working, hard to confirm because on subsequent launches it's just data:<fault>
- loadItems is the problem
- there is cart data in Manager, but it does not seem accessible in ViewModel

- A (set) rather than an array, will ensure no duplicate items -> maybe implement for Guestlist allergies and diets
- Guests and Guestlists should potentially have the same Manager in the Model, so both can be created together on user input (Tut 8.4: 14:00)
- 'Guests' tab should represent all the guests in the 'selected' guestlist, by default, all of them
- Should add a select drop down or text input that filters and adjusts the 'selected guests' array
- Add All seems to be creating a second shopping list (potentially), I should move to a singleton Model object for the shopping list
- To update a UIButton requires using a setTitle method, rather than just manipulating the text raw

## To Do (Milestone 3)

### UI Tests & Unit Tests 2/3
- Implement at least 2 more unit tests, for the View Models

### Networking 5/5
- The user of the app must be able to provide dynamic access such as providing data that will form part of the request. It should not just be a hard coded request and display of data.

### Persistence 5/5
- Data must be saved and retrieved you should be able to display these features via a screen in the app.
- All four CRUD operations must be implemented

### Design Patterns 3/3
- You must design and implement the design pattern in your code, not make use of one already implemented by a library or framework. For example you cannot claim delegation because you have used delegation in your Table View. This is only using the pattern. You must design and implement the pattern yourself.

### Auto Layout & Adaptive Layout 1/3
- Need to figure out getting the recipe detail view to scroll




## To Do (Milestone 2)

### Functionality 2/3.5
- Data validation -> prevent awkward rendering e.g. user text input, placeholder image for custom recipe
- Content should not move out of range when flipping horizontal e.g. Recipe Detail View
- Implements a Cocoa Touch class that uses a hardware feature
    - Handles when the hardware is unavailable (such as in Simulator)
    - Potentially take a photo (or insert one) when adding a recipe
- Remove partial implementation of incomplete features from the Simulated prototype

### Design 1.5/5.5
- 4x UITests implemented
    - Comments should mention the pre-condition, action and expected post-condition
    - Tests ensure pre-conditions are met
    - Contains assertion tests to validate all elements are present in scene
    - Run to ensure it returns a Pass
    - At least one test that navigates across multiple scenes, demonstrates typical use case




## Done

### Auto Layout & Adaptive Layout 2/3
- Both manual constraints and stack views have been demonstrated to achieve the layout requirements.
- At least two scenes have utilised manual constraint based design without making use of stack views.
- Autolayout used consistently, with no conflicts

### Other
- App maintains no errors

### Design 4/5.5
- MVVM is adhered to
    - No controllers managing their own data collections -> part of the view model in each case
    - Controllers call methods on the ViewModel to manage and preserve State
    - ViewModel instantiates business objects
