local m_direction = {}

--------------------------------------------------------------------------------
-- Public Variables
--------------------------------------------------------------------------------

m_direction.down = hash("down")
m_direction.up = hash("up")
m_direction.left = hash("left")
m_direction.right = hash("right")

m_direction.directions =
{
	m_direction.down,
	m_direction.up,
	m_direction.left,
	m_direction.right
}

return m_direction