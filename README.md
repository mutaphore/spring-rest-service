# spring-rest-service
RESTful service API built using the Java Spring Framework and Spring Roo. Server is hosted on AWS EC2 using a Postgres database.

## Current available endpoints
### (GET) /comment/test
Should return "Comment test worked!" if the request was successful

### (GET) /comment/test2
Returns a JSON string with following structure:
```
{
    "comment": "Hey there!", 
    "commentDate": 1441566044470, 
    "id": 1, 
    "version": 0
}
```

### (GET) /comment/add
Add a new comment.
* `comment` Comment string to be added 
* `commentDate` Date in which comment was added. Omit this if you want to take the current time.



### (POST) /click_event/add
Add a new click event.
* `clickDate` Date in which the click was made
* `description` Description of the click activity
* `ipAddress` IP address of the client that made the click

### (GET) /click_event/test
Returns a JSON string with following structure:
```
{
    "clickDate": 1441652441894,
    "description": "This is a test Click Event object",
    "ipAddress": null,
    "id": 123,
    "version": null
}
```