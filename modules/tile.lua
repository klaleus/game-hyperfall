local m_tile = {}

--------------------------------------------------------------------------------
-- Private Variables
--------------------------------------------------------------------------------

local _tile_white_01 = hash("tile_white_01")
local _tile_white_02 = hash("tile_white_02")
local _tile_white_03 = hash("tile_white_03")
local _tile_white_04 = hash("tile_white_04")
local _tile_white_05 = hash("tile_white_05")
local _tile_white_06 = hash("tile_white_06")
local _tile_white_07 = hash("tile_white_07")
local _tile_white_08 = hash("tile_white_08")
local _tile_white_09 = hash("tile_white_09")
local _tile_white_10 = hash("tile_white_10")
local _tile_white_11 = hash("tile_white_11")
local _tile_white_12 = hash("tile_white_12")
local _tile_white_13 = hash("tile_white_13")
local _tile_white_14 = hash("tile_white_14")
local _tile_white_15 = hash("tile_white_15")

local _tile_data =
{
	[_tile_white_01] =
	{
		animation = hash("tile_white_01")
	},
	[_tile_white_02] =
	{
		animation = hash("tile_white_02")
	},
	[_tile_white_03] =
	{
		animation = hash("tile_white_03")
	},
	[_tile_white_04] =
	{
		animation = hash("tile_white_04")
	},
	[_tile_white_05] =
	{
		animation = hash("tile_white_05")
	},
	[_tile_white_06] =
	{
		animation = hash("tile_white_06")
	},
	[_tile_white_07] =
	{
		animation = hash("tile_white_07")
	},
	[_tile_white_08] =
	{
		animation = hash("tile_white_08")
	},
	[_tile_white_09] =
	{
		animation = hash("tile_white_09")
	},
	[_tile_white_10] =
	{
		animation = hash("tile_white_10")
	},
	[_tile_white_11] =
	{
		animation = hash("tile_white_11")
	},
	[_tile_white_12] =
	{
		animation = hash("tile_white_12")
	},
	[_tile_white_13] =
	{
		animation = hash("tile_white_13")
	},
	[_tile_white_14] =
	{
		animation = hash("tile_white_14")
	},
	[_tile_white_15] =
	{
		animation = hash("tile_white_15")
	}
}

--------------------------------------------------------------------------------
-- Public Variables
--------------------------------------------------------------------------------

m_tile.tile_size= 8

m_tile.tile_white_01 = _tile_white_01
m_tile.tile_white_02 = _tile_white_02
m_tile.tile_white_03 = _tile_white_03
m_tile.tile_white_04 = _tile_white_04
m_tile.tile_white_05 = _tile_white_05
m_tile.tile_white_06 = _tile_white_06
m_tile.tile_white_07 = _tile_white_07
m_tile.tile_white_08 = _tile_white_08
m_tile.tile_white_09 = _tile_white_09
m_tile.tile_white_10 = _tile_white_10
m_tile.tile_white_11 = _tile_white_11
m_tile.tile_white_12 = _tile_white_12
m_tile.tile_white_13 = _tile_white_13
m_tile.tile_white_14 = _tile_white_14
m_tile.tile_white_15 = _tile_white_15

--------------------------------------------------------------------------------
-- Public Functions
--------------------------------------------------------------------------------

function m_tile.create(tile)
	local factory_url = msg.url(nil, nil, "factory_tile")
	local object = factory.create(factory_url)
	local sprite_url = msg.url(nil, object, "sprite")
	local tile_data = _tile_data[tile]
	sprite.play_flipbook(sprite_url, tile_data.animation)
	return object
end

function m_tile.pixel_to_snap(pixel_position)
	local tile_position = m_tile.pixel_to_tile(pixel_position)
	local snapped_position = m_tile.tile_to_pixel(tile_position)
	return snapped_position
end

function m_tile.pixel_to_tile(pixel_position)
	local tile_position = vmath.vector3(math.floor(pixel_position.x / m_tile.tile_size) + 1, math.floor(pixel_position.y / m_tile.tile_size) + 1, pixel_position.z)
	return tile_position
end

function m_tile.tile_to_pixel(tile_position)
	local pixel_position = vmath.vector3(tile_position.x * m_tile.tile_size - m_tile.tile_size * 0.5, tile_position.y * m_tile.tile_size - m_tile.tile_size * 0.5, tile_position.z)
	return pixel_position
end

return m_tile