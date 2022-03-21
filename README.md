# Project-2-AI
1- Key Predicates in our project : 
    room, breeze, pit, wumpus, stench, gold: those all are used to get the key locations on the map. 
    adj: haven't been properly used in the code but the main purpose of it is to determine the adjacent rooms any given room
    agent_location: keeping track on where the agent is located 
   
2- the solution wasn't easy to figure especially with the time coonstraint, but what we figured is to check for the next
room and see if it is safe to go there, if true we go into the next room, until we finally find the gold, or get eaten by the wumpus.

3- The limitations are very clear, we couldn't get to cover a randomly generated map or even get to choose when to go to the right room and when not to.
The changes that I would make is to improve the code is to make a randomly generated map with the 0.2 chances of a pit and 1 wumpus different from 1,1. 
the other change i would like to make is to "assume" the pit or the wumpus are on all the rooms adjacent to the breeze and stranch accordingly until 
we have enough information to prove otherwise. it would help make a safer choice and get a higher score each time.
