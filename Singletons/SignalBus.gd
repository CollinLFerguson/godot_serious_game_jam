extends Node

# Win/loss signals
signal player_lost
signal player_win

# Battle signals
signal battle_start

# Upgrade signals
signal upgrade_selected(upgradeName: String)

# Scene switching signal
signal scene_switch(scenePath: String)

#impact collision
signal hit(source, target) #source should always be passed like hit(self, body)

signal hitstop
