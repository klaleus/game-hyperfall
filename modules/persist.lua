local m_persist = {}

--------------------------------------------------------------------------------
-- Private Variables
--------------------------------------------------------------------------------

local _project_title = sys.get_config_string("project.title")

--------------------------------------------------------------------------------
-- Public Variables
--------------------------------------------------------------------------------

m_persist.file_settings = "settings.json"

--------------------------------------------------------------------------------
-- Private Functions
--------------------------------------------------------------------------------

local function is_json_file(file_name)
	local result = string.match(file_name, "%.json$") and true or false
	return result
end

local function load_json_file(file_path)
	local file_handle = io.open(file_path, "r")
	if not file_handle then
		return
	end
	local file_text = file_handle:read("*all")
	file_handle:close()
	local success, data = pcall(json.decode, file_text)
	if not success then
		return
	end
	return data
end

local function load_native_file(file_path)
	local data = sys.load(file_path)
	if not next(data) then
		return
	end
	return data
end

local function save_json_file(file_path, data)
	local file_text = json.encode(data)
	local file_handle = io.open(file_path, "w")
	if not file_handle then
		return
	end
	local success = file_handle:write(file_text)
	if not success then
		return
	end
	file_handle:close()
	return true
end

local function save_native_file(file_path, data)
	local result = sys.save(file_path, data)
	return result
end

--------------------------------------------------------------------------------
-- Public Functions
--------------------------------------------------------------------------------

function m_persist.exists(file_name)
	local file_path = sys.get_save_file(_project_title, file_name)
	local result = sys.exists(file_path)
	return result
end

function m_persist.load(file_name)
	local file_path = sys.get_save_file(_project_title, file_name)
	if is_json_file(file_name) then
		return load_json_file(file_path)
	else
		return load_native_file(file_path)
	end
end

function m_persist.save(file_name, data)
	local file_path = sys.get_save_file(_project_title, file_name)
	if is_json_file(file_name) then
		save_json_file(file_path, data)
	else
		save_native_file(file_path, data)
	end
end

return m_persist