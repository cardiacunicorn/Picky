#  Picky

## To Do

### Functionality 2.5/3.5
- Remove partial implementation of incomplete features from the Simulated prototype
- Data is appended and removed from Arrays to simulate a database
- Data validation -> prevent awkward rendering e.g. user text input, placeholder image for custom recipe
- Content should not move out of range when flipping horizontal e.g. Recipe Detail View
- Implements a Cocoa Touch class that uses a hardware feature
    - Handles when the hardware is unavailable (such as in Simulator)
    - Potentially take a photo (or insert one) when adding a recipe

### Layout Types 1/5
- Must include a PopOver or Alert scene -> confirmation of Array modification, or a form for Add a Recipe/Guest
- Must include an About page (in Settings under the Tab Bar?) with student details

### Design 1.5/5.5
- 4x UITests implemented
    - Comments should mention the pre-condition, action and expected post-condition
    - Tests ensure pre-conditions are met
    - Contains assertion tests to validate all elements are present in scene
    - Run to ensure it returns a Pass
    - At least one test that navigates across multiple scenes, demonstrates typical use case
    
### Documentation 1/1
- Additional high-fidelity wireframe screenshots should be added to the report




## Done

### Functionality 1/3.5
- Design largely makes sense to use, is fairly intuitive
- App maintains no errors

### Layout Types 4/5
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

### Design 4/5.5
- Autolayout used consistently, with no conflicts
- Design principles and themes have been consciously applied in each scene
- MVVM is adhered to
    - No controllers managing their own data collections -> part of the view model in each case
    - Controllers call methods on the ViewModel to manage and preserve State
    - ViewModel instantiates business objects
    
### Documentation 0/1
- Record any other changes: design principles, persistence etc. (in an appendix?)




## Notes


