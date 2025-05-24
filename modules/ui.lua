local m_ui = {}

--------------------------------------------------------------------------------
-- Dependencies
--------------------------------------------------------------------------------

local m_input = require("modules.input")
local m_tile = require("modules.tile")

--------------------------------------------------------------------------------
-- Private Variables
--------------------------------------------------------------------------------

local _group_editor = hash("editor")

local _state_enter = hash("enter")
local _state_exit = hash("exit")

local _enter_callback = nil
local _exit_callback = nil
local _selected_callback = nil

local _object_editor_ui_tile_white_01 = hash("/ui_tile_white_01")
local _object_editor_ui_tile_white_02 = hash("/ui_tile_white_02")
local _object_editor_ui_tile_white_03 = hash("/ui_tile_white_03")
local _object_editor_ui_tile_white_04 = hash("/ui_tile_white_04")
local _object_editor_ui_tile_white_05 = hash("/ui_tile_white_05")
local _object_editor_ui_tile_white_06 = hash("/ui_tile_white_06")
local _object_editor_ui_tile_white_07 = hash("/ui_tile_white_07")
local _object_editor_ui_tile_white_08 = hash("/ui_tile_white_08")
local _object_editor_ui_tile_white_09 = hash("/ui_tile_white_09")
local _object_editor_ui_tile_white_10 = hash("/ui_tile_white_10")
local _object_editor_ui_tile_white_11 = hash("/ui_tile_white_11")
local _object_editor_ui_tile_white_12 = hash("/ui_tile_white_12")
local _object_editor_ui_tile_white_13 = hash("/ui_tile_white_13")
local _object_editor_ui_tile_white_14 = hash("/ui_tile_white_14")
local _object_editor_ui_tile_white_15 = hash("/ui_tile_white_15")

local _object_data =
{
	[_object_editor_ui_tile_white_01] =
	{
		group = _group_editor,
		animation = hash("tile_white_01"),
		state = _state_exit
	},
	[_object_editor_ui_tile_white_02] =
	{
		group = _group_editor,
		animation = hash("tile_white_02"),
		state = _state_exit
	},
	[_object_editor_ui_tile_white_03] =
	{
		group = _group_editor,
		animation = hash("tile_white_03"),
		state = _state_exit
	},
	[_object_editor_ui_tile_white_04] =
	{
		group = _group_editor,
		animation = hash("tile_white_04"),
		state = _state_exit
	},
	[_object_editor_ui_tile_white_05] =
	{
		group = _group_editor,
		animation = hash("tile_white_05"),
		state = _state_exit
	},
	[_object_editor_ui_tile_white_06] =
	{
		group = _group_editor,
		animation = hash("tile_white_06"),
		state = _state_exit
	},
	[_object_editor_ui_tile_white_07] =
	{
		group = _group_editor,
		animation = hash("tile_white_07"),
		state = _state_exit
	},
	[_object_editor_ui_tile_white_08] =
	{
		group = _group_editor,
		animation = hash("tile_white_08"),
		state = _state_exit
	},
	[_object_editor_ui_tile_white_09] =
	{
		group = _group_editor,
		animation = hash("tile_white_09"),
		state = _state_exit
	},
	[_object_editor_ui_tile_white_10] =
	{
		group = _group_editor,
		animation = hash("tile_white_10"),
		state = _state_exit
	},
	[_object_editor_ui_tile_white_11] =
	{
		group = _group_editor,
		animation = hash("tile_white_11"),
		state = _state_exit
	},
	[_object_editor_ui_tile_white_12] =
	{
		group = _group_editor,
		animation = hash("tile_white_12"),
		state = _state_exit
	},
	[_object_editor_ui_tile_white_13] =
	{
		group = _group_editor,
		animation = hash("tile_white_13"),
		state = _state_exit
	},
	[_object_editor_ui_tile_white_14] =
	{
		group = _group_editor,
		animation = hash("tile_white_14"),
		state = _state_exit
	},
	[_object_editor_ui_tile_white_15] =
	{
		group = _group_editor,
		animation = hash("tile_white_15"),
		state = _state_exit
	}
}

--------------------------------------------------------------------------------
-- Public Variables
--------------------------------------------------------------------------------

m_ui.group_editor = _group_editor

m_ui.state_enter = _state_enter
m_ui.state_exit = _state_exit

m_ui.object_editor_ui_tile_white_01 = _object_editor_ui_tile_white_01
m_ui.object_editor_ui_tile_white_02 = _object_editor_ui_tile_white_02
m_ui.object_editor_ui_tile_white_03 = _object_editor_ui_tile_white_03
m_ui.object_editor_ui_tile_white_04 = _object_editor_ui_tile_white_04
m_ui.object_editor_ui_tile_white_05 = _object_editor_ui_tile_white_05
m_ui.object_editor_ui_tile_white_06 = _object_editor_ui_tile_white_06
m_ui.object_editor_ui_tile_white_07 = _object_editor_ui_tile_white_07
m_ui.object_editor_ui_tile_white_08 = _object_editor_ui_tile_white_08
m_ui.object_editor_ui_tile_white_09 = _object_editor_ui_tile_white_09
m_ui.object_editor_ui_tile_white_10 = _object_editor_ui_tile_white_10
m_ui.object_editor_ui_tile_white_11 = _object_editor_ui_tile_white_11
m_ui.object_editor_ui_tile_white_12 = _object_editor_ui_tile_white_12
m_ui.object_editor_ui_tile_white_13 = _object_editor_ui_tile_white_13
m_ui.object_editor_ui_tile_white_14 = _object_editor_ui_tile_white_14
m_ui.object_editor_ui_tile_white_15 = _object_editor_ui_tile_white_15

--------------------------------------------------------------------------------
-- Private Functions
--------------------------------------------------------------------------------

local function select()
	for object, data in pairs(_object_data) do
		if data.state == _state_enter then
			if _selected_callback then
				_selected_callback(object)
			end
		end
	end
end

--------------------------------------------------------------------------------
-- Public Functions
--------------------------------------------------------------------------------

function m_ui.init(group, enter_callback, exit_callback, selected_callback)
	_enter_callback = enter_callback
	_exit_callback = exit_callback
	_selected_callback = selected_callback
	for object, data in pairs(_object_data) do
		if data.group == group then
			local sprite_url = msg.url(nil, object, "sprite")
			sprite.play_flipbook(sprite_url, data.animation)
		end
	end
end

function m_ui.final(group)
	_enter_callback = nil
	_exit_callback = nil
	_selected_callback = nil
	for object, data in pairs(_object_data) do
		if data.group == group then
			data.state = _state_exit
		end
	end
end

function m_ui.update()
	if m_input.get_state(m_input.input_mouse_button_left) == m_input.state_pressed then
		select()
	end
end

function m_ui.state(object, state)
	local object_data = _object_data[object]
	object_data.state = state
	if state == _state_enter then
		if _enter_callback then
			_enter_callback(object)
		end
	elseif state == _state_exit then
		if _exit_callback then
			_exit_callback(object)
		end
	end
end

function m_ui.get_animation(object)
	return _object_data[object].animation
end

return m_ui