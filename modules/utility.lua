local m_utility = {}

--------------------------------------------------------------------------------
-- Public Variables
--------------------------------------------------------------------------------

m_utility.direction_down = hash("down")
m_utility.direction_up = hash("up")
m_utility.direction_left = hash("left")
m_utility.direction_right = hash("right")

m_utility.directions =
{
	m_utility.direction_down,
	m_utility.direction_up,
	m_utility.direction_left,
	m_utility.direction_right
}

--------------------------------------------------------------------------------
-- Public Functions
--------------------------------------------------------------------------------

function m_utility.tile_to_pixel(pixel_position, tile_size)
	local result = vmath.vector3(math.floor(pixel_position.x / tile_size) + 1, math.floor(pixel_position.y / tile_size) + 1, pixel_position.z)
	return result
end

function m_utility.pixel_to_tile(tile_position, tile_size)
	local result = vmath.vector3(tile_position.x * tile_size - tile_size * 0.5, tile_position.y * tile_size - tile_size * 0.5, tile_position.z)
	return result
end

return m_utility