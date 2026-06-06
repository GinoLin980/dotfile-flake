{ ... }: {
  xdg.configFile."hypr/hyprland.conf".text = ''
    ################
    ### MONITORS ###
    ################

    monitor=,preferred,auto,1
    ecosystem:no_update_news = true


    ###################
    ### MY PROGRAMS ###
    ###################

    $terminal = ghostty
    $vol = pamixer --get-volume


    #################
    ### AUTOSTART ###
    #################

    exec-once = bash -c 'eww open bar_widget && eww update get_vol="$(pamixer --get-volume)" && ~/.config/eww/scripts/getvol.sh'
    exec-once = hyprpaper &
    exec-once = hypridle

    #############################
    ### ENVIRONMENT VARIABLES ###
    #############################

    env = XCURSOR_THEME,miku-cursor
    env = XCURSOR_SIZE,32
    env = HYPRCURSOR_SIZE,32
    env = XCURSOR_PATH,/usr/share/icons:/home/$USER/.icons:/home/$USER/.local/share/icons
    env = HYPRCURSOR_MOVE,fleur

    #####################
    ### LOOK AND FEEL ###
    #####################

    general {
        gaps_in = 3
        gaps_out = 5
        border_size = 3
        col.active_border = rgba(23,147,209,0.5)
        col.inactive_border = rgba(0,0,0,0)
        resize_on_border = true
        allow_tearing = false
        layout = dwindle
    }

    decoration {
        rounding = 10
        rounding_power = 2
        active_opacity = 1.0
        inactive_opacity = 0.97

        shadow {
            enabled = true
            range = 40
            render_power = 3
            color = rgba(1a1a1aee)
        }

        blur {
            enabled = true
            size = 3
            passes = 1
            vibrancy = 0.1696
        }
    }

    animations {
        enabled = true
        bezier = easeOutQuint,0.23,1,0.32,1
        bezier = easeInOutCubic,0.65,0.05,0.36,1
        bezier = linear,0,0,1,1
        bezier = almostLinear,0.5,0.5,0.75,1.0
        bezier = quick,0.15,0,0.1,1

        animation = global, 1, 10, default
        animation = border, 1, 5.39, easeOutQuint
        animation = windows, 1, 4.79, easeOutQuint
        animation = windowsIn, 1, 4.1, easeOutQuint, popin 87%
        animation = windowsOut, 1, 1.49, linear, popin 87%
        animation = fadeIn, 1, 1.73, almostLinear
        animation = fadeOut, 1, 1.46, almostLinear
        animation = fade, 1, 3.03, quick
        animation = layers, 1, 3.81, easeOutQuint
        animation = layersIn, 1, 4, easeOutQuint, fade
        animation = layersOut, 1, 1.5, linear, fade
        animation = fadeLayersIn, 1, 1.79, almostLinear
        animation = fadeLayersOut, 1, 1.39, almostLinear
        animation = workspaces, 1, 3, easeOutQuint, slide
        animation = workspacesIn, 1, 3, easeOutQuint, slide
        animation = workspacesOut, 1, 3, easeOutQuint, slide
    }

    dwindle {
        pseudotile = true
        preserve_split = true
    }

    master {
        new_status = master
    }

    misc {
        force_default_wallpaper = 1
        disable_hyprland_logo = true
    }


    #############
    ### INPUT ###
    #############

    input {
        kb_layout = us,th
        kb_variant =
        kb_model =
        kb_options =
        kb_rules =
        follow_mouse = 1
        sensitivity = 0

        touchpad {
            natural_scroll = true
        }
    }

    gestures {
        workspace_swipe = false
    }

    device {
        name = epic-mouse-v1
        sensitivity = -0.5
    }


    ###################
    ### KEYBINDINGS ###
    ###################

    $mainMod = SUPER

    bind = $mainMod, Q, exec, $terminal
    bind = $mainMod, W, exec, hyprctl dispatch togglefloating
    bind = $mainMod, A, exec, grim -g "$(slurp)" ~/Pictures/Screenshots/screenshot.jpg
    bind = $mainMod, E, killactive,
    bind = $mainMod, M, exit,
    bind = $mainMod, F, exec, ghostty -- ranger
    bind = $mainMod, V, togglefloating,
    bind = $mainMod, space, exec, sh -c "hyprctl switchxkblayout at-translated-set-2-keyboard next"
    bind = $mainMod, P, pseudo,
    bind = $mainMod, J, togglesplit,

    bind = $mainMod, left, movefocus, l
    bind = $mainMod, right, movefocus, r
    bind = $mainMod, up, movefocus, u
    bind = $mainMod, down, movefocus, d

    bind = $mainMod, 1, workspace, 1
    bind = $mainMod, 2, workspace, 2
    bind = $mainMod, 3, workspace, 3
    bind = $mainMod, 4, workspace, 4
    bind = $mainMod, 5, workspace, 5
    bind = $mainMod, 6, workspace, 6
    bind = $mainMod, 0, workspace, 10

    bind = $mainMod SHIFT, 1, movetoworkspace, 1
    bind = $mainMod SHIFT, 2, movetoworkspace, 2
    bind = $mainMod SHIFT, 3, movetoworkspace, 3
    bind = $mainMod SHIFT, 4, movetoworkspace, 4
    bind = $mainMod SHIFT, 5, movetoworkspace, 5
    bind = $mainMod SHIFT, 6, movetoworkspace, 6
    bind = $mainMod SHIFT, 0, movetoworkspace, 10

    bind = $mainMod, S, togglespecialworkspace, magic
    bind = $mainMod SHIFT, S, movetoworkspace, special:magic

    bind = $mainMod, mouse_down, workspace, e+1
    bind = $mainMod, mouse_up, workspace, e-1

    bindm = $mainMod, mouse:272, movewindow
    bindm = $mainMod, mouse:273, resizewindow

    bindel = ,XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+
    bindel = ,XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
    bindel = ,XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
    bindel = ,XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
    bindel = ,XF86MonBrightnessUp, exec, brightnessctl s 10%+
    bindel = ,XF86MonBrightnessDown, exec, brightnessctl s 10%-

    bindl = , XF86AudioNext, exec, playerctl next
    bindl = , XF86AudioPause, exec, playerctl play-pause
    bindl = , XF86AudioPlay, exec, playerctl play-pause
    bindl = , XF86AudioPrev, exec, playerctl previous


    ##############################
    ### WINDOWS AND WORKSPACES ###
    ##############################

    windowrulev2 = suppressevent maximize, class:.*
    windowrulev2 = nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0
  '';
}
