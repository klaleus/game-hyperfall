local m_input = {}

--------------------------------------------------------------------------------
-- Dependencies
--------------------------------------------------------------------------------

local m_camera = require("modules.camera")

local m_starly = require("starly.starly")

--------------------------------------------------------------------------------
-- Private Variables
--------------------------------------------------------------------------------

local _state_up = hash("up")
local _state_pressed = hash("pressed")
local _state_down = hash("down")
local _state_released = hash("released")

local _action_id_key_f11 = hash("key_f11")
local _action_id_key_esc = hash("key_esc")
local _action_id_key_w = hash("key_w")
local _action_id_key_a = hash("key_a")
local _action_id_key_s = hash("key_s")
local _action_id_key_d = hash("key_d")
local _action_id_mouse_button_left = hash("mouse_button_left")
local _action_id_mouse_button_right = hash("mouse_button_right")
local _action_id_mouse_wheel_up = hash("mouse_wheel_up")
local _action_id_mouse_wheel_down = hash("mouse_wheel_down")

local _input_fullscreen = hash("fullscreen")
local _input_escape = hash("escape")
local _input_up = hash("up")
local _input_left = hash("left")
local _input_down = hash("down")
local _input_right = hash("right")
local _input_mouse_button_left = hash("mouse_button_left")
local _input_mouse_button_right = hash("mouse_button_right")

local _bindings =
{
	[_action_id_key_f11] = _input_fullscreen,
	[_action_id_key_esc] = _input_escape,
	[_action_id_key_w] = _input_up,
	[_action_id_key_a] = _input_left,
	[_action_id_key_s] = _input_down,
	[_action_id_key_d] = _input_right,
	[_action_id_mouse_button_left] = _input_mouse_button_left,
	[_action_id_mouse_button_right] = _input_mouse_button_right
}

local _states =
{
	[_input_fullscreen] = _state_up,
	[_input_escape] = _state_up,
	[_input_up] = _state_up,
	[_input_left] = _state_up,
	[_input_down] = _state_up,
	[_input_right] = _state_up,
	[_input_mouse_button_left] = _state_up,
	[_input_mouse_button_right] = _state_up
}

local _mouse_position = vmath.vector3()
local _mouse_delta_position = vmath.vector3()
local _mouse_delta_scroll = 0

--------------------------------------------------------------------------------
-- Public Variables
--------------------------------------------------------------------------------

m_input.input_fullscreen = _input_fullscreen
m_input.input_escape = _input_escape
m_input.input_up = _input_up
m_input.input_left = _input_left
m_input.input_down = _input_down
m_input.input_right = _input_right
m_input.input_mouse_button_left = _input_mouse_button_left
m_input.input_mouse_button_right = _input_mouse_button_right

m_input.state_up = _state_up
m_input.state_pressed = _state_pressed
m_input.state_down = _state_down
m_input.state_released = _state_released

--------------------------------------------------------------------------------
-- Private Functions
--------------------------------------------------------------------------------

local function move_mouse(screen_x, screen_y)
	local world_position = m_starly.screen_to_world(m_camera.object, screen_x, screen_y, true)
	if world_position then
		_mouse_delta_position = world_position - _mouse_position
		_mouse_position = world_position
	end
end

--------------------------------------------------------------------------------
-- Public Functions
--------------------------------------------------------------------------------

function m_input.on_input(action_id, action)
	if not action_id then
		move_mouse(action.screen_x, action.screen_y)
	elseif action_id == _action_id_mouse_wheel_up and action.pressed then
		_mouse_delta_scroll = 1
	elseif action_id == _action_id_mouse_wheel_down and action.pressed then
		_mouse_delta_scroll = -1
	else
		local input = _bindings[action_id]
		if input then
			if action.pressed then
				_states[input] = _state_pressed
			elseif action.released then
				_states[input] = _state_released
			end
		end
	end
end

function m_input.update()
	for input, state in pairs(_states) do
		if state == _state_pressed then
			_states[input] = _state_down
		elseif state == _state_released then
			_states[input] = _state_up
		end
	end
	_mouse_delta_position = vmath.vector3()
	_mouse_delta_scroll = 0
end

function m_input.get_state(input)
	return _states[input]
end

function m_input.is_state_active(input)
	return _states[input] == _state_down or _states[input] == _state_pressed
end

function m_input.is_state_inactive(input)
	return _states[input] == _state_up or _states[input] == _state_released
end

function m_input.get_mouse_position()
	return _mouse_position
end

function m_input.get_mouse_delta_position()
	return _mouse_delta_position
end

function m_input.get_mouse_delta_scoll()
	return _mouse_delta_scroll
end

return m_input