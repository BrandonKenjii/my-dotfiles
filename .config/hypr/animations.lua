-- Animations

hl.config({
    animations = {
        enabled = true,
    },
})

-- Bezier curves
hl.curve("easeOut",   { type = "bezier", points = { { 0.25, 1 },    { 0.5, 1 }    } })
hl.curve("easeInOut", { type = "bezier", points = { { 0.76, 0 },    { 0.24, 1 }   } })
hl.curve("bounce",    { type = "bezier", points = { { 0.34, 1.56 }, { 0.64, 1 }   } })
hl.curve("smooth",    { type = "bezier", points = { { 0.4, 0 },     { 0.2, 1 }    } })
hl.curve("snappy",    { type = "bezier", points = { { 0.17, 0.17 }, { 0, 1 }      } })

hl.curve("easeOutQuint",   { type = "bezier", points = { { 0.23, 1 },    { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear",         { type = "bezier", points = { { 0, 0 },       { 1, 1 }    } })
hl.curve("almostLinear",   { type = "bezier", points = { { 0.5, 0.5 },   { 0.75, 1 } } })
hl.curve("quick",          { type = "bezier", points = { { 0.15, 0 },    { 0.1, 1 }  } })

-- Window animations
hl.animation({ leaf = "windows",     enabled = true, speed = 4,   bezier = "easeOut",   style = "slide" })
hl.animation({ leaf = "windowsOut",  enabled = true, speed = 4,   bezier = "easeInOut", style = "slide" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 4,   bezier = "easeOut",   style = "slide" })
hl.animation({ leaf = "windowsIn",   enabled = true, speed = 4.1, bezier = "easeOutQuint", style = "popin 87%" })

-- Workspace switch animation (windows slide left/right)
hl.animation({ leaf = "workspaces",    enabled = true, speed = 5,    bezier = "easeOut",     style = "slide" })
hl.animation({ leaf = "workspacesIn",  enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })

-- Fade in/out
hl.animation({ leaf = "fade",    enabled = true, speed = 4,    bezier = "easeOut" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 3,    bezier = "easeInOut" })
hl.animation({ leaf = "fadeIn",  enabled = true, speed = 1.73, bezier = "almostLinear" })

-- Border color transition
hl.animation({ leaf = "border",      enabled = true, speed = 6,   bezier = "easeOut" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 100, bezier = "easeOut", style = "loop" })

-- Layer animations (waybar, notifications, etc.)
hl.animation({ leaf = "layers",        enabled = true, speed = 3,    bezier = "easeOut",     style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true, speed = 2,    bezier = "easeInOut",   style = "fade" })
hl.animation({ leaf = "layersIn",      enabled = true, speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })

-- Global defaults
hl.animation({ leaf = "global",     enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7,  bezier = "quick" })
