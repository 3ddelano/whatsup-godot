extends Node

var _tweening_nodes = {}

const MOVE_LENGTH = 10


func stop_tween_inbetween(node: Control):
	if node not in _tweening_nodes:
		return

	var data = _tweening_nodes[node]
	var tw: Tween = data.tween
	var node_pos_before: Vector2 = data.node_pos_before
	var parent: Control = data.parent
	var helper_node: Node2D = data.helper_node

	tw.stop()
	node.reparent(parent)
	node.global_position = node_pos_before
	helper_node.visible = false
	helper_node.queue_free()


func slide_up(node: Control, duration_s: float = 0.1):
	if node in _tweening_nodes:
		stop_tween_inbetween(node)

	# Defer by 1 frame so that the containers
	# can do all their positioning and sizing
	await get_tree().process_frame

	var parent: Node = node.get_parent()
	assert(parent, "Unable to tween. No parent node.")
	if not parent:
		printerr("Unable to tween. No parent node.")
		return

	var node_size_before = node.size
	var node_pos_before = node.global_position
	var helper_node = Node2D.new()

	parent.remove_child(node)
	parent.add_child(helper_node)
	helper_node.top_level = true
	helper_node.add_child(node)

	node.set_deferred("global_position", node_pos_before + Vector2(0, MOVE_LENGTH))
	node.set_deferred("size", node_size_before)

	var tw = create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_BACK)
	tw.tween_property(node, "global_position:y", node_pos_before.y, duration_s)
	_tweening_nodes[node] = {
		tween = tw,
		helper_node = helper_node,
		parent = parent,
		node_size_before = node_size_before,
		node_pos_before = node_pos_before,
	}
	await get_tree().create_timer(duration_s).timeout

	_tweening_nodes.erase(node)

	# We may have already stopped this tween midway
	if is_instance_valid(helper_node):
		node.reparent(parent)
		helper_node.visible = false
		helper_node.queue_free()
