dofile("ecs.lua")

function love.keypressed(key)
    if key == "escape" then
        print("so long folks!")
        love.event.quit()
    end
end

-- button entity component system
local buttons

--[[
    the button which will be a different color when selected
    is a number because it utilizes a pointer jump in the ecs
    starting point is whatever 1 is
]]--

local current_selection = 1


-- loader function, called on engine load
function love.load()

    -- initialize the buttons ecs
    buttons = ecs:new()

    -- add required componentes for testing
    buttons:add_components({
        "size_x",
        "size_y",
        "position_x",
        "position_y",
        "center_x",
        "center_y"
    })





end

-- update loop, the engine loop process
function love.update(delta)

end

-- draw loop, the engine opengl draw loop
function love.draw()

end