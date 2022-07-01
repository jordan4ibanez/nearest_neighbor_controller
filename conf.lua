-- conf where t is engine configuration table
function love.conf(t)

    -- built for love 11.4
    t.version = "11.4"

    -- basic 720p for debug
    t.window.width = 1280
    t.window.height = 720

    -- tell love2d to load it regardless of internal settings
    t.modules.joystick = true

end