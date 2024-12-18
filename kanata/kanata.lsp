;; Caps to escape/control configuration for Kanata

(defcfg
  ;; list devices explicitly to prevent problems with bluetooth mouse
  macos-dev-names-include (
    "Apple Internal Keyboard / Trackpad"
    "TouchBarUserDevice"
    )
  ;; also manage keys not in defsrc list
  process-unmapped-keys yes
  )
  
(defsrc
  esc f1   f2   f3   f4   f5   f6   f7   f8   f9   f10   f11   f12
  caps a s d f j k l ;
)

(defvar
  tap-time 150
  hold-time 200
)

(defalias
  cw (caps-word 5000)
  escctrl (tap-hold 100 100 esc lctl)
  ;; trigger a tap when rolling within the timeout (unless second key is released first)
  ;; don't trigger hold for keys from same side ("bilateral combinations")
  a (tap-hold-release-keys $tap-time $hold-time a lalt (q w e r t a s d f g z x c v b))
  s (tap-hold-release-keys $tap-time $hold-time s lctl (q w e r t a s d f g z x c v b))
  d (tap-hold-release-keys $tap-time $hold-time d lmet (q w e r t a s d f g z x c v b))
  f (tap-hold-release-keys $tap-time $hold-time f lsft (q w e r t a s d f g z x c v b))
  j (tap-hold-release-keys $tap-time $hold-time j rsft (y u i o p h j k l ; n m , . /))
  k (tap-hold-release-keys $tap-time $hold-time k rmet (y u i o p h j k l ; n m , . /))
  l (tap-hold-release-keys $tap-time $hold-time l rctl (y u i o p h j k l ; n m , . /))
  ; (tap-hold-release-keys $tap-time $hold-time ; ralt (y u i o p h j k l ; n m , . /))
)

(deflayer base
  @cw brdn  brup  _    _    _    _   prev  pp  next  mute  vold  volu
  @escctrl @a @s @d @f @j @k @l @;
)

(deflayer fn
  @cw f1   f2   f3   f4   f5   f6   f7   f8   f9   f10   f11   f12
  @escctrl _ _ _ _ _ _ _ _
)
