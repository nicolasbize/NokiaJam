class_name PlayerTrigger
extends Area2D

enum ITEM {NONE, BOOTS, POWERCORE}

signal use(player) # called when the player interacts with the object

export(ITEM) var equipment = ITEM.NONE
