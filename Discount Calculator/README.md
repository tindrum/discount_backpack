# discount_backpack
iOS discount calculator for CS 411
Daniel Henderson
on github: https://github.com/tindrum/discount_backpack


## Third-party resources

Several useful techniques were gleaned from 
**iOS Programming, The Big Nerd Ranch Guide** 
by Christian Keur and Aaron Hillegass,
published by Big Nerd Ranch.
This book, and any from this publisher, 
are recommended.

A concise example of a Singleton instantiation,
for the "Calculator" object, was found on Stack Overflow
at http://stackoverflow.com/questions/39628277/singleton-with-swift-3-0
and Apple really needs to include some documentation that can be found
to cover this topic. I spent over an hour, panicking, looking for 
the solution that I knew existed.

## Instructions

Please submit your solution to the following exercise via a Github repository. 
Your submission must, at a minimum, include a README file with your name, short description of the assignment, and any third party material properly attributed.

Create an app with two views. The first initial view will allow the user to enter in a dollar amount, discount rate, additional discount rate, and sales tax to calculate and visualize the cost of an item. A second view will show the user a graphical breakdown of the costs. The user with a swipe gesture can move from one view to another.

### TODO list
* make backpack image scaleable based on screen size
* animate discount rectangle on ResultsView
* add static image of UI to show during startup

### Done list
* show discount text for small discounts (it's covered by the final text)
* add application icons
* add magenta backpack image to front page
* make methods to calculate inset size of results pane/page
* make method to calculate absolute size of rectangles based on relative percentage of discount
