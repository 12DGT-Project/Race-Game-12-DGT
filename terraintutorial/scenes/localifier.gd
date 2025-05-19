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
			
			parent.add_child(duplicate_scene)
			duplicate_scene.owner = node_owner
			
			print_debug("Found MeshInstance3D " + node.name)
			duplicate_scene.create_trimesh_collision()
			parent = duplicate_scene
		
		node.get_parent().remove_child(node)
	
	for child in node.get_children():
		make_local(child,parent,node_owner)
			
