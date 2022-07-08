tool
extends Resource

class_name NPC_DATA

# actions without direct effect on puzzle state
export(int) var angry_action
export(int) var happy_action
export(int) var humor_action
export(int) var challenge_action
export(int) var sad_action
export(int) var fear_action
export(int) var urgent_action
export(int) var agree_action

#  action that directly affect puzzle state

export(int) var open_door
export(int) var punch
export(int) var run_away
export(int) var slap
export(int) var make_out
export(int) var walk_to_target

# visual attributes

export(Material) var material 
