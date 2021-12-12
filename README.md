# Land Buddy

An AirBnb clone for land access.

This project was a Capstone Project for my graduation from California State University, Chico. Included below are all of the elements of this project.

Narrative & The Story of the project- Included Below

Project Requirements - Included Below

Code Implementation - Included in the directory entitled [capstone_proj](https://github.com/a-ddollar-cs/Capstone/tree/main/capstone_proj)

Design Models, Wireframes, and Diagrams - Included in the directory entitled [design&models](https://github.com/a-ddollar-cs/Capstone/tree/main/design%26models)

Milestone Submissions throughout the Semester - Included in the directory entitled [Milestones](https://github.com/a-ddollar-cs/Capstone/tree/main/Milestones)

## Narrative

### What is it?

  This project is a flutter app that came from a Facebook post in a groupf centered around hunting that I am apart of. The post asked the group if there are any resources that they wish were available to hunters. In the comments of this post, someone had mentioned that they wish there was an easy way to ask permission to hunt on someone's land. After reading this comment, Land Buddy was born. Land Buddy is an application that is similar to AirBnb, however, rather than being centered around booking someone's house or apartment, your booking is used for grant access to private property. While the original intent of the app began as centered around hunting, I xpanded the functionality, to include requests for access for any purpose, such as camping, hiking, fishing, easements for getting through the land, piloting drones above it, the list goes on. In its current state, this project allows for users to create an account, and switch between the land owner view and renter view. Land owners canpost their land for access purposes, where they specify details about the property, include a picture, post any rules regarding what is allowed, and their contact information if any issues arise. Renters will be able to see all available properties, and they can see details about them, then they can book a "stay" or access period on a calendar. This calendar booking will then be available to both the renter and the land owner.
  
  
## Project Requirements

### Version 1
Below is a list of all of the requirements for my first deliverable of this project at the end of the Fall 2021 Semester. Each Requirement will have a status on completion, and brief description on how to test it.

R1)  User Account Creation
  R1a. Shall allow users create an account and log in, logout - Met
  R1b. Shall allow users to select either owner or renter upon account creation - Met 
  R1c.  Shall Allow auto login so logging in every time you launch the app is not necessary - Met
  R1d. Shall Allow users to add their name to the account - Met
  
Testing: This requirement, and all sub requirements can be tested upon first launch of the app. Users are prompted to sign up, or log in to an existing account. If they opt to create an account, they will give all of theiir information, such as email, name, and password. Once they do this, and they are logged in, thhey can change their status as an owner or renter on their profile page, which, if changed from the standard renter, simply requires the user to log out then re log in for these changes to take effect. 

R2) Adding a post
	R2a. Shall allow owners to add properties to the database via a “listing” - Met
	R2b. Listings shall contain image(s) of the property, as well as basic property details, and information about the owner - Met

 Testing: When authenticated as an "owner," there will appear a "+" icon on the top toolbar, which brings the user to a form to fill out details about their property. The owner will fill out things including a basic property description, the price, a picture, as well as any rules and their own contact information. This post will then be uploaded to the feed of available properties.
 
 R3) Booking a listing
	R4a. Shall allow users to see a list of properties available for booking - Met
	R3b. When a property is selected, shall allow the user to book said property via a calendar - Met

Testing: Users authenticated as a "renter" will be able to view a list of available properties, which the user can select one to view more details on it. If the user wishes to book the property for a stay, they will select the "book now!" button, which brings them to a calendar view. This Calendar view will allow them to select a start date and an end date. Once that is completed, the stay will appear in the calendar tab of both the renter who booked the property, as well as the land owner whose property was booked.


### Version 2
Below is a list of all the stretch goals for my Capstone Project, elements that were noit apart o the initial requirements, but will be implemented in version 2 of the project, past the date of the original deliverable and original requirements. 

R1) Account Creation Stretch Goals
 R1e (Stretch goal/ Version 2). Users can add a profile picture
 
R3) Booking a listing
  R3c (Stretch goal/ Version 2). Shall allow users to filter property results by property details


