local m_proxy = {}

--------------------------------------------------------------------------------
-- Private Variables
--------------------------------------------------------------------------------

local _message_load = hash("load")
local _message_init = hash("init")
local _message_enable = hash("enable")

local _message_disable = hash("disable")
local _message_final = hash("final")
local _message_unload = hash("unload")

local _message_set_time_step = hash("set_time_step")

--------------------------------------------------------------------------------
-- Public Variables
--------------------------------------------------------------------------------

m_proxy.proxy_scene = hash("proxy_scene")

--------------------------------------------------------------------------------
-- Private Functions
--------------------------------------------------------------------------------

local function get_url(id)
	local url = msg.url("main", "/main", id)
	return url
end

--------------------------------------------------------------------------------
-- Public Functions
--------------------------------------------------------------------------------

function m_proxy.load(id)
	local url = get_url(id)
	msg.post(url, _message_load)
end

function m_proxy.init(id)
	local url = get_url(id)
	msg.post(url, _message_init)
end

function m_proxy.enable(id)
	local url = get_url(id)
	msg.post(url, _message_enable)
end

function m_proxy.disable(id)
	local url = get_url(id)
	msg.post(url, _message_disable)
end

function m_proxy.final(id)
	local url = get_url(id)
	msg.post(url, _message_final)
end

function m_proxy.unload(id)
	local url = get_url(id)
	msg.post(url, _message_unload)
end

function m_proxy.time_step(id, factor, continuous)
	local url = get_url(id)
	local mode = continuous and 0 or 1
	local args =
	{
		factor = factor,
		mode = mode
	}
	msg.post(url, _message_set_time_step, args)
end

return m_proxy