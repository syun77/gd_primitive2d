@tool
extends Node2D

## 図形の種類.
enum eType {
	CIRCLE,
	RECT,
	ROUNDED_RECT,
	FILLED_ARC,
}

## 図形の種類.
@export var type = eType.CIRCLE
@export var color = Color.WHITE
@export var centered = true
## ------------ circle
@export_category("Circle")
## 半径.
@export_range(0.0, 512.0) var radius:float = 64.0
## ------------ rect
@export_category("Rect")
## 幅と高さ.
@export var size = Vector2(64.0, 64.0)
## ------------ filled arc
@export_category("Filled Arc")
@export_range(0.0, 360.0) var start:float = 0.0
@export_range(0.0, 360.0) var arc:float = 30.0
@export_range(4, 64) var divide:int = 16

## 更新 (再描画の要求をする)
func update() -> void:
	queue_redraw()

func _process(_delta: float) -> void:
	update()
	
func _draw() -> void:
	match type:
		eType.CIRCLE:
			_draw_circle()
		eType.RECT:
			_draw_rect()
		eType.ROUNDED_RECT:
			_draw_rounded_rect()
		eType.FILLED_ARC:
			_draw_filled_arc()

func _draw_circle() -> void:
	draw_circle(Vector2.ZERO, radius, color)
	
func _draw_rect() -> void:
	var pos = Vector2.ZERO
	if centered:
		pos -= size/2
	var rect = Rect2(pos, size)
	draw_rect(rect, color)

func _draw_rounded_rect() -> void:
	pass
func _draw_filled_arc() -> void:
	var points = PackedVector2Array()
	var div = divide
	var colors = PackedColorArray()
	points.append(Vector2.ZERO)
	colors.append(color)
	var rad = start
	var d = (arc) / (div - 1)
	for i in range(div):
		var v = Vector2()
		v.x = radius * cos(rad)
		v.y = radius * sin(rad)
		points.append(v)
		colors.append(color)
		rad += d
	draw_polygon(points, colors)
