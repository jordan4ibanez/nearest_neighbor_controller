function love.keypressed(key)
    if key == "escape" then
        print("so long folks!")
        love.event.quit()
    end
end

-- button entity component system
local buttons

-- loader function, called on engine load
function love.load()

    buttons = ecs:new()

    buttons:add_components({
        "size_x",
        "size_y",
        "position_x",
        "position_y"
    })

end

-- update loop, the engine loop process
function love.update(delta)

end

-- draw loop, the engine opengl draw loop
function love.draw()

end