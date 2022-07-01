dofile("dump.lua")
dofile("ecs.lua")

-- button entity component system
local buttons

--[[
    the button which will be a different color when selected
    is a number because it utilizes a pointer jump in the ecs
    starting point is whatever 1 is
]]--

local current_selection = 1


-- api to process nearest neighbor to the button - direction is a string literal

-- contains calculations for nearest neighbor

local function get_nearest_neighbor(entity_table)

end

local function process_button_switch(direction)

    -- accomodate only required components
    local center_x = buttons:get_component("center_x")
    local center_y = buttons:get_component("center_y")
    local max_buttons = buttons.entity_count

    -- cache current location
    local current_x = center_x[current_selection]
    local current_y = center_y[current_selection]

    -- collection table for possible choices
    local possible_buttons = {}

    -- negative (-) X axis
    if direction == "left" then
        for i = 1,max_buttons do
            if i ~= current_selection then
                if center_x[i] < current_x then
                    table.insert(possible_buttons, i)
                end
            end
        end


    -- positive (+) X axis
    elseif direction == "right" then
        print("right")

    -- negative (-) Y axis - canvas starts at 0 top
    elseif direction == "up" then
        print("up")

    -- positive (+) Y axis - canvas starts at 0 top
    elseif direction == "down" then
        print("down")
    end
end

-- user input

-- multiprocessor, equalizes keyboard and controller
local function process_keyboard_and_joystick(key)
    if key == "escape" then
        print("so long folks!")
        love.event.quit()
    end

    if key == "space" then
        local text = buttons:get_component("text")

        print("the button is: " .. text[current_selection])

        if text[current_selection] == "quit" then
            print("so long folks!")
            love.event.quit()
        end
    end

    if key == "up" or key == "down" or key == "left" or key == "right" then
        process_button_switch(key)
    end
end

-- keyboard - direct function input
function love.keypressed(key)
    process_keyboard_and_joystick(key)
end

-- controller - reinterpreted input
function love.gamepadpressed(joystick, button)
    if button == "dpup" or button == "dpdown" or button == "dpleft" or button == "dpright" then
        process_button_switch(button:sub(3))
    end
end

function love.gamepadpressed(joystick, button)
    if button == "a" then
        process_keyboard_and_joystick("space")
    elseif button == "b" then
        process_keyboard_and_joystick("escape")
    end
end

-- a basic api funcion for quickly adding buttons
local function add_button(button_table)

    -- no assertions this is just a test, also there's probably a better way to do this besides localizing

    local text, size_x, size_y, position_x, position_y
    =
    button_table.text, button_table.size_x, button_table.size_y, button_table.position_x, button_table.position_y

    local center_x = position_x + (size_x / 2)
    local center_y = position_y + (size_y / 2)

    buttons:add_entity({
        text = text,
        size_x = size_x,
        size_y = size_y,
        position_x = position_x,
        position_y = position_y,
        center_x = center_x,
        center_y = center_y
    })
end


-- loader function, called on engine load
function love.load()

    -- initialize the buttons ecs
    buttons = ecs:new()

    -- add required componentes for testing
    buttons:add_components({
        "text",
        "size_x",
        "size_y",
        "position_x",
        "position_y",
        "center_x",
        "center_y"
    })

    -- add some buttons in for testing

    add_button({
        text = "my_test_1",
        size_x = 100,
        size_y = 50,
        position_x = 100,
        position_y = 20
    })

    add_button({
        text = "blarf",
        size_x = 50,
        size_y = 50,
        position_x = 200,
        position_y = 70
    })

    add_button({
        text = "wow a button",
        size_x = 200,
        size_y = 70,
        position_x = 500,
        position_y = 200
    })

    add_button({
        text = "blep",
        size_x = 50,
        size_y = 50,
        position_x = 74,
        position_y = 222
    })


    -- randomize which button is selected
    math.randomseed(os.time())
    current_selection = math.random(1,buttons.entity_count)
end

-- update loop, the engine loop process
function love.update(delta)

end


local function draw_buttons()
    -- only get components needed for drawing
    local size_x = buttons:get_component("size_x")
    local size_y = buttons:get_component("size_y")
    local position_x = buttons:get_component("position_x")
    local position_y = buttons:get_component("position_y")
    local text = buttons:get_component("text")

    -- draw background first - entity count is internal to ecs class
    for i = 1,buttons.entity_count do

        -- selected button is red
        if i == current_selection then
            love.graphics.setColor(1, 0, 0, 1)
        else
        -- unselected button is gray
            love.graphics.setColor(0.5,0.5,0.5,1)
        end

        love.graphics.rectangle( "fill", position_x[i], position_y[i], size_x[i], size_y[i], 5, 5 )
    end


    -- reset the color to black for text
    love.graphics.setColor(0,0,0,1)

    -- draw text last
    for i = 1,buttons.entity_count do
        love.graphics.print( text[i], position_x[i] + 3, position_y[i] + 3)
    end

end

-- draw loop, the engine opengl draw loop
function love.draw()
    draw_buttons()
end