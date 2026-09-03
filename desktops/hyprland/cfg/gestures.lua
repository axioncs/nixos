hl.config({
    animations = { enabled = true },
    gestures = {
        workspace_swipe_distance = 700,
        workspace_swipe_cancel_ratio = 0.15,
        workspace_swipe_min_speed_to_force = 5,
        workspace_swipe_direction_lock = true,
        workspace_swipe_direction_lock_threshold = 10,
        workspace_swipe_create_new = true,
    },
})
hl.gesture({ fingers = 3, direction = "vertical", action = "workspace" })
hl.gesture({ fingers = 3, direction = "horizontal", action = "scroll_move" })
