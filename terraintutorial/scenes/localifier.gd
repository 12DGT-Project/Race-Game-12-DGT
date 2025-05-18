@tool
extends Node3D
class_name MeshLibTool

@export var recursive:bool:
	set(value):
		print_debug("recursive tool")
		value = false
		make_local($".",$".",$".")
	get:
		return false
		
func make_local(node,parent,node_owner):
	print_debug("making local:" + node.name)
	#node.scene_file_path = ""

	if node!= $".":
		
		if node is MeshInstance3D:
			var duplicate_scene = node.duplicate()
			duplicate_scene.scene_file_path = ""
			duplicate_scene.name = "l_" + duplicate_scene.name
			#3:24
