extends Node2D

var is_dragging = false
var item_being_moved:Donut
var score = 0

enum DONUT_STATUS { RAW = 1, ALMOST_DONE, DONE, BURNED}
enum DONUT_MOD_STATUS {PERFECT, GOOD, OKAY, BAD}



