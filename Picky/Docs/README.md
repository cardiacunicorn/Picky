#  Picky

## Notes

- Discussion of refreshing the UI on data request being received, implements 'Refresh' protocol - 11:15 of Lec 7.7
    `viewDidLoad() { super.viewDidLoad(); tableView.dataSource = self; viewModel.delegate = self }`
    `func updateUI() { tableView.reloadData() }`
- AppDelegate has code that is essential in linking to Core Data - 6:00 of Lector's 8.6

- 'Guests' tab should represent all the guests in the 'selected' guestlist, by default, all of them
- Should add a select drop down or text input that filters and adjusts the 'selected guests' array

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

### Functionality 1.5/3.5
- Design largely makes sense to use, is fairly intuitive
- App maintains no errors
- Data is appended and removed from Arrays to simulate a database

### Layout Types 5/5
- Tab Bar 1/1
    - Not being used across the same task
- UIView Scene 1/1
    - Recipe detail view
    - Diverse range of elements
- UITableView 1/1
    - Recipes table
    - Valid sample data populating by default
- Master/Detail 1/1
    - Recipes tab configuration
- PopOver or Alert scene -> confirmation of Array modification, or a form for Add a Recipe/Guest
- About page (in Settings under the Tab Bar?) with student details
    
### Documentation 1/1
- Record any other changes: design principles, persistence etc. (in an appendix?)
- Additional high-fidelity wireframe screenshots should be added to the report

### Design 4/5.5
- Autolayout used consistently, with no conflicts
- Design principles and themes have been consciously applied in each scene
- MVVM is adhered to
    - No controllers managing their own data collections -> part of the view model in each case
    - Controllers call methods on the ViewModel to manage and preserve State
    - ViewModel instantiates business objects
