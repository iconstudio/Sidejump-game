function zui()
{
	if instance_exists(objZUIMain)
		return objZUIMain.id;
	else
		return instance_create_depth(0, 0, 0, objZUIMain, new zui_node());
}

/// @param {ID.Instance} _parent
/// @param {Real} _x
/// @param {Real} _y
function zui_node(_parent = noone, _x = 0, _y = 0) constructor
{
	__parent = _parent
	__enabled = true
	__visible = true
	__children = []
	__auto = 1

	__x = _x
	__y = _y
	__anchorx = 0.5
	__anchory = 0.5
	__scalex = 1
	__scaley = 1
	__width = 0
	__height = 0

	__hover = false
	__dx = 0
	__dy = 0
	__sx = 0
	__sy = 0
	__ax = 0
	__ay = 0
	__mx = 0
	__my = 0
}

/// @param {Real} _x
/// @param {Real} _y
/// @param {Asset.GMObject} _object
/// @param {Real} _depth
/// @return {ID.Instance}
function zui_create(_x, _y, _object, _depth = undefined)
{
	var child_depth = is_real(_depth) ? _depth : 0;

	var child = instance_create_depth(0, 0, child_depth, _object, new zui_node(id, _x, _y));

	with (child) 
	{
		visible = false;
	}

	zui_add_child(child);

	return child;
}

/// @self zui_node
function zui_destroy()
{
	var child_count = array_length(__children);

	for (var i = child_count - 1; i >= 0; --i)
	{
		with (__children[i])
		{
			zui_destroy();
		}
	}

	with (zui_get_parent())
	{
		zui_remove_child(other.id);
	}

	instance_destroy();
}

/// @self zui_node
function zui_update_begin()
{
	// TODO: Remove zui_update_begin
	__hover = false;

	var child_count = array_length(__children);

	for (var i = child_count - 1; i >= 0; --i)
	{
		with (__children[i])
		{
			zui_update_begin();
		}
	}
}

/// @self zui_node
/// @return {Bool}
function zui_update()
{
	var rx = __dx - __ax * __sx;
	var ry = __dy - __ay * __sy;

	__mx = global.__zui_mx - rx;
	__my = global.__zui_my - ry;

	if (__visible && __enabled && global.__zui_mx >= rx && global.__zui_my >= ry && global.__zui_mx < rx + __width * __sx && global.__zui_my < ry + __height * __sy)
	{ 
		var child_count = array_length(__children);

		for (var i = child_count - 1; i >= 0; --i)
		{
			with (__children[i])
			{
				if (zui_update())
				{
					other.__hover = false;

					return true;
				}
			}
		}
 
		__hover = true;

		return true;
	}
	else
	{
		__hover = false;

		return false;
	}
}

/// @self zui_node
/// @param {Real} _x
/// @param {Real} _y
/// @param {Real} _scale_x
/// @param {Real} _scale_y
function zui_draw(_x, _y, _scale_x, _scale_y)
{
	__dx = __x * _scale_x + _x;
	__dy = __y * _scale_y + _y;
	__sx = __scalex * _scale_x;
	__sy = __scaley * _scale_y;
	__ax = __width * __anchorx;
	__ay = __height * __anchory;

	if (!__visible)
	{
		return;
	}

	matrix_stack_push(matrix_build(__x - __ax * __scalex, __y - __ay * __scaley, 0, 0, 0, 0,  __scalex, __scaley, 1));
	matrix_set(matrix_world, matrix_stack_top());

	if (id != zui())
	{
		event_perform(ev_draw, 0);
	}

	if (__auto)
	{
		var child_count = array_length(__children);

		for (var i = 0; i < child_count; ++i)
		{
			with (__children[i])
			{
				zui_draw(other.__dx - other.__sx * other.__ax, other.__dy - other.__sy * other.__ay, other.__sx, other.__sy);
			}
		}
	}

	matrix_stack_pop();
}

/// @self zui_node
/// @param {ID.Instance} _id
/// @return {ID.Instance}
function zui_add_child(_id)
{
	array_push(__children, _id);
	zui_arrange_children();

	return _id;
}

/// @self zui_node
/// @param {ID.Instance} _id
function zui_remove_child(_id)
{
	var index = array_get_index(__children, _id);

	if (index >= 0)
	{
		array_delete(__children, index, 1);
	}
}

/// @self zui_node
/// @return {Real}
function zui_arrange_children()
{
	array_sort(__children, function (v0, v1) {
		if (v1.depth == v0.depth)
			return real(v0) - real(v1);
		else
			return v1.depth - v0.depth;
	});
}

#region Getter and setters
var do_not_show_warnings;

do_not_show_warnings = zui_get_x | zui_set_x | zui_get_y | zui_set_y | zui_get_position | zui_set_position |
	zui_get_width | zui_set_width | zui_get_height | zui_set_height | zui_get_size | zui_set_size |
	zui_get_scale_x | zui_set_scale_x | zui_get_scale_y | zui_set_scale_y | zui_get_scale | zui_set_scale |
	zui_get_anchor_x | zui_set_anchor_x | zui_get_anchor_y | zui_set_anchor_y | zui_get_anchor | zui_set_anchor |
	zui_get_visible | zui_get_visible_in_hierarchy | zui_set_visible |
	zui_get_enabled | zui_get_enabled_in_hierarchy | zui_set_enabled |
	zui_get_depth | zui_set_depth |
	zui_get_mouse_x | zui_get_mouse_y | zui_get_hover | zui_get_parent;

/// @self zui_node
/// @param {Bool} _enabled
function zui_set_enabled(_enabled)
{
	__enabled = _enabled;
}

/// @self zui_node
/// @param {Bool} _visible
function zui_set_visible(_visible)
{
	__visible = _visible;
}

/// @self zui_node
/// @param {Real} _depth
function zui_set_depth(_depth)
{
	depth = _depth;

	with (__parent)
	{
		zui_arrange_children();
	}
}

/// @self zui_node
/// @param {Real} _x
function zui_set_x(_x)
{
	__x = _x;
}

/// @self zui_node
/// @param {Real} _y
function zui_set_y(_y)
{
	__y = _y;
}

/// @self zui_node
/// @param {Real} _x
/// @param {Real} _y
function zui_set_position(_x, _y)
{
	__x = _x;
	__y = _y;
}

/// @self zui_node
/// @param {Real} _anchor_x
function zui_set_anchor_x(_anchor_x)
{
	__anchorx = _anchor_x;
}

/// @self zui_node
/// @param {Real} _anchor_y
function zui_set_anchor_y(_anchor_y)
{
	__anchory = _anchor_y;
}

/// @self zui_node
/// @param {Real} _anchor_x
/// @param {Real} _anchor_y
function zui_set_anchor(_anchor_x, _anchor_y)
{
	__anchorx = _anchor_x;
	__anchory = _anchor_y;
}

/// @self zui_node
/// @param {Real} _scale_x
function zui_set_scale_x(_scale_x)
{
	__scalex = _scale_x;
}

/// @self zui_node
/// @param {Real} _scale_y
function zui_set_scale_y(_scale_y)
{
	__scaley = _scale_y;
}

/// @self zui_node
/// @param {Real} _scale_x
/// @param {Real} _scale_y
function zui_set_scale(_scale_x, _scale_y)
{
	__scalex = _scale_x;
	__scaley = _scale_y;
}

/// @self zui_node
/// @param {Real} _width
function zui_set_width(_width)
{
	__width = _width;
}

/// @self zui_node
/// @param {Real} _height
function zui_set_height(_height)
{
	__height = _height;
}

/// @self zui_node
/// @param {Real} _width
/// @param {Real} _height
function zui_set_size(_width, _height)
{
	__width = _width;
	__height = _height;
}

/// @self zui_node
/// @return {Bool}
/// @pure
function zui_get_enabled()
{
	return __enabled;
}

function zui_get_enabled_in_hierarchy()
{
	if (not zui_get_enabled())
	{
		return false;
	}

	var next_parent = zui_get_parent();

	while (next_parent != noone)
	{
		with (next_parent)
		{
			if (not zui_get_enabled())
			{
				return false;
			}

			next_parent = __parent;
		}
	}

	return true;
}

/// @self zui_node
/// @return {Bool}
/// @pure
function zui_get_visible()
{
	return __visible;
}

/// @self zui_node
/// @return {Bool}
/// @pure
function zui_get_visible_in_hierarchy()
{
	if (not zui_get_visible())
	{
		return false;
	}

	var next_parent = zui_get_parent();

	while (next_parent != noone)
	{
		with (next_parent)
		{
			if (not zui_get_visible())
			{
				return false;
			}

			next_parent = __parent;
		}
	}

	return true;
}

/// @self zui_node
/// @return {ID.Instance}
/// @pure
function zui_get_parent()
{
	return __parent;
}

/// @self zui_node
/// @return {Bool}
/// @pure
function zui_get_hover()
{
	return __hover;
}

/// @self zui_node
/// @return {Real}
/// @pure
function zui_get_depth()
{
	return depth;
}

/// @self zui_node
/// @return {Real}
/// @pure
function zui_get_x()
{
	return __x;
}

/// @self zui_node
/// @return {Real}
/// @pure
function zui_get_y()
{
	return __y;
}

/// @self zui_node
/// @return {Array<Real>}
/// @pure
function zui_get_position()
{
	return [__x, __y];
}

/// @self zui_node
/// @return {Real}
/// @pure
function zui_get_anchor_x()
{
	return __anchorx;
}

/// @self zui_node
/// @return {Real}
/// @pure
function zui_get_anchor_y()
{
	return __anchory;
}

/// @self zui_node
/// @return {Array<Real>}
/// @pure
function zui_get_anchor()
{
	return [__anchorx, __anchory];
}

/// @self zui_node
/// @return {Real}
/// @pure
function zui_get_scale_x()
{
	return __scalex;
}

/// @self zui_node
/// @return {Real}
/// @pure
function zui_get_scale_y()
{
	return __scaley;
}

/// @self zui_node
/// @return {Array<Real>}
/// @pure
function zui_get_scale()
{
	return [__scalex, __scaley];
}

/// @self zui_node
/// @return {Real}
/// @pure
function zui_get_width()
{
	return __width;
}

/// @self zui_node
/// @return {Real}
/// @pure
function zui_get_height()
{
	return __height;
}

/// @self zui_node
/// @return {Array<Real>}
/// @pure
function zui_get_size()
{
	return [__width, __height];	
}

/// @self zui_node
/// @return {Real}
/// @pure
function zui_get_mouse_x()
{
	return __mx;
}

/// @self zui_node
/// @return {Real}
/// @pure
function zui_get_mouse_y()
{
	return __my;
}

#endregion
