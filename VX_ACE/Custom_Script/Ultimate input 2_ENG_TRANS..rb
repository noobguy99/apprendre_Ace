=begin
  
DịchTắt dịch nhanh
Tiếng AzerbaijanTiếng AnhTiếng PhápPhát hiện ngôn ngữTiếng Hà LanTiếng AnhTiếng PhápDịch

Input Ultimate 2.3 by Zeus81
  Free for non-commercial use
  
  Pour simplement régler les touches sans vouloir en savoir plus, aller ligne 1471.
  
REFERENCES
  Input :
    Constantes :
      REPEAT : Permet de régler la façon dont la méthode repeat? fonctionne, ligne 1417.
      PLAYERS_MAX : Le nombre de joueurs gérés par le script, à configurer ligne 1424.
      KEYS_MAX : Définit une limite pour optimiser la mémoire, ligne 1425.
      Players : La liste des contrôles joueurs.
      Gamepads : La liste des manettes détectées.
    Méthodes :
      Input.update : A appeler une fois par frame pour tout mettre à jour.
      Input.refresh : Détecte les manettes connectées au PC.
      Input[i] : Retourne le contrôle du joueur i (commence à 0).
                 Le premier Player est fusionné avec le module Input
                 Faire Input.trigger?(k) équivaut à faire Input[0].trigger?(k)
      
  Device :
      Base commune à Player, Gamepad, Keyboard et Mouse
    Propriétés :
      enabled : Permet d'activer ou désactiver un contrôle.
                Par exemple si on fait un jeu multijoueur mais qu'on joue en solo
                on peut désactiver les autres joueurs pour optimiser les perfs.
                Par défaut tous les contrôles sont activés sauf la souris et les
                manettes non utilisées.
      ntrigger_max : Option de la fonction ntrigger? décrite plus en dessous.
                     C'est ce qui est utilisé pour les doubles clics de la souris.
                     Par défaut cette option est désactivée (égale à 0) sauf
                     pour la souris où elle est égale à 3 (pour les triples clic).
                     Cette limite sert à faire boucler les clics, par exemple là
                     si je fais 5 clics ça sera considéré comme un triple clic
                     suivi d'un double clic.
      ntrigger_time : Temps en nombre de frames pouvant s'écouler entre deux
                      clics pour être considérés comme une série de clics.
                      Si on met 0 ce temps sera le même que dans Windows. (Défaut)
    Méthodes :
      press?(*a) : Retourne true si la touche est pressée sinon false.
                   La fonction peut être utilisée de plusieurs façons :
                    Input.press?(Input::C)
                    Input.press?(:C)
                    Input.press?('C')
                    Input.press?(13)
                    Input::C.press?
                   Tout ceci revient au même, cela dit en terme de performance
                    Input::C.press? est deux fois plus rapide que les autres.
                   On peut aussi mettre plusieurs touches à la fois :
                    Input.press?(:A, :B, :C) = :A or :B or :C
                   En regroupant des touches dans un tableaux on inverse or/and :
                    Input.press?([:A, :B, :C]) = :A and :B and :C
                   On peut mélanger les deux :
                    Input.press?(:A, [:B, :C]) = :A or (:B and :C)
                   Et mettre plusieurs niveaux de tableaux :
                    Input.press?([:A, [:B, :C]]) = :A and (:B or :C)
                   En plus des tableaux on peut aussi utiliser des Range :
                    Input.press?(:A..:C) = Input.press?([:A, :B, :C])
                    Input.press?(*:A..:C) = Input.press?(:A, :B, :C)
                   Oui je sais, tout ça ne servira absolument à rien.
      trigger?(*a) : Retourne true si la touche vient d'être pressée.
                     Pour les arguments fonctionne comme press?
      release?(*a) : Retourne true si la touche vient d'être relâchée.
                     Pour les arguments fonctionne comme press?
      repeat?(*a) : Retourne true ou false selon le schéma de REPEAT
                    Pour les arguments fonctionne comme press?
      ntrigger?(n,*a) : Retourne true si la touche vient d'être pressée comme
                        trigger? mais en comptant le nombre de fois.
                        Mouse.ntrigger?(2, :Left) retournera true uniquement si
                        on fait un double clic, si ensuite on fait un troisième
                        clic seul Mouse.ntrigger?(3, :Left) retournera true.
                        n doit être inférieur ou égal à ntrigger_max
                        Pour les arguments fonctionne comme press?
      count(k) : Retourne le temps en nombre de frames depuis quand la touche k
                 est pressée, 0 si elle n'est pas pressée.
                 Comme pour le reste k peut être égal à Input::C, :C, 'C', 13.
                 Et on peut aussi écrire Input::C.count
      key(i) : Retourne la touche Key ayant pour id i.
               Ici aussi i peut être un symbole, string, nombre (:C, 'C', 13).
      capture_key(*exclude) : Si jamais vous faites un menu pour configurer les
                              touches utilisez cette fonction pour attendre
                              que le joueur appuie comme ceci :
                           

4986/5000
185 ký tự trên 5000 tối đa:DỊCH KHÁC
= Keyboard.capture_key || Input.gamepad.capture_key Graphics.update Input.update end
Input Ultimate 2.3 by Zeus81
  Free for non-commercial use
  
  To simply adjust the keys without wanting to know more, go line 1471.
  
REFERENCES
  Input:
    Constants:
      REPEAT: Set how the repeat method works? Operates, line 1417.
      PLAYERS_MAX: The number of players managed by the script, to configure line 1424.
      KEYS_MAX: Sets a limit to optimize memory, line 1425.
      Players: The list of player controls.
      Gamepads: The list of joysticks detected.
    Methods :
      Input.update: Call one time per frame to update.
      Input.refresh: Detects the joysticks connected to the PC.
      Input [i]: Returns control of player i (starts at 0).
                 The first Player is merged with the Input module
                 Making Input.trigger? (K) is equivalent to doing Input [0] .trigger? (K)
      
  Device:
      Common Base to Player, Gamepad, Keyboard and Mouse
    Properties:
      Enabled: Enable or disable a control.
                For example if you make a multiplayer game but you play solo
                We can disable the other players to optimize the perfs.
                By default all controls are enabled except the mouse and
                Joysticks not used.
      Ntrigger_max: ntrigger function option? Described below.
                     This is what is used for double clicks of the mouse.
                     By default this option is disabled (equal to 0) except
                     For the mouse where it is equal to 3 (for triple clicks).
                     This limit is used for looping clicks, for example
                     If I make 5 clicks it will be considered a triple click
                     Followed by a double click.
      Ntrigger_time: The number of frames that can elapse between two
                      Clicks to be considered a series of clicks.
                      If you put 0 this time will be the same as in Windows. (Default)
    Methods :
      Press? (* A): Returns true if the key is pressed otherwise false.
                   The function can be used in several ways:
                    Input.press?(Input::C)
                    Input.press?(:C)
                    Input.press?('C ')
                    Input.press?(13)
                    Input :: C.press?
                   All this amounts to the same, in terms of performance
                    Input :: C.press? Is twice as fast as the others.
                   You can also put several keys at once:
                    Input.press?(:A,: B,: C) =: A or B: C
                   By grouping keys in an inverse or / and table:
                    Input.press?([:A,: B,: C]) =: A and: B and: C
                   The two can be mixed:
                    Input.press?(:A, [: B,: C]) =: A or (: B and: C)
                   And put several levels of tables:
                    Input.press?([:A, [: B,: C]]) =: A and (: B or C)
                   In addition to the tables you can also use Range:
                    Input.press?(:A..:C) = Input.press?([:A,: B,: C])
                    Input.press?(*:A..:C) = Input.press?(:A,: B,: C)
                   Yes, I know, all that will serve absolutely nothing.
      Trigger? (* A): Returns true if the key has just been pressed.
                     For the arguments works like press?
      Release? (* A): Returns true if the key has just been released.
                     For the arguments works like press?
      Repeat? (* A): Returns true or false according to the REPEAT scheme
                    For the arguments works like press?
      Ntrigger? (N, * a): Returns true if the key has just been pressed as
                        Trigger? But counting the number of times.
                        Mouse.ntrigger? (2,: Left) will return true only if
                        We double-click, if we then do a third
                        Click only Mouse.ntrigger? (3,: Left) will return true.
                        N must be less than or equal to ntrigger_max
                        For the arguments works like press?
      Count (k): Returns the time in frames since when the k
                 Is pressed, 0 if it is not pressed.
                 As for the remainder k can be equal to Input :: C,: C, 'C', 13.
                 And we can also write Input :: C.count
      Key (i): Returns the key key with id i.
               Here also i can be a symbol, string, number (: C, 'C', 13).
      Capture_key (* exclude): If you ever make a menu to configure the
                              Keys use this function to wait
                              That the player presses like this:
                                until key = Keyboard.capture_key || Input.gamepad.capture_key
                                  Graphics.update
                                  Input.update
                                end
                              key sera un Keyboard_Key ou Gamepad_Key, vous pouvez
                              Naturally separate them if you want only one
                              Or the other.
                              Protip, before calling this method, use a
                              Release? Rather than a trigger? To prevent the
                              Key is captured. Similarly, it is
                              Then wait until the captured key is
                              Released before proceeding, which gives:
                                If Input :: C.release?
                                  Until key = Keyboard.capture_key || Input.gamepad.capture_key
                                    Graphics.update
                                    Input.update
                                  End
                                  While key and key.push?
                                    Graphics.update
                                    Input.update
                                  End
                                End
                              You can also key arguments
                              That you wish to ignore.
      
  Player <Device:
      For multiplayer games it is accessed using Input [i]
      To simplify solo games the first Player is merged with Input:
        Input.trigger? (* A) = Input [0] .trigger? (* A)
    Constants:
      A, B, C, etc ...: The keys of the virtual game (not to be confused with
                        The keyboard keys), to configure line 1433.
                        These are not numbers but Player_Key objects
                        Which allows you to do things like: Input :: C.press?
                        For multiplayer games you can also do:
                          Input :: C [i] .press? Where i is the id of the player.
    Properties:
      Id: The player id. (read only)
      Gamepad_id: Id of the gamepad, by default equal to the id of the player.
                   For the player to have no gamepad, set the value to -1.
      Gamepad: Gamepad controller associated with the player. (read only)
    Methods :
      Setup (h): Sets the relationship between the virtual keys of the game and
                 The actual keypad / joystick keys.
                 Requires a particular format, see line 1471.
      Dir4 (): Returns the pressed direction, 4-way format.
      Dir8 (): Returns the pressed direction, 8-way format.
      Dir360 (): Returns the pressed direction as an angle and a
                 Pressure (percentage between 0 and 1).
                  Angle, power = Input.dir360
                 At the base created for analog joysticks like function
                 Analog? It returns values ​​at the ends if used
                 Without analog controller.
      DirXY (): Returns the pressed direction as two axes between -1 and 1.
                  X, y = Input.dirXY
                If the stick is oriented to the left x = -1, to the right x = 1.
                If the stick is pointing down y = -1, up y = 1.
                By cons careful, the range of a joystick is not square
                (Nor round moreover, it is more a square with rounded edges)
                So if you orient the stick to the bottom left for example
                We have not x, y = -1, -1 but more x, y = -0.8, -0.8
      
  GAmepad <Device:
      There are three types of gamepad, Multimedia_Gamepad for joysticks
      Standard, XBox360_Gamepad specifically for Xbox and
      No_Gamepad when you have no controller, all have the same functions.
      The No_Gamepad class is there just so you do not have to worry about
      Whether a pad is plugged in or not before using its functions.
      For example if you want to use the vibrate function! It is used, if a
      Joystick xbox is plugged it will vibrate otherwise it will do nothing, no error.
    Constants:
      AXIS_PUSH: Analog joysticks have a pressure value between
                  0 and 32768 per direction.
                  This variable contains the value beyond which these
                  Keys will be considered pressed if you use the
                  Function press? for example.
                  By default 16384 (or 50%), configure line 679.
      AXIS_DEADZONE: The rest position of an analog joystick (in the middle)
                      Is not very stable, therefore if the
                      Analog function? We always get 0, a dead zone is
                      Established in the center of the joystick to compensate for this.
                      By default 6666 (10%), configure line 679.
      TRIGGER_PUSH: The LT and RT triggers on the XBox360 controller have a value
                     Of pressure between 0 and 255.
                     This variable contains the value beyond which these
                     Keys will be considered pressed if you use the
                     Function press? for example.
                     Default 0, configure line 679.
      Button1, Button2, etc ..: The standard keys of the joysticks, list line 681.
                                They are used only during the setup of the Player.
                                  Gamepad :: Button1
      LB, RB, etc ...: The keys of the xbox controller, list line 689.
                       They are used only during the setup of the Player.
                        XBox360_Gamepad :: A
                       This is the same as using the standard keys
                       It is just the writing that changes, use the one that
                       you prefer.
      
    Properties:
      Unplugged: Returns true if the joystick is unplugged. (read only)
                  This can be used to detect sudden loss of control.
                  If you have no joystick since the start it is not considered
                  As a joystick disconnected but as a joystick
                  No_Gamepad with unplugged = false
      Vibration: Allows to activate or not the vibrations.
    Methods :
      (* A): Returns a percentage between 0 and 1 if the key pressed is
                    (Sticks for LT RT joysticks and triggers for
                    Pads xbox) otherwise returns 0 or 1.
                    This function is there for the joysticks that said one will write
                    Never: Input.gamepad.analog? (XBox360_Gamepad :: AxisLY_0)
                    But rather: Input.analog? (Input :: DOWN)
                    The buttons on the controller are linked to the player's setup.
                    For arguments works like press ?.
      Vibrate! (Id, speed, fade_in, duration, fade_out):
                  Will vibrate the controller, do nothing if the vibrations
                  Are disabled or that it is not an XBox360 controller.
                  Id = 0 or 1, for the left or right motors.
                       Or else 2 for both at the same time.
                  Speed ​​= percent between 0 and 1
                  Fade_in = duration of transition between vibration level
                            And the desired one.
                  Duration = duration of the vibration.
                  Fade_out = transition time to 0 at the end of time.
                  Example:
                    Input.gamepad.vibrate! (2, 0.5, 50, 200, 50)
                  The two motors will vibrate to 50% on a total of 300 frames.
                  
  Keyboard <Device:
      Caution normally you should never use the keyboard directly.
      To create games it is preferable to use virtual keys
      Which can correspond to several keys of the keyboard + joysticks in
      Same time and possibly be configurable by the player,
      So direct use of keyboard to avoid.
      When it comes to text input, the Text_Entry_Box class is there.
    Constants:
      Escape, Enter, etc ...: Keypad keys, see list line 862.
                              They are not numbers but objects of type
                              Keyboard_Key which allows to do things like:
                                Keyboard :: Enter.push?
    Methods :
      Setup (* a): If you were brought for any reason to
                  You have to use the keyboard directly, you will have to
                  First tell him what keys to update.
                  By default none is updated because it would take
                  Time for nothing.
                  As for the rest several writings are supported:
                    Keyboard.setup (Keyboard :: Enter,: Escape, 'A' .. 'Z', 1)
                  To disable key update:
                    Keyboard.setup ()
                  For each setup, all the keys sent replace the
                  They are not added.
                  However, you only need to do this if you wish
                  Use the functions press ?, trigger ?, release ?, repeat ?,
                  Ntrigger? And count, push ?, toggle ?, push !, release!
                  And toggle! If below can be used on any
                  Which constantly touches.
      Push? (* A): Works exactly like the function press? But watching
                  Directly the state of the material therefore a little more slowly.
                  To be used only in the case cited above, if you want
                  The pressing state of a keyboard key without wanting to
                  The setup, otherwise it is better to use press?
                  You can also use it on Key constants of the keyboard:
                    Keyboard :: Escape.push?
      Toggle? (* A): Returns true if the key is locked otherwise false.
                    Locking is what is used for the keys
                    Verr. Num, Verr. Shift and Verr. Scroll down to see if they
                    Are on or off, but you can use it on any
                    In fact.
                    Like push? This function directly looks at the status of the
                    Hardware and can be used without setup.
                    You can also use it on Key constants of the keyboard:
                      Keyboard :: CapsLock.toggle?
                    For the arguments works like press?
      Push! (* A): Press the keys on the keyboard instead of the player.
                  The signals are sent directly to Windows so be careful.
                  For example, you can force the switch to full screen:
                    Keyboard.push! (: Alt,: Enter)
                  You can also use it on Key constants of the keyboard:
                    Keyboard :: Space.push!
                  For the arguments works like press?
      Release! (* A): Release the keyboard keys.
                     After calling push! You have to call release! so that
                     The system understands that it is not supported continuously.
                     It's not automatic!
                     So to finalize the transition in full screen mode it is necessary to do:
                      Keyboard.push! (: Alt,: Enter)
                      Keyboard.release! (: Alt,: Enter)
                     You can also use it on Key constants of the keyboard:
                      Keyboard :: Space.release!
                     For the arguments works like press?
      Toggle! (* A): Changes the lock status of a key.
                    You can also use it on Key constants of the keyboard:
                      Keyboard :: Space.release!
                    For the arguments works like press?
      Key_name (k): Returns the name of the key in the system language.
                    As for press, k can be equal to Keyboard :: W,: W, 'W', 87.
                    For example: Keyboard.key_name (: Escape) # => "ESC"
                    However, the names of all keys are not necessarily
                    Welcome, so it may be better to get organized
                    Itself a list of names manually.
                    You can also use it on Key constants
                      Keyboard::Escape.name
      
 Mouse <Device:
      By default the mouse is disabled, to activate it:
        Mouse.enabled = true
    Constants:
      Left, Middle, Right, X1, X2, WheelUp, WheelDown:
        The mouse buttons, I have all put it unnecessary to go to see the list line 990.
        These are not numbers but objects of type Mouse_Key which
        Can do things like: Mouse :: Left.click?
        Left, Middle, Right are left, middle, right clicks.
        X1 and X2 are the buttons on the sides of the mouse (if y'en a).
        WheelUp and WheelDown for roulette do not respond unfortunately
        Perfectly, to avoid in a game of the blow, besides for that it works
        A little bit you have to put the Input.update before the Graphics.update
    Properties:
      Click_max: alias of ntrigger_max
                  Unlike other controls, click_max / ntrigger_max
                  Of the mouse is by default 3.
      Click_time: alias of ntrigger_time
      Cursor: The cursor of the mouse, it is a classic Sprite so you
               Can use all sprite functions.
               To change the default cursor see line 1024.
      X: cursor.x shortcut for reading.
          You can also manually change the position of the mouse.
            Mouse.x = 123
          Attention Mouse.cursor.x = 123 does not work.
      Y: cursor.y shortcut for reading.
          You can also manually change the position of the mouse.
            Mouse.y = 456
          Attention Mouse.cursor.y = 456 does not work.
      Drag: The selection rectangle also uses a Sprite but has a
             Operation.
             It appears automatically when you keep a left click and
             Moves the mouse, however by default it is disabled.
             If you want to change the appearance of the selection rectangle
             That it is a Bitmap of 1x1 pixels, by default it is transparent blue
             See line 1032, but it can be changed at any time:
              Mouse.drag.bitmap.set_pixel (0, 0, Color.new (255, 0, 0, 128))
      Drag_enabled = Enable / disable selection, default deactivated.
                     To enable it: Mouse.drag_enabled = true
      Drag_x: Drag.x shortcut (Read-only)
      Drag_y: Drag.y Shortcut (Read Only)
      Drag_width: Selection width, equivalent to drag.zoom_x.to_i (Read-only)
      Drag_height: Height of selection, equivalent to drag.zoom_y.to_i (Read-only)
      Drag_rect: Returns Rect.new (drag_x, drag_y, drag_width, drag_height) (Read-only)
      Drag_auto_clear: If enabled the selection will automatically disappear
                        As soon as the left click is released.
      Drag_start_size: Number of pixels to move the mouse to
                        Make the selection rectangle appear, by default 10.
    Methods 
      Icon (s = nil, ox = 0, oy = 0): Allows you to change the appearance of the cursor,
                                The image must be in the picture folder,
                                The extension is optional.
                                  Mouse.icon ("cross")
                                It is possible to specify a shift towards
                                The center of the cursor if necessary, counting
                                From the top left corner of the image.
                                  Mouse.icon ("cross", 4, 4)
                                If you want to reset the default cursor:
                                  Mouse.icon
      Clip (* a): Defines the area in which the mouse is free to move.
                 There are four ways to use this function:
                  Mouse.clip (i): If i = 0, no limitation, the mouse can
                                  Sail freely throughout the screen. (Default)
                                  If i = 1, the mouse is blocked in the window
                                  Of the game, ie game surface + title bar.
                                  If i = 2, the mouse is blocked in the surface
                                  You can no longer go to the title bar.
                                  Deprecated since you can not reduce / close anymore
                                  The game which can quickly become painful.
                  Mouse.clip (): Same as Mouse.clip (0).
                  Mouse.clip (x, y, w, h): Defines an area manually,
                                           The point 0, 0 corresponds to the corner
                                           Top left of the playing surface.
                  Mouse.clip (rect): Same but with an object of type Rect.
      (?): Returns true if the mouse is in the requested field.
                There are five ways to use this feature:
                  Mouse.on? (): Checks if the cursor is in the playing surface.
                  Mouse.on? (X, y): checks whether the cursor is on point x y.
                  Mouse.on? (X, y, r): checks if the cursor is in the circle
                                       Of center x y and of radius r.
                  Mouse.on? (X, y, w, h): checks if the cursor is in the
                                          Rectangle at the specified coordinates.
                  Mouse.on? (Rect): Same but with an object of type Rect.
      Drag_on? (* A): Returns true if the selection is in contact with the given area.
                     There are four ways to use this function:
                      Mouse.drag_on? (X, y): checks if the point x y is included
                                             In the selection.
                      Mouse.drag_on? (X, y, r): check if the circle with center x y
                                                And of radius r comes into contact
                                                With the selection.
                      Mouse.drag_on? (X, y, w, h): checks whether the rectangle between
                                                   In contact with the selection.
                      Mouse.drag_on? (Rect): Same but with an object of type Rect.
      Drag_clear (): Clears the selection.
      Dragging? (): Returns true if a selection is in progress.
      Swap_button (b): If b = true, invert the left and right clicks,
                       If b = false, returns them to normal.
      Click? (K = Left): Single click, equivalent to ntrigger? (1, k).
                       The argument is optional and is the left-click by default.
                       The difference between click? And trigger? Is that if one does
                       A double click for example on the second click trigger?
                       Will return true while click? False (and dclick? True).
                       You can also use it on the Key constants of the mouse:
                        Mouse :: Left.click?
      Dclick? (K = Left): Double click, equivalent to ntrigger? (2, k).
                        You can also use it on the Key constants of the mouse:
                          Mouse :: Left.dclick?
      Tclick? (K = Left): Triple click, equivalent to ntrigger? (3, k).
                        You can also use it on the Key constants of the mouse:
                          Mouse :: Left.tclick?
      
  Key :
      There are four types: Player_Key, Gamepad_Key, Keyboard_Key and Mouse_Key
      Some have additional functions.
    Methods :
      To_s (): Returns the name of the constant.
                Input :: DOWN.to_s # => "DOWN"
      To_i (): Returns the id of the key.
                Input :: DOWN.to_i # => 2
      Trigger? (), Release? (), Repeat? (), Analog? (), Toggle?
      Ntrigger? (N), count (): All functions described above are
                              Can be used directly on the keys for more
                              Effectiveness:
                                Input :: DOWN.press?
                              However, it is unnecessary to call these
                              Keys Gamepad_Key, it will not work.
      Name (), push! (), Release! (), Toggle! (): Keyboard_Key Additional Functions
      Click? (), Dclick? (), Tclick? (): Mouse_Key Additional Functions
      [I]: Additional function of Player_Key for the multiplayer game:
              Input :: DOWN [0] .trigger? # Player 1
              Input :: DOWN [1] .trigger? # Player 2
      
  Text_Entry_Box <Sprite
      This class allows you to enter text on the keyboard, the mouse is also
      Supported for text selection.
      Text_Entry_Box is derived from Sprite and its display is automated.
      You can use all the functions of Sprite however the functions
      Zoom, angle, mirror, src_rect will not be compatible with the mouse.
      If the mouse is activated and hovers over a text box, the icon will change
      Automatically, you can change its appearance line 1180.
    Properties:
      Enabled: Enable or disable a text box.
                A disabled box can no longer have focus.
      Focus: The current focus state, only one box can have it at the same time.
      Text: Retrieves the entered text.
      Back_color: The background color, default value line 1195.
                   It can be changed at any time, but it
                   Call refresh () to update the bitmap.
                    Text_entry_box.back_color = Color.new (255, 0, 0)
      Select_color: Selection color, same as back_color.
      Allow_c: List of allowed characters as string.
                  Text_entry_box.allow_c = "abcABC123"
                If the list is empty all characters are allowed. (Default)
      Select: Enables or disables selections with the
               Mouse or Shift-key.
               Enabled by default, to disable it: text_entry_box.select = false
      Mouse: Enables or disables mouse functionality.
              Enabled by default, to disable it: text_entry_box.mouse = false
              It is also necessary that the mouse itself is activated otherwise it serves no purpose.
      Case: Character break:
              Text_entry_box.case = 0 # normal, case-sensitive (Default)
              Text_entry_box.case = 1 # downcase, the uppercase letters become lowercase.
              Text_entry_box.case = 2 # upcase, the lowercase letters become uppercase.
      Size: The current number of characters. (read only)
      Size_max: The maximum number of characters allowed.
                 If 0, no limit.
      Width: Shortcut to text_entry_box.bitmap.width (read-only)
      Width_max: The maximum size allowed in pixels.
                  If 0, no limit.
      Height: Shortcut to text_entry_box.bitmap.height (read-only)
      Font: Shortcut to text_entry_box.bitmap.font
    Methods :
      Text_Entry_Box.new (width, height, viewport = nil):
          Creates a new instance of Text_Entry_Box
          We are obliged to specify width and height which are used to create
          The bitmap, viewport is optional.
            Text_entry_box = Text_Entry_Box.new (100, 20)
            
      Provides: Deletes the sprite and the bitmap.
      Update: A call once per frame to update the text entry.
      Refresh: Call after changing the properties or doing the bitmap
                To force the update.
      Hover? : Returns true if the mouse hovers over the text box.
      Focus! : Gives the focus to the text box, only one box can have the
               Focus at once, it is automatically removed from others.
               This function is automatically called when you click on the
               Box text, if the mouse is activated of course.
=end

class Object
  remove_const(:Input)
  def singleton_attach_methods(o) class << self; self end.attach_methods(o) end
  def self.attach_methods(o)
    @attached_methods ||= []
    for m in o.public_methods-(instance_methods-@attached_methods)
      define_method(m, &o.method(m))
      @attached_methods << m unless @attached_methods.include?(m)
    end
  end
end

class String; alias getbyte [] end if RUBY_VERSION == '1.8.1'

module Input
  class Key
    include Comparable
    attr_reader :o, :i, :s, :hash, :to_sym
    alias to_i i
    alias to_s s
    def initialize(i,o)
      @o, self.i, self.s = o, i, "#{self.class.name.split('::')[-1]}_#{i}"
    end
    def o=(o) @o, @hash = o, @i.hash^o.hash  end
    def i=(i) @i, @hash = i, i.hash^@o.hash  end
    def s=(s) @s, @to_sym = s, s.to_sym      end
    def <=>(o)       @i <=> o.to_i           end
    def succ()       self.class.new(@i+1,@o) end
    def count()      @o.get_count(@i)        end
    def push?()      @o.get_push(@i)         end
    def toggle?()    @o.get_toggle(@i)       end
    def press?()     @o.get_press(@i)        end
    def trigger?()   @o.get_trigger(@i)      end
    def release?()   @o.get_release(@i)      end
    def repeat?()    @o.get_repeat(@i)       end
    def ntrigger?(n) @o.get_ntrigger(n,@i)   end
    def analog?()    @o.get_analog(@i)       end
  end
  class Gamepad_Key < Key
    def initialize(i,o=Gamepad) super        end
  end
  class Keyboard_Key < Key
    def initialize(i,o=Keyboard) super       end
    def name()       @o.get_key_name(@i)     end
    def push!()      @o.push!(@i)            end
    def release!()   @o.release!(@i)         end
    def toggle!()    @o.toggle!(@i)          end
  end
  class Mouse_Key < Key
    def initialize(i,o=Mouse) super          end
    def click?()     ntrigger?(1)            end
    def dclick?()    ntrigger?(2)            end
    def tclick?()    ntrigger?(3)            end
  end
  class Player_Key < Key
    def [](i)        @players_keys[i]        end
    def initialize(i,o=Players[0])
      super
      @players_keys = Players.map {|p| k = dup; k.o = p; k}
    end
  end
  
  class Device
    GetDoubleClickTime = Win32API.new('user32', 'GetDoubleClickTime', '', 'i')
    attr_accessor :enabled, :ntrigger_max, :ntrigger_time
    def initialize(max)
      @enabled, @count, @release, @keys = true, Array.new(max,0), [], []
      @ntrigger_count, @ntrigger_last, @ntrigger_max = @count.dup, @count.dup, 0
      self.ntrigger_time = 0
    end
    def update
      return unless @enabled
      update_keys
      update_ntrigger if @ntrigger_max != 0
    end
    def update_keys
      @release.clear
      for i in @keys
        if    get_push(i)   ; @count[i] += 1
        elsif @count[i] != 0; @count[i]  = 0; @release << i
        end
      end
    end
    def update_ntrigger
      f = Graphics.frame_count
      for i in @keys
        if @count[i] == 1
          @ntrigger_count[i] %= @ntrigger_max
          @ntrigger_count[i] += 1
          @ntrigger_last[i] = f + @ntrigger_time
        elsif @ntrigger_last[i] == f
          @ntrigger_count[i] = 0
        end
      end
    end
    def capture_key(*exclude)
      exclude = keyarrayize(*exclude) unless exclude.empty?
      (@count.size-1).downto(0) {|i| return key(i) if !exclude.include?(i) and get_push(i)}
      nil
    end
    def get_count(i)      @count[i]                                                            end
    def get_push(i)       false                                                                end
    def get_toggle(i)     false                                                                end
    def get_press(i)      @count[i] != 0                                                       end
    def get_trigger(i)    @count[i] == 1                                                       end
    def get_release(i)    @release.include?(i)                                                 end
    def get_repeat(i)     (j=@count[i])>0 and REPEAT.any? {|w,f| break(f>0 && j%f==0) if j>=w} end
    def get_ntrigger(n,i) get_trigger(i) and @ntrigger_count[i] == n                           end
    def get_analog(i)     get_push(i) ? 1.0 : 0.0                                              end
    def count(k)          get_count(k2i(k))                                                           end
    def push?(*a)         a.any?{|i| enum?(i) ? i.all?{|j| push?(*j)}       : get_push(k2i(i))}       end
    def toggle?(*a)       a.any?{|i| enum?(i) ? i.all?{|j| toggle?(*j)}     : get_toggle(k2i(i))}     end
    def press?(*a)        a.any?{|i| enum?(i) ? i.all?{|j| press?(*j)}      : get_press(k2i(i))}      end
    def trigger?(*a)      a.any?{|i| enum?(i) ? i.all?{|j| trigger?(*j)}    : get_trigger(k2i(i))}    end
    def release?(*a)      a.any?{|i| enum?(i) ? i.all?{|j| release?(*j)}    : get_release(k2i(i))}    end
    def repeat?(*a)       a.any?{|i| enum?(i) ? i.all?{|j| repeat?(*j)}     : get_repeat(k2i(i))}     end
    def ntrigger?(n,*a)   a.any?{|i| enum?(i) ? i.all?{|j| ntrigger?(n,*j)} : get_ntrigger(n,k2i(i))} end
    def analog?(*a)
      a.each do |i|
        d = if enum?(i)
          sum = size = 0
          i.each {|j| sum, size = sum+analog?(*j), size+1}
          sum == 0 ? 0 : sum / size
        else get_analog(k2i(i))
        end
        return d if d != 0
      end
      0.0
    end
    def ntrigger_time=(i) @ntrigger_time = (i==0 ? GetDoubleClickTime.call *
                          Graphics.frame_rate / 1000 : i)  end
    def key(o)            self.class.key(o)                end
    def k2i(o)            self.class.k2i(o)                end
  private
    def enum?(o)          o.is_a?(Array) or o.is_a?(Range) end
    def keyarrayize(*a)
      a.flatten!
      a.map! {|o| o.is_a?(Range) ? o.to_a : o}.flatten!
      a.compact!
      a.map! {|k| k2i(k)}.uniq!
      a
    end
    def self.key(o) o.is_a?(Key) || o.is_a?(Integer) ? const_get(:Keys)[o.to_i] : const_get(o) end
    def self.k2i(o) o.is_a?(Key) ? o.i : o.is_a?(Integer) ? o : const_get(o).i                 end
  end
  
  class Player < Device
    attr_reader :id, :gamepad, :gamepad_id
    def initialize(id)
      super(KEYS_MAX)
      @id, @gamepad_id, @gamepad, @map = id, id, No_Gamepad.new, @count.map{[]}
    end
    def setup(h)
      @keys.clear
      @count.fill(0)
      @map.fill([])
      for i,a in h
        a=@map[i=k2i(i)] = a[0].map {|j| Gamepad.key(j).dup} + a[1].map {|j| Keyboard.key(j)}
        @keys << i unless a.empty?
      end
      self.gamepad_id += 0
    end
    def gamepad_id=(i)
      vibration, @gamepad.enabled = @gamepad.vibration, false
      @gamepad = (@gamepad_id = i) >= 0 && Gamepads[i] || No_Gamepad.new
      @gamepad.vibration = vibration
      Players.each {|p| p.gamepad.enabled = true}
      @map.each {|a| a.each {|k| k.o = @gamepad if k.is_a?(Gamepad_Key)}}
    end
    def get_push(i)   @map[i].any? {|k| k.push?}                              end
    def get_toggle(i) @map[i].any? {|k| k.toggle?}                            end
    def get_analog(i) @map[i].each {|k| d=k.analog?; return d if d != 0}; 0.0 end
    def dirXY
      return 0.0, 0.0 unless @enabled
      return RIGHT.analog?-LEFT.analog?, UP.analog?-DOWN.analog?
    end
    def dir360
      x, y = *dirXY
      return 0.0, 0.0 if x == 0 and y == 0
      return Math.atan2(y,x)*180/Math::PI, (w=Math.hypot(x,y))>1 ? 1.0 : w
    end
    def dir8
      d = 5
      d -= 3 if DOWN.press?
      d -= 1 if LEFT.press?
      d += 1 if RIGHT.press?
      d += 3 if UP.press?
      d == 5 ? 0 : d
    end
    def dir4
      case d = dir8
      when 1; DOWN.trigger? == (@last_dir==2) ? 2 : 4
      when 3; DOWN.trigger? == (@last_dir==2) ? 2 : 6
      when 7; UP.trigger?   == (@last_dir==8) ? 8 : 4
      when 9; UP.trigger?   == (@last_dir==8) ? 8 : 6
      else    @last_dir = d
      end
    end
  end
  
  class Gamepad < Device
    ::Gamepad = self
    AXIS_PUSH, AXIS_DEADZONE, TRIGGER_PUSH = 16384, 6666, 0
    Keys = Array.new(48) {|i| Gamepad_Key.new(i)}
    Button1 , Button2 , Button3 , Button4 , Button5 , Button6 , Button7 ,
    Button8 , Button9 , Button10, Button11, Button12, Button13, Button14,
    Button15, Button16, Button17, Button18, Button19, Button20, Button21,
    Button22, Button23, Button24, Button25, Button26, Button27, Button28,
    Button29, Button30, Button31, Button32, Axis1_0 , Axis1_1 , Axis2_0 ,
    Axis2_1 , Axis3_0 , Axis3_1 , Axis4_0 , Axis4_1 , Axis5_0 , Axis5_1 ,
    Axis6_0 , Axis6_1 , PovUp   , PovRight, PovDown , PovLeft = *Keys
    XKeys = Array.new(48) {|i| Gamepad_Key.new(i)}
    A, B, X, Y, LB, RB, LT, RT, BACK, START, LS, RS,
    n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n, n,
    AxisLX_0, AxisLX_1, AxisLY_1, AxisLY_0, AxisRX_0, AxisRX_1, AxisRY_1, AxisRY_0,
    n, n, n, n, DPadUp, DPadRight, DPadDown, DPadLeft = *XKeys
    constants.each {|s| k = const_get(s);  k.s = s.to_s if k.is_a?(Key)}
    
    attr_accessor :vibration
    attr_reader   :unplugged
    def initialize(id=nil)
      super(48)
      @id, @unplugged, @map, @vibration = id, false, @count.map{[]}, true
    end
    def get_push(i)
      return false unless @enabled and !@unplugged
      j, k = *@map[i]
      case j
      when :button ; button(k)
      when :pov    ; k.include?(pov)
      when :axis_0 ; axis_raw(k) < -AXIS_PUSH
      when :axis_1 ; axis_raw(k) > AXIS_PUSH-1
      when :trigger; trig_raw(k) > TRIGGER_PUSH
      else           false
      end
    end
    def get_analog(i)
      return 0.0 unless @enabled and !@unplugged
      j, k = *@map[i]
      case j
      when :button, :pov; super
      when :axis_0 ; (k=axis_pct(k)) < 0 ? -k : 0.0
      when :axis_1 ; (k=axis_pct(k)) > 0 ?  k : 0.0
      when :trigger; trig_pct(k)
      else           0.0
      end
    end
    def vibrate!(id, speed, fade_in, duration, fade_out) end
  private
    def axis_pct(i)
      (i=axis_raw(i)).abs <= AXIS_DEADZONE ? 0.0 :
      (i<0 ? i+AXIS_DEADZONE : i-AXIS_DEADZONE+1) / (32768.0-AXIS_DEADZONE)
    end
    def trig_pct(i) trig_raw(i) / 255.0 end
    def axis_raw(i) 0                   end
    def trig_raw(i) 0                   end
    def pov()       0                   end
    def button(i)   false               end
      
    singleton_attach_methods(@o = new)
    
    class No_Gamepad < Gamepad
      ::No_Gamepad = Input::No_Gamepad = self
      def get_push(i)   false end
      def get_analog(i) 0.0   end
    end
    
    class Multimedia_Gamepad < Gamepad
      ::Multimedia_Gamepad = Input::Multimedia_Gamepad = self
      JoyGetDevCaps = Win32API.new('winmm', 'joyGetDevCaps', 'ipi', 'i')
      JoyGetPosEx   = Win32API.new('winmm', 'joyGetPosEx'  , 'ip' , 'i')
      def initialize(id)
        super
        JoyGetDevCaps.call(id, devcaps="\0"*404, 404)
        @caps = Array.new(7) {|i| i<2 or devcaps.getbyte(96)[i-2]==1}
        @buffer = [52,255,0,0,0,0,0,0,0,0,0,0,0].pack('L13')
        @state = @buffer.unpack('L13')
        for k,v in {            Button1 =>[:button, 0], Button2 =>[:button, 1],
        Button3 =>[:button, 2], Button4 =>[:button, 3], Button5 =>[:button, 4],
        Button6 =>[:button, 5], Button7 =>[:button, 6], Button8 =>[:button, 7],
        Button9 =>[:button, 8], Button10=>[:button, 9], Button11=>[:button,10],
        Button12=>[:button,11], Button13=>[:button,12], Button14=>[:button,13],
        Button15=>[:button,14], Button16=>[:button,15], Button17=>[:button,16],
        Button18=>[:button,17], Button19=>[:button,18], Button20=>[:button,19],
        Button21=>[:button,20], Button22=>[:button,21], Button23=>[:button,22],
        Button24=>[:button,23], Button25=>[:button,24], Button26=>[:button,25],
        Button27=>[:button,26], Button28=>[:button,27], Button29=>[:button,28],
        Button30=>[:button,29], Button31=>[:button,30], Button32=>[:button,31],
        Axis1_0 =>[:axis_0, 0], Axis1_1 =>[:axis_1, 0], Axis2_0 =>[:axis_0, 1],
        Axis2_1 =>[:axis_1, 1], Axis3_0 =>[:axis_0, 2], Axis3_1 =>[:axis_1, 2],
        Axis4_0 =>[:axis_0, 3], Axis4_1 =>[:axis_1, 3], Axis5_0 =>[:axis_0, 4],
        Axis5_1 =>[:axis_1, 4], Axis6_0 =>[:axis_0, 5], Axis6_1 =>[:axis_1, 5],
        PovUp   =>[:pov,[31500,    0, 4500]], PovRight=>[:pov,[ 4500, 9000,13500]],
        PovDown =>[:pov,[13500,18000,22500]], PovLeft =>[:pov,[22500,27000,31500]]}
          @map[k.i] = v
        end
        update
      end
      def update
        return unless @enabled and !@unplugged = JoyGetPosEx.call(@id, @buffer) != 0
        @state.replace(@buffer.unpack('L13'))
        super
      end
    private
      def button(i)   @state[8][i] == 1                end
      def pov()       @caps[6] ? @state[10] : 0        end
      def axis_raw(i) @caps[i] ? @state[2+i]-32768 : 0 end
    end
    
    class XBox360_Gamepad < Gamepad
      ::XBox360_Gamepad = Input::XBox360_Gamepad = self
      Keys = XKeys
      XInputGetState = (Win32API.new(DLL='xinput1_3'  , 'XInputGetState', 'ip', 'i') rescue
                        Win32API.new(DLL='xinput1_2'  , 'XInputGetState', 'ip', 'i') rescue
                        Win32API.new(DLL='xinput1_1'  , 'XInputGetState', 'ip', 'i') rescue
                        Win32API.new(DLL='xinput9_1_0', 'XInputGetState', 'ip', 'i') rescue
                        DLL=nil)
      XInputSetState =  Win32API.new(DLL              , 'XInputSetState', 'ip', 'i') if DLL
      def initialize(id)
        super
        @buffer = "\0"*16
        @state = @buffer.unpack('LSC2s4')
        @vibration_state = Array.new(2) {[0,0,0,0,0,false]}
        for k,v in {
        A        =>[:button,12], B       =>[:button,13], X       =>[:button,14],
        Y        =>[:button,15], LB      =>[:button, 8], RB      =>[:button, 9],
        LT       =>[:trigger,0], RT      =>[:trigger,1], BACK    =>[:button, 5],
        START    =>[:button, 4], LS      =>[:button, 6], RS      =>[:button, 7],
        AxisLX_0 =>[:axis_0, 0], AxisLX_1=>[:axis_1, 0], AxisLY_1=>[:axis_1, 1],
        AxisLY_0 =>[:axis_0, 1], AxisRX_0=>[:axis_0, 2], AxisRX_1=>[:axis_1, 2],
        AxisRY_1 =>[:axis_1, 3], AxisRY_0=>[:axis_0, 3], DPadUp  =>[:button, 0],
        DPadRight=>[:button, 3], DPadDown=>[:button, 1], DPadLeft=>[:button, 2]}
          @map[k.i] = v
        end
        update
      end
      def update
        return unless @enabled and !@unplugged = XInputGetState.call(@id, @buffer) != 0
        @state.replace(@buffer.unpack('LSC2s4'))
        super
        update_vibration if @vibration
      end
      def update_vibration
        vibrate = false
        @vibration_state.each do |v|
          next unless v[5]
          last_v0 = v[0]
          if    v[2]>0; v[0] = (v[0]*(v[2]-=1)+v[1]) / (v[2]+1.0)
          elsif v[3]>0; v[0], v[3] = v[1], v[3]-1
          elsif v[4]>0; v[0] = v[0]*(v[4]-=1) / (v[4]+1.0)
          else          v[0], v[5] = 0, false
          end
          vibrate = true if last_v0 != v[0]
        end
        set_vibration if vibrate
      end
      def vibration=(b) vibrate!(2,0,0,0,0); super end
      def vibrate!(id, speed, fade_in, duration, fade_out)
        case id
        when 0, 1; @vibration_state[id][1,5] = [speed, fade_in, duration, fade_out, true]
        when 2   ; 2.times {|i| vibrate!(i, speed, fade_in, duration, fade_out)}
        end
      end
    private
      def button(i)   @state[1][i] == 1 end
      def axis_raw(i) @state[4+i]       end
      def trig_raw(i) @state[2+i]       end
      def set_vibration
        return unless @enabled and @vibration and !@unplugged
        XInputSetState.call(@id, [@vibration_state[0][0]*0xFFFF,
                                  @vibration_state[1][0]*0xFFFF].pack('S2'))
      end
    end
    
  end
  
  class Keyboard < Device
    ::Keyboard = self
    GetKeyboardState    = Win32API.new('user32'  , 'GetKeyboardState'   , 'p'       , 'i')
    getKeyNameText      = Win32API.new('user32'  , 'GetKeyNameTextW'    , 'ipi'     , 'i')
    mapVirtualKey       = Win32API.new('user32'  , 'MapVirtualKey'      , 'ii'      , 'i')
    SendInput           = Win32API.new('user32'  , 'SendInput'          , 'ipi'     , 'i')
    ToUnicode           = Win32API.new('user32'  , 'ToUnicode'          , 'iippii'  , 'i')
    WideCharToMultiByte = Win32API.new('kernel32', 'WideCharToMultiByte', 'iipipipp', 'i')
  
    Keys = Array.new(256) {|i| Keyboard_Key.new(i)}
    None, MouseL, MouseR, Cancel, MouseM, MouseX1, MouseX2, n, Back, Tab,
    LineFeed, n, Clear, Enter, n, n, Shift, Control, Alt, Pause, CapsLock,
    KanaMode, n, JunjaMode, FinalMode, KanjiMode, n, Escape, IMEConvert,
    IMENonConvert, IMEAccept, IMEModeChange, Space, PageUp, PageDown, End, Home,
    Left, Up, Right, Down, Select, Print, Execute, PrintScreen, Insert, Delete,
    Help, D0, D1, D2, D3, D4, D5, D6, D7, D8, D9, n, n, n, n, n, n, n, A, B, C,
    D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z, LWin,
    RWin, Apps, n, Sleep, NumPad0, NumPad1, NumPad2, NumPad3, NumPad4, NumPad5,
    NumPad6, NumPad7, NumPad8, NumPad9, Multiply, Add, Separator, Subtract,
    Decimal, Divide, F1, F2, F3, F4, F5, F6, F7, F8, F9, F10, F11, F12, F13,
    F14, F15, F16, F17, F18, F19, F20, F21, F22, F23, F24, n, n, n, n, n, n, n,
    n, NumLock, Scroll, n, n, n, n, n, n, n, n, n, n, n, n, n, n, LShift,
    RShift, LControl, RControl, LAlt, RAlt, BrowserBack, BrowserForward,
    BrowserRefresh, BrowserStop, BrowserSearch, BrowserFavorites, BrowserHome,
    VolumeMute, VolumeDown, VolumeUp, MediaNextTrack, MediaPreviousTrack,
    MediaStop, MediaPlayPause, LaunchMail, SelectMedia, LaunchApplication1,
    LaunchApplication2, n, n, OemSemicolon, OemPlus, OemComma, OemMinus,
    OemPeriod, OemQuestion, OemTilde, n, n, n, n, n, n, n, n, n, n, n, n, n, n,
    n, n, n, n, n, n, n, n, n, n, n, n, OemOpenBrackets, OemPipe,
    OemCloseBrackets, OemQuotes, Oem8, n, n, OemBackslash, n, n, ProcessKey,
    n, Packet, n, n, n, n, n, n, n, n, n, n, n, n, n, n, Attn, Crsel, Exsel,
    EraseEof, Play, Zoom, NoName, Pa1, OemClear, Unknown = *Keys
    constants.each {|s| k = const_get(s);  k.s = s.to_s if k.is_a?(Key)}
    
    SCAN_CODE = Array.new(256) {|i| mapVirtualKey.call(i, 0)}
    (BrowserBack..LaunchApplication2).each {|k| SCAN_CODE[k.i] = 0}
    for k,code in  {Pause  =>0x0045, PageUp     =>0x0149, PageDown=>0x0151,
    End   =>0x014F, Home   =>0x0147, Left       =>0x014B, Up      =>0x0148,
    Right =>0x014D, Down   =>0x0150, PrintScreen=>0x0137, Insert  =>0x0152,
    Delete=>0x0153, LWin   =>0x015B, RWin       =>0x015C, Apps    =>0x015D,
    Divide=>0x0135, NumLock=>0x0145, RControl   =>0x011D, RAlt    =>0x0138}
      SCAN_CODE[k.i] = code
    end
    
    KEYS_NAME = Array.new(256) do |i|
      if getKeyNameText.call(SCAN_CODE[i]<<16, utf16="\0"*256, 256) > 0
        WideCharToMultiByte.call(65001, 0, utf16, -1, utf8="\0"*256, 256, 0, 0)
        utf8.delete("\0")
      else Keys[i].to_s
      end
    end
    
    TEXT_KEYS = [Space.i] + (D0.i..D9.i).to_a + (A.i..Z.i).to_a +
                (NumPad0.i..Divide.i).to_a + (146..150).to_a +
                (OemSemicolon.i..OemTilde.i).to_a + (OemOpenBrackets.i..245).to_a
    
    TEXT_ENTRY_KEYS = TEXT_KEYS + [Back.i,Left.i,Up.i,Right.i,Down.i,Delete.i]
    
    DEAD_KEYS = {
        '`' => {'a'=>'à', 'e'=>'è', 'i'=>'ì', 'o'=>'ò', 'u'=>'ù',
      ' '=>'`', 'A'=>'À', 'E'=>'È', 'I'=>'Ì', 'O'=>'Ò', 'U'=>'Ù'},
      
        '´' => {'a'=>'á', 'e'=>'é', 'i'=>'í', 'o'=>'ó', 'u'=>'ú', 'y'=>'ý',
      ' '=>'´', 'A'=>'Á', 'E'=>'É', 'I'=>'Í', 'O'=>'Ó', 'U'=>'Ú', 'Y'=>'Ý'},
      
        '^' => {'a'=>'â', 'e'=>'ê', 'i'=>'î', 'o'=>'ô', 'u'=>'û',
      ' '=>'^', 'A'=>'Â', 'E'=>'Ê', 'I'=>'Î', 'O'=>'Ô', 'U'=>'Û'},
      
        '¨' => {'a'=>'ä', 'e'=>'ë', 'i'=>'ï', 'o'=>'ö', 'u'=>'ü', 'y'=>'ÿ',
      ' '=>'¨', 'A'=>'Ä', 'E'=>'Ë', 'I'=>'Ï', 'O'=>'Ö', 'U'=>'Ü', 'y'=>'Ÿ'},
      
        '~' => {'a'=>'ã', 'o'=>'õ', 'n'=>'ñ',
      ' '=>'~', 'A'=>'Ã', 'O'=>'Õ', 'N'=>'Ñ'},
    }
    
    def initialize()         super(256); @buffer = "\0"*256                        end
    def get_push(i)          @enabled and @buffer.getbyte(i)[7] == 1               end
    def get_toggle(i)        @enabled and @buffer.getbyte(i)[0] == 1               end
    def get_key_name(i)      i.between?(0, 255) ? KEYS_NAME[i].dup : ''            end
    def key_name(k)          get_key_name(k2i(k))                                  end
    def push!(*a)            set_state(a, true)                                    end
    def release!(*a)         set_state(a, false)                                   end
    def toggle!(*a)          set_state(a, true); set_state(a, false)               end
    def text_entry()         start_text_entry unless @text_entry; @text_entry.dup  end
    def start_text_entry()   (@text_entry = ''; setup(@keys)) unless @text_entry   end
    def stop_text_entry()    (@text_entry = nil; setup(@user_keys)) if @text_entry end
    def swap_mouse_button(b) MouseL.i, MouseR.i = b ? 2 : 1, b ? 1 : 2             end
    def setup(*a)
      @count.fill(0)
      @keys = keyarrayize(@text_entry ? [@user_keys=a, TEXT_ENTRY_KEYS] : a)
    end
    def update
      return unless @enabled
      GetKeyboardState.call(@buffer)
      super
      update_text_entry if @text_entry
    end
    def update_text_entry
      @text_entry = ''
      for i in TEXT_KEYS
        next if !get_repeat(i) or ToUnicode.call(i, 0, @buffer, utf16="\0"*16, 8, 0)==0
        j = ToUnicode.call(i, 0, @buffer, utf16, 8, 0)
        WideCharToMultiByte.call(65001, 0, utf16, 1, utf8="\0"*4, 4, 0, 0)
        utf8.delete!("\0")
        if @dead_key
          a = DEAD_KEYS[@dead_key]
          @text_entry, @dead_key = (a && a[utf8]) || (@dead_key + utf8)
        else j == -1 ? @dead_key=utf8 : @text_entry=utf8
        end
        return
      end
    end
  private
    def set_state(keys, state)
      keys, inputs = keyarrayize(keys), ''
      keys.each {|i| inputs << [1,i,0,state ? 0 : 2,0,0].pack('LSSLLLx8')}
      SendInput.call(keys.size, inputs, 28)
    end
    
    singleton_attach_methods(@o = new)
    Keys.each {|k| k.o = @o}
    def self.o() @o end
  end
  
  class Mouse < Device
    ::Mouse = self
    ClipCursor      = Win32API.new('user32', 'ClipCursor'     , 'p'      , 'i')
    createCursor    = Win32API.new('user32', 'CreateCursor'   , 'iiiiipp', 'i')
    findWindow      = Win32API.new('user32', 'FindWindow'     , 'pp'     , 'i')
    GetClientRect   = Win32API.new('user32', 'GetClientRect'  , 'ip'     , 'i')
    GetCursorPos    = Win32API.new('user32', 'GetCursorPos'   , 'p'      , 'i')
    GetWindowRect   = Win32API.new('user32', 'GetWindowRect'  , 'ip'     , 'i')
    MapWindowPoints = Win32API.new('user32', 'MapWindowPoints', 'iipi'   , 'i')
    PeekMessage     = Win32API.new('user32', 'PeekMessage'    , 'piiii'  , 'i')
    SetClassLong    = Win32API.new('user32', 'SetClassLong'   , 'iii'    , 'i')
    SetCursorPos    = Win32API.new('user32', 'SetCursorPos'   , 'ii'     , 'i')
    
    Keys = Array.new(7) {|i| Mouse_Key.new(i)}
    Left, Middle, Right, X1, X2, WheelUp, WheelDown = *Keys
    constants.each {|s| k = const_get(s);  k.s = s.to_s if k.is_a?(Key)}
    
    HWND = findWindow.call('RGSS Player', 0)
    BlankCursor = createCursor.call(0, 0, 0, 1, 1, "\xFF", "\x00")
    Cache = (defined? RPG::Cache) ? RPG::Cache : ::Cache
    
    alias click_max   ntrigger_max
    alias click_max=  ntrigger_max=
    alias click_time  ntrigger_time
    alias click_time= ntrigger_time=
    attr_accessor :drag_enabled, :drag_auto_clear, :drag_start_size
    attr_reader   :cursor, :drag
    def initialize
      super(7)
      @map = @count.map{[]}
      for k,v in {Left    => [:button, Keyboard::MouseL],
                  Middle  => [:button, Keyboard::MouseM],
                  Right   => [:button, Keyboard::MouseR],
                  X1      => [:button, Keyboard::MouseX1],
                  X2      => [:button, Keyboard::MouseX2],
                  WheelUp => [:wheel, 1], WheelDown => [:wheel, -1]}
        @map[k.i] = v
      end
      @enabled, @ntrigger_max, @buffer, @keys = false, 3, "\0"*28, (0...7).to_a
      @drag_enabled, @drag_auto_clear, @drag_start_size = false, false, 10
      clip
      initialize_sprites
    end
    def initialize_sprites
      return if @cursor and !@cursor.disposed?
      @cursor, @drag = Sprite.new, Sprite.new
      @cursor.z = @drag.z = 0x7FFFFFFF
      @cursor.visible, @drag.visible = @enabled, @enabled && @drag_enabled
      @cursor.bitmap = @default_icon = Bitmap.new(8,8)
      @cursor.bitmap.fill_rect(0, 0, 3, 7, c=Color.new(0,0,0))
      @cursor.bitmap.fill_rect(0, 0, 7, 3, c)
      @cursor.bitmap.fill_rect(5, 5, 3, 3, c)
      @cursor.bitmap.fill_rect(1, 1, 1, 5, c.set(255,255,255))
      @cursor.bitmap.fill_rect(1, 1, 5, 1, c)
      @cursor.bitmap.fill_rect(6, 6, 1, 1, c)
      @drag.bitmap = Bitmap.new(1,1)
      @drag.bitmap.set_pixel(0, 0, c.set(0,0,255,128))
      drag_clear
    end
    def enabled=(enabled)
      initialize_sprites
      drag_clear unless @enabled = enabled
      SetClassLong.call(HWND, -12, @enabled ? BlankCursor : 0)
      @cursor.visible, @drag.visible = @enabled, @enabled && @drag_enabled
    end
    def drag_enabled=(drag_enabled)
      initialize_sprites
      drag_clear unless @drag_enabled = drag_enabled
      @drag.visible = @enabled && @drag_enabled
    end
    def update
      return unless @enabled
      super
      initialize_sprites
      update_cursor
      update_drag
      update_clip
      update_wheel
    end
    def update_cursor
      GetCursorPos.call(@buffer)
      MapWindowPoints.call(0, HWND, @buffer, 1)
      @cursor.update
      @cursor.x, @cursor.y = *@buffer.unpack('ll')
    end
    def update_drag
      return unless @drag_enabled
      @drag.update
      if Left.trigger?
        drag_clear
        @drag_start_point = [@cursor.x, @cursor.y]
      elsif @drag_start_point and Left.press?
        x, y = *@drag_start_point
        w, h = @cursor.x-x, @cursor.y-y
        if w == 0 then w = 1 elsif w < 0 then x -= w *= -1 end
        if h == 0 then h = 1 elsif h < 0 then y -= h *= -1 end
        if dragging? or w > @drag_start_size or h > @drag_start_size
          @drag.x, @drag.y, @drag.zoom_x, @drag.zoom_y = x, y, w, h
        end
      elsif @drag_auto_clear and Left.release?
        drag_clear
      end
    end
    def update_clip
      ClipCursor.call(@buffer) if case @clip
      when String; MapWindowPoints.call(HWND, 0, @buffer.replace(@clip), 2)
      when      1; GetWindowRect.call(HWND, @buffer)
      when      2; GetClientRect.call(HWND, @buffer)
                   MapWindowPoints.call(HWND, 0, @buffer, 2)
      end
    end
    def update_wheel
      @wheel_state = PeekMessage.call(@buffer,HWND,0x020A,0x020A,0)>0 ?
                     @buffer.getbyte(11)==0 ? 1 : -1 : 0
    end
    def on?(x=nil, y=nil, w=nil, h=nil)
      if !@enabled; false
      elsif h; @cursor.x.between?(x, x+w) and @cursor.y.between?(y, y+h)
      elsif w; Math.hypot(x-@cursor.x, y-@cursor.y) <= w
      elsif y; @cursor.x == x and @cursor.y == y
      elsif x; on?(x.x, x.y, x.width, x.height)
      else     GetClientRect.call(HWND, @buffer); on?(*@buffer.unpack('l4'))
      end
    end
    def drag_on?(x, y=nil, w=nil, h=nil)
      if !@enabled or !@drag_enabled; false
      elsif h
        x < @drag.x+drag_width  and @drag.x < x+w and
        y < @drag.y+drag_height and @drag.y < y+h
      elsif w
        sw, sh = drag_width/2, drag_height/2
        x, y = (x-@drag.x-sw).abs, (y-@drag.y-sh).abs
        x<=sw+w and y<=sh+w and (x<=sw or y<=sh or Math.hypot(x-sw,y-sh)<=w)
      elsif y
        x.between?(@drag.x, @drag.x+drag_width) and
        y.between?(@drag.y, @drag.y+drag_height)
      else drag_on?(x.x, x.y, x.width, x.height)
      end
    end
    def icon(s=nil, ox=0, oy=0) @cursor.bitmap, @cursor.ox, @cursor.oy =
                                s ? Cache.picture(s) : @default_icon, ox, oy end
    def clip(x=0, y=nil, w=0, h=0)
      ClipCursor.call(0)
      if x.is_a?(Rect); clip(x.x, x.y, x.width, x.height)
      else @clip = y ? [x, y, w+x, h+y].pack('l4x12') : x
      end
    end
    def click?(k=Left)  get_ntrigger(1, k2i(k))                           end
    def dclick?(k=Left) get_ntrigger(2, k2i(k))                           end
    def tclick?(k=Left) get_ntrigger(3, k2i(k))                           end
    def swap_button(b)  Keyboard.swap_mouse_button(b)                     end
    def x()             @cursor.x                                         end
    def x=(x)           set_pos(x, y)                                     end
    def y()             @cursor.y                                         end
    def y=(y)           set_pos(x, y)                                     end
    def dragging?()     @drag.zoom_x != 0                                 end
    def drag_x()        @drag.x                                           end
    def drag_y()        @drag.y                                           end
    def drag_width()    @drag.zoom_x.to_i                                 end
    def drag_height()   @drag.zoom_y.to_i                                 end
    def drag_rect()     Rect.new(drag_x, drag_y, drag_width, drag_height) end
    def drag_clear
      @drag_start_point = nil
      @drag.x = @drag.y = @drag.zoom_x = @drag.zoom_y = 0
    end
    def get_push(i)
      return false unless @enabled
      j, k = *@map[i]
      case j
      when :button; k.push?
      when :wheel ; k == @wheel_state
      else          false
      end
    end
    def get_toggle(i)
      return false unless @enabled
      j, k = *@map[i]
      case j
      when :button; k.toggle?
      else          false
      end
    end
  private
    def set_pos(x, y)
      @cursor.x, @cursor.y = x, y
      MapWindowPoints.call(HWND, 0, s=[x,y].pack('ll'), 1)
      SetCursorPos.call(*s.unpack('ll'))
    end
    
    singleton_attach_methods(@o = new)
    Keys.each {|k| k.o = @o}
    def self.o() @o end
  end
  
  class Text_Entry_Box < Sprite
    ::Text_Entry_Box = self
    SPECIAL_CHARS_CASE = {
      'à'=>'À', 'è'=>'È', 'ì'=>'Ì', 'ò'=>'Ò', 'ù'=>'Ù',
      'á'=>'Á', 'é'=>'É', 'í'=>'Í', 'ó'=>'Ó', 'ú'=>'Ú', 'ý'=>'Ý',
      'â'=>'Â', 'ê'=>'Ê', 'î'=>'Î', 'ô'=>'Ô', 'û'=>'Û',
      'ä'=>'Ä', 'ë'=>'Ë', 'ï'=>'Ï', 'ö'=>'Ö', 'ü'=>'Ü', 'ÿ'=>'Ÿ',
      'ã'=>'Ã',                     'õ'=>'Õ',                     'ñ'=>'Ñ',
    }
    def self.initialize
      @@boxes, @@last_icon = [], nil
      @@icon = [Bitmap.new(9,20), 4, 0] # [bmp, ox, oy]
      @@icon[0].fill_rect(0,  0, 9,  3, c=Color.new(0,0,0))
      @@icon[0].fill_rect(0, 17, 9,  3, c)
      @@icon[0].fill_rect(3,  3, 3, 14, c)
      @@icon[0].fill_rect(1,  1, 3,  1, c.set(255,255,255))
      @@icon[0].fill_rect(5,  1, 3,  1, c)
      @@icon[0].fill_rect(1, 18, 3,  1, c)
      @@icon[0].fill_rect(5, 18, 3,  1, c)
      @@icon[0].fill_rect(4,  2, 1, 16, c)
    end
    initialize
    attr_accessor :enabled, :mouse, :focus, :back_color, :select_color,
                  :text, :allow_c, :select, :case, :size_max, :width_max
    def initialize(width, height, viewport=nil)
      super(viewport)
      @back_color, @select_color = Color.new(0,0,0,0), Color.new(0,0,255,128)
      @text, @text_width, @allow_c = '', [], ''
      @enabled = @mouse = @select = true
      @case = @size_max = @width_max = @pos = @sel = @off = 0
      @text_chars = [] if RUBY_VERSION == '1.8.1'
      width = 640 if width > 640 and RUBY_VERSION == '1.9.2'
      self.bitmap = Bitmap.new(width, height)
      self.class.initialize if @@icon[0].disposed?
      @@boxes.delete_if {|s| s.disposed?}
      @focus = @@boxes.empty?
      @@boxes << self
    end
    def width()  bitmap.width                                      end
    def height() bitmap.height                                     end
    def font()   bitmap.font                                       end
    def font=(f) bitmap.font = f                                   end
    def hover?() Mouse.on?(x-ox, y-oy, width, height)              end
    def focus!() @@boxes.each {|s| s.focus = false}; @focus = true end
    def dispose
      super
      @@boxes.delete_if {|s| s.disposed?}
      Keyboard.stop_text_entry
      bitmap.dispose
    end
    def update
      super
      return unless @enabled
      update_mouse if @mouse
      return unless @focus
      if update_text_entry
        refresh
      elsif @mouse and (Mouse::WheelDown.press? or Mouse::WheelUp.press?)
        @off = Mouse::WheelDown.press? ? [@off-16, 0].max :
               [@off+16, text_width(0, size)+1-width].min
        draw_text_box
      elsif Graphics.frame_count % 20 == 0
        draw_cursor(Graphics.frame_count % 40 == 0)
      end
    end
    def refresh
      tag = "#{font.name}#{font.size}#{font.bold}#{font.italic}"
      self.text, @last_font = @text, tag if @last_font != tag
      min = [text_width(0,@pos)+16-width, text_width(0,size)+1-width].min
      max = [text_width(0,@pos)-16, 0].max
      @off = [min, [@off, max].min].max
      @sel = 0 unless @select
      draw_text_box
    end
  private
    def update_mouse
      if hover = hover? and !@@last_icon
        @@last_icon = [Mouse.cursor.bitmap, Mouse.cursor.ox, Mouse.cursor.oy]
        Mouse.cursor.bitmap, Mouse.cursor.ox, Mouse.cursor.oy = *@@icon
      elsif @last_hover != hover and !@last_hover = hover and @@last_icon
        Mouse.cursor.bitmap, Mouse.cursor.ox, Mouse.cursor.oy = *@@last_icon
        @@last_icon = nil
      end
      if @mouse_select
        @sel, @mouse_select = @sel+@pos, Mouse::Left.press?
        @sel -= @pos = get_pos(Mouse.x-x+ox+@off, true)
      elsif Mouse::Left.trigger? and hover
        @pos, @sel, @mouse_select = get_pos(Mouse.x-x+ox+@off, true), 0, true
        Mouse.drag_clear
        focus!
      end
    end
    def update_text_entry
      if @mouse_select
        return false if @last_pos == @pos and @last_sel == @sel
        @last_pos, @last_sel = @pos, @sel
      elsif @sel != 0 and (Keyboard::Back.trigger? or Keyboard::Delete.trigger?)
        @pos -= @sel *= -1 if @sel < 0
        self[@pos, @sel], @sel = '', 0
      elsif @pos != 0 and Keyboard::Back.repeat?
        self[@pos -= 1, 1] = ''
      elsif @pos != size and Keyboard::Delete.repeat?
        self[@pos, 1] = ''
      elsif @pos != 0 and Keyboard::Up.trigger?
        @sel, @pos = @select && Keyboard::Shift.push? ? @sel+@pos : 0, 0
      elsif @pos != size and Keyboard::Down.trigger?
        @sel, @pos = @select && Keyboard::Shift.push? ? @sel+@pos-size : 0, size
      elsif @pos != 0 and Keyboard::Left.repeat?
        @pos, @sel = @pos-1, @select && Keyboard::Shift.push? ? @sel+1 : 0
      elsif @pos != size and Keyboard::Right.repeat?
        @pos, @sel = @pos+1, @select && Keyboard::Shift.push? ? @sel-1 : 0
      elsif !Keyboard.text_entry.empty?
        need_refresh, allowed_chars = false,
          @case==1 ? downcase(@allow_c) : @case==2 ? upcase(@allow_c) : @allow_c
        for c in Keyboard.text_entry.split(//)
          break if @size_max != 0 and @size_max <= size
          c = @case==1 ? downcase(c) : @case==2 ? upcase(c) : c
          next unless allowed_chars.empty? or allowed_chars.include?(c)
          _text, _pos, _sel = @text.dup, @pos, @sel if @width_max != 0
          @pos -= @sel *= -1 if @sel < 0
          self[@pos, @sel], @pos, @sel = c, @pos+1, 0
          if @width_max != 0 and text_width(0, size) > @width_max
            self.text, @pos, @sel = _text, _pos, _sel
            break
          end
          need_refresh = true
        end
        return need_refresh
      else return false
      end
      return true
    end
    def draw_text_box
      bitmap.fill_rect(bitmap.rect, @back_color)
      draw_selection if @sel != 0
      draw_text_entry
      draw_cursor(true)
    end
    def draw_selection
      pos, sel = @sel < 0 ? @pos+@sel : @pos, @sel.abs
      x, w, h = text_width(0,pos)-@off, text_width(pos,sel), font.size+2
      bitmap.fill_rect(x, (height-h)/2, w, h, @select_color)
    end
    def draw_cursor(blink)
      color = blink ? font.color : @back_color
      x, h = text_width(0, @pos)-@off, font.size+2
      bitmap.fill_rect(x, (height-h)/2, 1, h, color)
    end
    def draw_text_entry()
      bitmap.draw_text(-@off, 0, 0xFFFF, height, @text)
    end
    def downcase(str)
      str = str.downcase
      SPECIAL_CHARS_CASE.each {|d,u| str.gsub!(u, d)}
      str
    end
    def upcase(str)
      str = str.upcase
      SPECIAL_CHARS_CASE.each {|d,u| str.gsub!(d, u)}
      str
    end
    def text_width(i, j)
      @text_width[i] ||= bitmap.text_size(self[0, i]).width
      @text_width[i+j] ||= bitmap.text_size(self[0, i+j]).width
      @text_width[i+j] - @text_width[i]
    end
    def get_pos(x, round=false)
      return 0 if x <= 0
      return size if x >= text_width(0, size)
      size.times do |i|
        if (w = text_width(0,i+1)) > x
          return i unless round
          w -= text_width(i,1) / 2
          return w > x ? i : i+1
        end
      end
    end
    if RUBY_VERSION == '1.9.2'
      alias normal_draw_text_entry draw_text_entry
      def draw_text_entry
        if text_width(0, size) > 640
          a, b = get_pos(@off), get_pos(@off+width)
          b += 1 if b != size and text_width(a, b+1-a) <= 640
          a += 1 if text_width(a, b-a) > 640
          x = text_width(0,a)-@off
          bitmap.draw_text(x, 0, 0xFFFF, height, self[a, b-a])
        else normal_draw_text_entry
        end
      end
      def [](i, j) @text[i, j] end
      def []=(i, j, str)
        @text[i, j] = str
        @text_width[i, @text_width.size-i] = Array.new(size-i)
      end
    public
      def size()   @text.size  end
      def text=(str)
        str = @case==1 ? downcase(str) : @case==2 ? upcase(str) : str
        @text_width = Array.new(str.size)
        @text = str
      end
    else
      def [](i, j) @text_chars[i, j].join('') end
      def []=(i, j, str)
        @text_chars[i, j] = str.empty? ? nil : str
        @text_width[i, @text_width.size-i] = Array.new(size-i)
        @text.replace(@text_chars.join(''))
      end
    public
      def size()   @text_chars.size           end
      def text=(str)
        str = @case==1 ? downcase(str) : @case==2 ? upcase(str) : str
        @text_chars.replace(str.split(//))
        @text_width = Array.new(@text_chars.size)
        @text = str
      end
    end
  end
  
  def self.[](i) Players[i] end
  def self.update
    Keyboard.update
    Mouse.update
    Gamepads.each {|g| g.update}
    Players.each {|p| p.update}
  end
  def self.refresh
    Gamepads.clear
    x360_pads = XBox360_Gamepad::DLL ? Array.new(4) {|i| XBox360_Gamepad.new(i)} : []
    x360_pads.sort! {|a,b| (a.unplugged ? 1 : 0) <=> (b.unplugged ? 1 : 0)}
    devcaps = "\0"*404
    16.times do |i|
      Multimedia_Gamepad::JoyGetDevCaps.call(i, devcaps, 404)
      mid = devcaps.unpack('S')[0]
      if mid == 1118 and !x360_pads.empty?
        Gamepads << x360_pads.shift
      elsif mid != 0
        Gamepads << Multimedia_Gamepad.new(i)
      end
    end
    Gamepads.sort! {|a,b| (a.unplugged ? 1 : 0) <=> (b.unplugged ? 1 : 0)}
    Gamepads.each {|g| g.enabled = false}
    Players.each {|p| p.gamepad_id += 0}
  end
  
# The rhythm of the repeat function? When a key is pressed.
   # The repeat function? Is used in the menus to move the cursor for example.
  f = Graphics.frame_rate
  REPEAT = [# (reads from bottom to top)
     # [F * 4, 1], # After 4 seconds always returns true.
     # [F * 2, f * 0.05], # After 2 seconds returns true every 0.05 seconds.
     [F * 0.4, f * 0.1], # After 0.4 seconds returns true every 0.1 seconds.
     [2, 0], # ... then returns false (from the 2nd frame).
     [1, 1] # Returns true when you press (1st frame) ...
   ]
   PLAYERS_MAX = 1 # The number of players for multiplayer games.
   KEYS_MAX = 30 # Number of keys, we can put a very large number if we
                 # Wants but limiting it to the minimum serves to optimize the memory.
  
  Gamepads, Players = [], Array.new(PLAYERS_MAX) {|i| Player.new(i)}
  singleton_attach_methods(Players[0])
  class Player
    Keys = Array.new(KEYS_MAX) {|i| Player_Key.new(i)}
   # The different keys of the game (id between 0 and KEYS_MAX-1).
    DOWN  = Keys[2]
    LEFT  = Keys[4]
    RIGHT = Keys[6]
    UP    = Keys[8]
    A     = Keys[11]
    B     = Keys[12]
    C     = Keys[13]
    X     = Keys[14]
    Y     = Keys[15]
    Z     = Keys[16]
    L     = Keys[17]
    R     = Keys[18]
    SHIFT = Keys[21]
    CTRL  = Keys[22]
    ALT   = Keys[23]
    F5    = Keys[25]
    F6    = Keys[26]
    F7    = Keys[27]
    F8    = Keys[28]
    F9    = Keys[29]
    
    constants.each {|s| Input.const_set(s,k=const_get(s)); k.s = s.to_s if k.is_a?(Key)}
  end
  
  # The default config of the keys.
   # In the case of a multiplayer game, you need a different one for each player.
   # List of keyboard keys line 862.
   # List of keys XBox360 line 689, for joystick random line 681.
   # But no need to put both, for example: A and: Button1 are the same
   # Key, if I use those of XBox it is just because it seems to me
   # More logical to set the keys relative to a known config.
   # The best thing is to make a menu where the player can configure it all.
   # The format is very simple, on the left the virtual keys of the game, on the right
   # An array of corresponding keys separated into two, 1st column
   # Keys of the joystick, 2nd column the keys of the keyboard.
   # For multiplayer games the joystick configuration is the same for
   # All, the differentiation of the controllers is done internally.
   # Player Config 1:
  Players[0].setup(
    :DOWN  => [ [:AxisLY_0, :DPadDown] , [:Down]                 ],
    :LEFT  => [ [:AxisLX_0, :DPadLeft] , [:Left]                 ],
    :RIGHT => [ [:AxisLX_1, :DPadRight], [:Right]                ],
    :UP    => [ [:AxisLY_1, :DPadUp]   , [:Up]                   ],
    :A     => [ [:X]                   , [:Z, :Shift]            ],
    :B     => [ [:Y]                   , [:X, :NumPad0, :Escape] ],
    :C     => [ [:A]                   , [:C, :Enter, :Space]    ],
    :X     => [ [:B]                   , [:A]                    ],
    :Y     => [ [:LT]                  , [:S]                    ],
    :Z     => [ [:RT]                  , [:D]                    ],
    :L     => [ [:LB]                  , [:Q, :PageUp]           ],
    :R     => [ [:RB]                  , [:W, :PageDown]         ],
    :SHIFT => [ []                     , [:Shift]                ],
    :CTRL  => [ []                     , [:Control]              ],
    :ALT   => [ []                     , [:Alt]                  ],
    :F5    => [ []                     , [:F5]                   ],
    :F6    => [ []                     , [:F6]                   ],
    :F7    => [ []                     , [:F7]                   ],
    :F8    => [ []                     , [:F8]                   ],
    :F9    => [ []                     , [:F9]                   ])
  
  refresh
  update
  Keyboard.release!(0...256) if Keyboard.push?(*0...256)
end