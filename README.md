# LuaAssignmentTest

# Goal: 

You are writing a feature for a game. This feature will move a you closer to a destination each 
turn but you are limited by stamina and max distance you can travel per turn. Stamina increases a 
bit per turn but has a cap. Reach the destination before you run out of stamina. Modify the config 
file to see how different variables affect the difficulty. 


Config file variables: - - - - - - 

A: holds an int 

B: holds an int 

C: holds an int 

Stamina: max stamina you have 

Stamina_recovery: stamina recovered per turn, can go negative based on how far you 
want to move. 


Goal_distance: distance to goal from start. Goes down as you move. 


Requirements: - 
Use a metatable to store config variables. These are considered default variables 
- 
Max distance is calculated in the program and stored in the metatable and rounded to 
closest whole integer. - - - - - 

Use cli input to determine how the user wants to move 

Make sure you lose if you run out of stamina. 

Make at least 4 test cases where the config variables are changed 

Calculate the max_distance correctly 

Make sure error checking is implemented 
