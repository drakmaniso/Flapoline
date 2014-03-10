function love.conf(t)
    t.identity = "Flapoline"
    t.console = false

    t.window.title = "Flapoline"
    t.window.icon = "data/acrobat_6_3.png"
    t.window.width = 1280
    t.window.height = 720
    t.window.resizable = true
    t.window.minwidth = 16
    t.window.minheight = 9
    t.window.fullscreen = false
    t.window.fullscreentype = "desktop"
    t.window.vsync = true

    t.modules.joystick = false
    t.modules.physics = false
end
