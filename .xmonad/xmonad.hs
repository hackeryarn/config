--Import statements
import XMonad
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.UrgencyHook
import XMonad.Util.Run
import System.IO

--Define the names of all workspaces
myWorkspaces = ["main","web","chat","media","browse","dev","mail","game"]

main = do
xmproc <- spawnPipe "/usr/bin/xmobar /home/artem/.xmobarrc"
xmonad $ defaultConfig {
    startupHook = do
        spawn "xflux -z 63303"
    , workspaces = myWorkspaces
    , manageHook = manageDocks <+> manageHook defaultConfig
    , layoutHook = avoidStruts $ layoutHook defaultConfig
    , logHook = dynamicLogWithPP xmobarPP
        { ppOutput = hPutStrLn xmproc
        , ppTitle = xmobarColor "green" "" . shorten 50
        }
    , modMask = mod4Mask     -- Rebind Mod to the Windows key
    } `additionalKeys`
    [ ((mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -l")
    ]
