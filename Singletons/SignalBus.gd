extends Node

# Win/loss signals
signal player_lost
signal player_win

# Upgrade signals
signal upgrade_selected(upgradeName: String)

# Scene switching signal
signal scene_switch(scenePath: String)
