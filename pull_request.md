## What?
Implementing a small HTTP service to store objects organized by repository

## Why?

It helps identify objects by their content. Please take a look at README **General Requirements** for more information. 

## How?

- Define a data structure to store objects by repository; I used the ruby hash to store objects keyed by repository name. 
- Create a DataStorage class which is responsible for storing the objects, finding the object, and deleting the object 
- Create a Front controller to help receives all incoming requests and route them to the appropriate controller. 
- The Router folder defines several classes to separate concerns and improve code organization. Here is a breakdown of what each class does:
      
     **Router::Attributes:** The request method (such as GET, POST, PUT, or DELETE), the location (such as"/data/:repository/:object_id"), and the controller to be called for the specified route are all represented by this class. These attributes are set by the initialize method, and each attribute has an attr_reader that enables access from the outside.

     **Router::Registry:** This class represents the registry of all routes in the application. It has an add method that creates a new Attributes instance for a given route and adds it to the @routes array. It also has a match method that takes a request method and path as arguments and returns the matching route, along with any associated parameters. It iterates over each route in @routes, checks if the request method matches and the path matches a pattern in the route's path, and extracts any parameters from the path. It then returns a hash with the extracted parameters, along with the controller and action to be invoked. The define_method method is also included, and it's used to dynamically define instance methods for the HTTP request methods (get, post, put, and delete) that will be used to add routes to the router.

    By this, the Registry class can avoid duplicating code for each HTTP method. Instead, it defines a single method and dynamically assigns it a name based on the HTTP method name passed as an argument.
The four methods get, post, put, and delete, each of which takes two arguments, a path, and a to_controller. When any of these methods is called, it invokes the add method with the corresponding HTTP method name, the path, and the to_controller.


    **Router::Mapper**: This is used to create the actual routes. It specifies a draw method that takes a block of code and evaluates it in the context of the mapper instance while taking a Registry instance as an argument. Additionally, a method_missing method is specified, which passes any method calls not defined to the Registry instance.
    
    Method_missing in the Mapper class is used to assign instances of Registry to any unclear methods. To do this, define a Registry ($registry) instance at the class level and use send to call its functions. The registry receives a call to any undefined function on a Mapper instance.

    **Router::Route:** This class is a helper class that provides a draw method to define routes. It creates a new Registry instance and a new Mapper instance, passing the Registry instance to the mapper. It then evaluates the block of code passed to the draw method in the context of the mapper instance, effectively defining the routes.

- DataController
  We need to implement controllers that handle the following actions:

  Upload an object
  Download an object
  Delete an object
  Each controller should handle the appropriate HTTP method and use a data repository to store and retrieve objects. We can implement the data repository as an in-memory hash table, where each key is a repository name and the value is a hash table that maps object IDs to object data.


## Testing?
I've fixed the falling test and written more tests for the new HomeController and Route Class.
