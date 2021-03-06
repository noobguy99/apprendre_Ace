#-------------------------------------------------------------------------------
# * Arc Engine - Platform
#-------------------------------------------------------------------------------
# * By Khas Arcthunder
# * Version: 1.1
# * Released on: 18/10/2013
#
# * Blog: http://arcthunder.blogspot.com
# * Twitter: http://twitter.com/arcthunder
# * Youtube: http://youtube.com/user/darkkhas
#
#-------------------------------------------------------------------------------
# Terms of Use | Termos de Uso
#-------------------------------------------------------------------------------
# * ENGLISH
# Read updated terms of use at http:/arcthunder.blogspot.com
#
# * PORTUGUES
# Leia os termos atualizados em http://arcthunder.blogspot.com
#
#-------------------------------------------------------------------------------
# * Configuration | Configuraç?o
#-------------------------------------------------------------------------------
module Arc_Sound
  
  # Jump SE volume
  # Volume do som de pulo
  Jump_Volume = 80
  
  # Groundpound SE volume
  # Volume do som de groundpound
  Groundpound_Volume = 80
  
  # List of jump sounds, by actor. Use:
  # actor_id => ["sound 1", "sound 2", ...],
  
  # Lista de sons de pulo, por ator. Use:
  # id_do_ator => ["som 1", "som 2", ...],
  Jump = {
  1 => ["Jump1"],
  
  }
  
  # List of groundpound sounds, by actor. Use:
  # actor_id => ["sound 1", "sound 2", ...],
  
  # Lista de sons de groundpound, por ator. Use:
  # id_do_ator => ["som 1", "som 2", ...],
  Groundpound = {
  1 => ["Damage2"],
  
  }
  
  # Don't touch here | N?o mexa aqui
  def self.jump
    ary = Jump[$game_party.members[0].id]
    RPG::SE.new(ary[rand(ary.size)],Jump_Volume).play
  end
  
  # Don't touch here | N?o mexa aqui
  def self.groundpound
    ary = Groundpound[$game_party.members[0].id]
    RPG::SE.new(ary[rand(ary.size)],Groundpound_Volume).play
  end
end



module Arc_Core
  
  # Gravity constant
  # Constante de gravidade
  Gravity = 0.6
  
  # Insignificant constant
  # Constante insignificante
  Insignificant = 0.9
  
  # Air resistance coefficient
  # Coeficiente de resistência do ar
  Air_Resistance = 4.0
  
  # Body resistance coefficient
  # Coeficiente de resistência do corpo
  Body_Resistance = 35.0
  
  # Body resistance coefficient (running)
  # Coeficiente de resistência do corpo (correndo)
  Running_Resistance = 20.0
  
  # Body resistance coefficient (stopping)
  # Coeficiente de resistência do corpo (parando)
  Stop_Resistance = 90.0
  
  # Jump impulse
  # Impulso do Pulo
  Jump_Impulse = -700.0
  
  # Jump impulse bonus
  # Bonus do impulso do pulo
  Jump_RBonus = -20.0
  
  # Key force
  # Força das teclas
  Key_Force = 50.0
  
  # Surface Tolerance (pixels)
  # Tolerância de superfície (pixels)
  Surface_T = 4
  
  # Wall kick impact center
  # Centro de impacto de chute
  WKick_OY  = 4
  
  # Wall kick Tolerance (pixels)
  # Tolerância de Wall kick (pixels)
  WKick_T = 6
  
  # Wall kick impulse - X axis
  # Impulso do Wall kick - eixo X
  WKick_XImpulse = 800.0
  
  # Wall kick impulse - Y axis
  # Impulso do Wall kick - eixo Y
  WKick_YImpulse = -600.0
  
  # Wall kick deny radius - X
  # Negar Wall kick - raio X
  WKick_XRadius = 8
  
  # Wall kick deny radius - Y
  # Negar Wall kick - raio Y
  WKick_YRadius = 64
  
  # Meter (pixels)
  # Metro (pixels)
  Meter_Size = 20
  
  # Center constant - X
  # Contante de centro - X
  Map_CX = (Graphics.width / 32) / 2.0
  
  # Center constant - Y
  # Contante de centro - Y
  Map_CY = (Graphics.height / 32 + 1) / 2.0
  
  # Screen center constant - X
  # Contante de centro de tela - X
  Screen_CX = 272
  
  # Screen center constant - Y
  # Contante de centro de tela - Y
  Screen_CY = 208
  
  # Screen Tiles - X
  # Tiles na tela - X
  Screen_TX = Graphics.width / 32
  
  # Screen Tiles - Y
  # Tiles na tela - Y
  Screen_TY = Graphics.height / 32
  
  # Camera focus - X
  # Foco da camera - X
  Max_SX = 3
  
  # Camera focus - Y
  # Foco da camera - Y
  Max_SY = 3
  
  # Screen constant X
  # Constante de tela X
  On_ScreenX = 384
  
  # Screen constant Y
  # Constante de tela Y
  On_ScreenY = 336
  
  # Maximum AI approach
  # Aproximaç?o de IA máxima
  AI_Approach = 16
  
  # Trigger distance - X
  # Distancia ativa - X
  Trigger_X = 16
  
  # Trigger distance - Y
  # Distancia ativa - Y
  Trigger_Y = 2
  
  # Stair constant
  # Constante de escada
  Stair_OY = 10
  
  # Stair speed
  # Velocidade de escada
  Stair_Speed = 2
  
  # Death switch
  # Switch da morte
  Death_Zone_Switch = 1
  
  # Death zone height
  # Altura da zona de morte
  Death_Zone_Height = 64
  
  
  # Default character height
  # Altura padr?o
  Default_Height = 30
  
  # Default character width
  # Largura padr?o
  Default_Width = 16
  
  # Default character weight
  # Massa padr?o
  Default_Weight = 70
  
  # Axis plus
  # Adicional de eixo
  X_Axis = 16
  Y_Axis = 31
  
  # Collision Height
  # Altura de colis?o
  Height_CL = 32
  
  # Zoom Window
  # Janela de zoom
  Enable_Zoom = true
  
  # Disable physics editor?
  # Desabilitar editor físico?
  Disable_Editor = false

#-------------------------------------------------------------------------------
# * Configuration end | Fim da configuraç?o
#-------------------------------------------------------------------------------
  
  AWC = Color.new(240,240,240)
  AWT = Color.new(255,255,255)
  AWB = Color.new(0,0,0,150)
  AWLB = Color.new(50,50,50,150)
  AWA = Color.new(150,255,255)
  AWF = Color.new(200,200,200)
  AWE = Color.new(255,0,0)
  AWH = Color.new(150,255,150)
  AWW = Color.new(50,50,255,150)
  COLORS = {
  0b0 => Color.new(0,0,0,0),
  0b1 => Color.new(255,0,0,200),
  0b100 => Color.new(0,255,0,200)}
  AWST = Color.new(255,255,0,150)
  def self.set_font(bitmap)
    bitmap.font.name = "Arial"
    bitmap.font.size = 14
  end
  TILE_RDG = 0x0
  CUSTOM_RDG = 0x1
  Max_Elevation = 1
end

#-------------------------------------------------------------------------------
# * Input Core (by Khas Arcthunder)
#-------------------------------------------------------------------------------

module Input_Core
  State = Win32API.new('user32','GetKeyState','i','i')
  AsyncState = Win32API.new('user32','GetAsyncKeyState','i','i')
  SystemMetrics = Win32API.new('user32','GetSystemMetrics','i','i')
  GetCursorPos = Win32API.new('user32','GetCursorPos','p','v')
  GetWindowRect = Win32API.new('user32','GetWindowRect','lp','v')
  GameWindow = Win32API.new('user32','FindWindowEx','llpp','i').call(0,0,'RGSS Player',0)
  SM_CYCAPTION = SystemMetrics.call(0x4) 
  SM_CXBORDER = SystemMetrics.call(0x5)
  SM_CYBORDER = SystemMetrics.call(0x6) 
  SM_CXEDGE = SystemMetrics.call(0x2d)
  SM_CYEDGE = SystemMetrics.call(0x2e)
  Swap = SystemMetrics.call(0x17) != 0x0
  XPLUS = SM_CXBORDER + SM_CXEDGE
  YPLUS = SM_CYBORDER + SM_CYEDGE + SM_CYCAPTION
  Codes = {
  :ML => (Swap ? 2 : 1),
  :MR => (Swap ? 1 : 2),
  :MM => 4,
  :Backspace=> 8,
  :Enter => 13,
  :Shift => 16,
  :Ctrl => 17,
  :CapsLock => 20}
  Letters = {
  :A => 65,
	:B => 66,
	:C => 67,
	:D => 68,
	:E => 69,
	:F => 70,
	:G => 71,
	:H => 72,
	:I => 73,
	:J => 74,
	:K => 75,
	:L => 76,
	:M => 77,
	:N => 78,
	:O => 79,
	:P => 80,
	:Q => 81,
	:R => 82,
	:S => 83,
	:T => 84,
	:U => 85,
	:V => 86,
	:W => 87,
	:X => 88,
	:Y => 89,
	:Z => 90,
  :Underscore => 189}
  LettersTable = {
  :A => ["a","A"],
	:B => ["b","B"],
	:C => ["c","C"],
	:D => ["d","D"],
	:E => ["e","E"],
	:F => ["f","F"],
	:G => ["g","G"],
	:H => ["h","H"],
	:I => ["i","I"],
	:J => ["j","J"],
	:K => ["k","K"],
	:L => ["l","L"],
	:M => ["m","M"],
	:N => ["n","N"],
	:O => ["o","O"],
	:P => ["p","P"],
	:Q => ["q","Q"],
	:R => ["r","R"],
	:S => ["s","S"],
	:T => ["t","T"],
	:U => ["u","U"],
	:V => ["v","V"],
	:W => ["w","W"],
	:X => ["x","X"],
	:Y => ["y","Y"],
	:Z => ["z","Z"],
  :Underscore => ["-","_"]}
  Numbers = {0=>[48,96],1=>[49,97],2=>[50,98],3=>[51,99],4=>[52,100],
  5=>[53,101],6=>[54,102],7=>[55,103],8=>[56,104],9=>[57,105]}
  def self.trigger?(id)
    return AsyncState.call(Codes[id]) & 0b1 == 0b1
  end
  def self.toggled?(id)
    return State.call(Codes[id]) & 0b1 == 0b1
  end
  def self.press?(id)
    return State.call(Codes[id]) & 0x80 == 0x80
  end
  def self.check_number(id)
    return true if AsyncState.call(Numbers[id][0]) & 0b1 == 0b1 
    return true if AsyncState.call(Numbers[id][1]) & 0b1 == 0b1
    return false
  end
  def self.any_number?
    for id in 0..9
      return id if AsyncState.call(Numbers[id][0]) & 0b1 == 0b1
      return id if AsyncState.call(Numbers[id][1]) & 0b1 == 0b1
    end
    return nil
  end
  def self.any_letter?
    for key in Letters.keys
      return key if AsyncState.call(Letters[key]) & 0b1 == 0b1
    end
    return nil
  end
  def self.letter_number?
    letter = Input_Core.any_letter?
    return letter if letter != nil
    return Input_Core.any_number?
  end
  def self.mpos
    packed_cp = '00000000'
    packed_wp = '0000000000000000'
    GetWindowRect.call(GameWindow,packed_wp)
    GetCursorPos.call(packed_cp)
    wx, wy = packed_wp.unpack('llll')[0..1]
    mx, my = packed_cp.unpack('ll')
    wx += XPLUS; wy += YPLUS
    return [mx-wx,my-wy]
  end
  def self.refresh_state
    for id in 0..9
      AsyncState.call(Numbers[id][0]) & 0b1 == 0b1
      AsyncState.call(Numbers[id][1]) & 0b1 == 0b1
    end
    for item in Letters.values
      AsyncState.call(item) & 0b1 == 0b1
    end
    for code in Codes.values
      AsyncState.call(code) & 0b1 == 0b1
    end
  end
end

#-------------------------------------------------------------------------------
# * Sprite
#-------------------------------------------------------------------------------

class Sprite
  def ssx(tx,time)
    @ax = self.x
    @dx = (tx.to_f - @ax)/2
    @phase_x = Math::PI
    @speed_x = @phase_x/time
    @sliding_x = true
  end
  def ssy(ty,time)
    @ay = self.y
    @dy = (ty.to_f - @ay)/2
    @phase_y = Math::PI
    @speed_y = @phase_y/time
    @sliding_y = true
  end
  def update_slide
    unless @phase_x.nil?
      @phase_x -= @speed_x
      if @phase_x > 0
        self.x = @ax + @dx*(Math.cos(@phase_x)+1)
      else
        self.x = @ax + @dx*2
        @phase_x = nil
        @sliding_x = false
      end
    end
    unless @phase_y.nil?
      @phase_y -= @speed_y
      if @phase_y > 0
        self.y = @ay + @dy*(Math.cos(@phase_y)+1)
      else
        self.y = @ay + @dy*2
        @phase_y = nil
        @sliding_y = false
      end
    end
  end
  def sliding?
    @sliding_x || @sliding_y
  end
end

#-------------------------------------------------------------------------------
# * Cache
#-------------------------------------------------------------------------------

class << Cache
  def custom_map(filename)
    load_bitmap("Graphics/Custom Maps/", filename)
  end
end

#-------------------------------------------------------------------------------
# * Arc MapCore
#-------------------------------------------------------------------------------

class Arc_MapCore
  include Arc_Core
  attr_reader :height
  attr_accessor :id
  attr_accessor :name
  attr_accessor :mode
  attr_accessor :background
  attr_accessor :main
  attr_accessor :top
  attr_accessor :table
  attr_accessor :water
  attr_accessor :ice
  attr_accessor :stairs
  attr_accessor :surface
  def initialize(i,n,m)
    @name = n
    @mode = m
    @id = i
    @background = ""
    @main = ""
    @top = ""
    @width = 0
    @height = 0
    @bsprite = nil
    @msprite = nil
    @tsprite = nil
    @tbitmap = nil
  end
  def load_sprites(viewport,bz,mz,tz)
    if @background != ""
      @bsprite = Sprite.new(viewport)
      @bsprite.bitmap = Cache.custom_map(@background)
      @bsprite.z = bz
    end
    if @main != ""
      @msprite = Sprite.new(viewport)
      @msprite.bitmap = Cache.custom_map(@main)
      @msprite.z = mz
    end
    if @top != ""
      @tsprite = Sprite.new(viewport)
      @tsprite.bitmap = Cache.custom_map(@top)
      @tsprite.z = tz
    end
  end
  def load_sprites_fe(viewport,bz,mz)
    if @background != ""
      @bsprite = Sprite.new(viewport)
      @bsprite.bitmap = Cache.custom_map(@background)
      @bsprite.z = bz
    end
    if @main != ""
      @msprite = Sprite.new(viewport)
      @msprite.bitmap = Cache.custom_map(@main)
      @msprite.z = mz
    end
  end
  def unload_sprites
    if @bsprite != nil
      @bsprite.dispose
      @bsprite = nil
    end
    if @msprite != nil
      @msprite.dispose
      @msprite = nil
    end
    if @tsprite != nil
      @tsprite.dispose
      @tsprite = nil
    end
  end
  def try_loadbackground
    return true if @background == ""
    test = Cache.custom_map(@background) rescue (return false)
    test.dispose
    test = nil
    return true 
  end
  def try_loadmain
    return true if @main == ""
    test = Cache.custom_map(@main) rescue (return false)
    test.dispose
    test = nil
    return true 
  end
  def try_loadtop
    return true if @top == ""
    test = Cache.custom_map(@top) rescue (return false)
    test.dispose
    test = nil
    return true 
  end
  def compress
    loading = Arc_LWindow.new(0,240)
    loading.change_text("Compressing...")
    loading.enter
    fr = {}
    cl = []
    wr = []
    wl = []
    sr = {}
    psr = []
    pwater = []
    pice = []
    content = []
    rate = (@table.xsize+@table.ysize).to_f/100.0
    for x in 0...@table.xsize
      loading.progress(x/rate)
      fr[x] = []
      for y in 0...@table.ysize
        next if @table[x,y] == 0b0
        if @table[x,y] == 0b100
          if @table[x,y-1] == 0
            psr << [x,y]
          end
          next
        else
          if @table[x,y-1] == 0
            fr[x] << y
          end
          if @table[x,y+1] == 0
            cl << [x,y]
          end
        end
      end
    end
    for y in 0...@table.ysize
      loading.progress((@table.xsize+y)/rate)
      for x in 0...@table.xsize
        next if @table[x,y] != 0b1
        if @table[x-1,y] != 0b1
          wl << [x,y]
        end
        if @table[x+1,y] != 0b1
          wr << [x,y]
        end
      end
    end
    si = 9
    unless fr[0].empty?
      for y in fr[0]
        sr[si] = {}
        sr[si][0] = y
        @table[0,y] = si
        si += 1
      end
    end
    loading.change_text("Optimizing...")
    loading.clear_progress
    rate = fr.size.to_f/100.0
    for x in 1...fr.size
      loading.progress(x/rate)
      next if fr[x].empty?
      for y in fr[x]
        for i in (-Max_Elevation)..Max_Elevation
          if @table[x-1,y+i] > 6
            @table[x,y] = @table[x-1,y+i]
            sr[@table[x,y]][x] = y
          end
        end
        next if @table[x,y] > 6
        @table[x,y] = si
        sr[si] = {}
        sr[si][x] = y
        si += 1
      end
    end
    loading.progress(100)
    loading.change_text("Saving...",AWA)
    10.times do; Graphics.update; end
    content << "{"
    sr.keys.each { |key| content << "#{key.to_s}=>#{sr[key].to_s},"}
    content << "}\n"
    content << cl.to_s
    content << "\n"
    content << wr.to_s
    content << "\n"
    content << wl.to_s
    content << "\n"
    @water.each { |rect| pwater << [rect.x-1,rect.y-1,rect.x+rect.width,rect.y+rect.height]}
    content << pwater.to_s
    content << "\n"
    @ice.each { |rect| pice << [rect.x-1,rect.y-1,rect.x+rect.width,rect.y+rect.height]}
    content << pice.to_s
    content << "\n"
    content << @stairs.to_s
    content << "\n"
    content << psr.to_s
    content << "\n"
    File.open("Data/Arc#{@id}.rgss3a", 'w') {|file| file.write("") }
    content.each { |c| File.open("Data/Arc#{@id}.rgss3a", 'a') {|file| file.write(c) }}
    loading.leave
    loading = nil
  end
  def unload
    @surface = nil
    @table = nil
    @water = nil
    @ice = nil
    @stairs = nil
    unless @tbitmap == nil
      @tbitmapdispose
      @tbitmap = nil
    end
  end
  def load
    time = Time.now
    cl = 0; wr = 0; wl = 0; psr = 0
    cline = 1
    File.open("Data/Arc#{@id}.rgss3a",'r') do |file|
      file.each_line do |line|
        case cline
        when 1
          @surface = eval(line)
        when 2
          cl = eval(line)
        when 3
          wr = eval(line)
        when 4
          wl = eval(line)
        when 5
          @water = eval(line)
        when 6
          @ice = eval(line)
        when 7
          @stairs = eval(line)
        when 8
          psr = eval(line)
        end
        cline += 1
      end
    end
    @table = Table.new(@width,@height+Death_Zone_Height)
    wr.each {|c| @table[c[0],c[1]] = 8}
    wl.each {|c| @table[c[0],c[1]] = 8}
    cl.each {|c| @table[c[0],c[1]] = 8}
    psr.each {|c| @table[c[0],c[1]] = 7}
    @surface.keys.each{|key| @surface[key].keys.each {|c| @table[c,@surface[key][c]] = key}}
    for c in @stairs
      for addx in 0...16
        for addy in 0...16
          @table[c[0]+addx,c[1]+addy] = 1
        end
      end
    end
    print "Map #{@id} loaded in #{Time.now - time} secs\n"
  end
  def scan(map,tileset)
    @water = []
    @ice = []
    @stairs = []
    @mode == 0x1 && @msprite != nil ? scan_pixels : scan_tiles(map,tileset)
  end
  def scan_pixels
    @width = @msprite.width
    @height = @msprite.height
    loading = Arc_LWindow.new(0,240)
    loading.enter
    rate = @msprite.width.to_f/100.0
    @table = Table.new(@msprite.width,@msprite.height) #Collision Table
    @tbitmap = Bitmap.new(@table.xsize,@table.ysize)
    for x in 0...@table.xsize
      loading.progress(x/rate)
      for y in 0...@table.ysize
        next if @msprite.bitmap.get_pixel(x,y).alpha == 0
        @table[x,y] = 0b1
        @tbitmap.set_pixel(x,y,COLORS[0b1])
      end
    end
    loading.leave
    loading = nil
  end
  def scan_tiles(map,tileset)
    @width = map.width*32
    @height = map.height*32
    loading = Arc_LWindow.new(0,240)
    loading.enter
    rate = map.width.to_f/100.0
    @table = Table.new(map.width*32,map.height*32)
    @tbitmap = Bitmap.new(@table.xsize,@table.ysize)
    for x in 0...map.width
      loading.progress(x/rate)
      for y in 0...map.height
        if !check_passage(x,y,map,tileset)
          @tbitmap.fill_rect(x*32,y*32,32,32,COLORS[0b1])
          for ax in 0..31
            for ay in 0..31
              @table[x*32+ax,y*32+ay] = 0b1
            end
          end
        end
      end
    end
    loading.leave
    loading = nil
  end
  def check_passage(x,y,map,tileset)
    ([2,1,0].collect {|z| map.data[x,y,z] || 0 }).each do |tile_id|
      flag = tileset.flags[tile_id]
      next if flag & 0x10 != 0x0
      return true  if flag & 0xf == 0x0
      return false if flag & 0xf == 0xf
    end
    return false
  end
  def get_table_bitmap
    return @tbitmap
  end
  def scroll_x(ax)
    @bsprite.x += ax if @bsprite != nil
    @msprite.x += ax if @msprite != nil
    @tsprite.x += ax if @tsprite != nil
  end
  def scroll_y(ay)
    @bsprite.y += ay if @bsprite != nil
    @msprite.y += ay if @msprite != nil
    @tsprite.y += ay if @tsprite != nil
  end
end

#-------------------------------------------------------------------------------
# * Arc WString
#-------------------------------------------------------------------------------

class Arc_WString
  def initialize(x,y,w,h,text,align,color)
    @x = x
    @y = y
    @w = w
    @h = h
    @text = text
    @align = align
    @color = color
  end
  def draw_at(bitmap)
    bitmap.font.color = @color
    bitmap.draw_text(@x,@y,@w,@h,@text,@align)
  end
end

#-------------------------------------------------------------------------------
# * Arc WItem
#-------------------------------------------------------------------------------

class Arc_WItem
  attr_accessor :active
  def initialize(x,y,w,h,text,align,active)
    @x = x
    @y = y
    @w = w
    @h = h
    @text = text
    @align = align
    @active = active
  end
  def draw_at(bitmap)
    bitmap.font.color = (@active ? Arc_Core::AWA : Arc_Core::AWF)
    bitmap.draw_text(@x,@y,@w,@h,@text,@align)
  end
end

#-------------------------------------------------------------------------------
# * Arc Whr
#-------------------------------------------------------------------------------

class Arc_Whr
  def initialize(y,w)
    @y = y
    @w = w
  end
  def draw_at(bitmap)
    bitmap.fill_rect(3,@y,@w-6,1,Arc_Core::AWC)
  end
end

#-------------------------------------------------------------------------------
# * Arc Window
#-------------------------------------------------------------------------------

class Arc_Window < Sprite
  attr_accessor :input_sensitive
  attr_accessor :is_vertical
  attr_accessor :active_index
  def initialize(x,y,width,height,opacity=0)
    super(nil)
    @input_sensitive = false
    @is_vertical = true
    @active_index = 0
    @contents = []
    @items = []
    self.x = x
    self.y = y
    @w = width
    @h = height
    self.bitmap = Bitmap.new(@w,@h)
    self.opacity = opacity
    Arc_Core.set_font(self.bitmap)
    draw_bg
  end
  def toggle
    @input_sensitive = !@input_sensitive
  end
  def hr(y)
    lh = Arc_Whr.new(y,@w)
    lh.draw_at(self.bitmap)
    @contents << lh
  end
  def draw_bg
    self.bitmap.fill_rect(0,1,@w,@h-2,Arc_Core::AWB)
    self.bitmap.fill_rect(1,0,@w-2,@h,Arc_Core::AWB)
    self.bitmap.fill_rect(2,1,@w-4,1,Arc_Core::AWC)
    self.bitmap.fill_rect(2,@h-2,@w-4,1,Arc_Core::AWC)
    self.bitmap.fill_rect(1,2,1,@h-4,Arc_Core::AWC)
    self.bitmap.fill_rect(@w-2,2,1,@h-4,Arc_Core::AWC)
    self.bitmap.set_pixel(2,2,Arc_Core::AWC)
    self.bitmap.set_pixel(2,@h-3,Arc_Core::AWC)
    self.bitmap.set_pixel(@w-3,2,Arc_Core::AWC)
    self.bitmap.set_pixel(@w-3,@h-3,Arc_Core::AWC)
    @bg = self.bitmap.clone
  end
  def redraw
    self.bitmap.clear
    self.bitmap = @bg.clone
    @contents.each { |ac| ac.draw_at(self.bitmap) }
    @items.each { |ai| ai.draw_at(self.bitmap) }
  end
  def erase_contents
    @contents.clear
    redraw
  end
  def erase_items
    @items.clear
    redraw
  end
  def draw_text(x,y,w,h,text,align=1,color=Arc_Core::AWC)
    w = @w if w == :w
    h = @h if h == :h
    string = Arc_WString.new(x,y,w,h,text,align,color)
    string.draw_at(self.bitmap)
    @contents << string 
  end
  def add_item(x,y,w,h,text,align=1,active)
    w = @w if w == :w
    h = @h if h == :h
    item = Arc_WItem.new(x,y,w,h,text,align,active)
    item.draw_at(self.bitmap)
    @items << item
  end
  def update
    update_slide
    if @input_sensitive && @items.size > 0
      if @is_vertical
        if Input.trigger?(:UP)
          next_item(-1)
        elsif Input.trigger?(:DOWN)
          next_item(1)
        end
      else
        if Input.trigger?(:LEFT)
          next_item(-1)
        elsif Input.trigger?(:RIGHT)
          next_item(1)
        end
      end
    end
  end
  def next_item(dir)
    RPG::SE.new("Decision1",70,150).play
    @items.each { |i| i.active = false }
    @active_index += dir
    @active_index %= @items.size
    @items[@active_index].active = true
    redraw
  end
  def dispose
    @bg.dispose
    self.bitmap.dispose
    super
  end
  def draw_32rect(x,y,active)
    self.bitmap.fill_rect(x,y,32,1,active ? Arc_Core::AWA : Arc_Core::AWF)
    self.bitmap.fill_rect(x,y+31,32,1,active ? Arc_Core::AWA : Arc_Core::AWF)
    self.bitmap.fill_rect(x,y+1,1,30,active ? Arc_Core::AWA : Arc_Core::AWF)
    self.bitmap.fill_rect(x+31,y+1,1,30,active ? Arc_Core::AWA : Arc_Core::AWF)
  end
  def draw_icon(x,y,index,active)
    self.bitmap.blt(x,y,Cache.system("Iconset"),Rect.new(index%16*24,index/16*24,24,24),active ? 255 : 160)
  end
  def draw_brush(x,y,id)
    self.bitmap.fill_rect(x,y,32,32,Arc_Core::AWB)
    self.bitmap.blt(x,y,Cache.system("brushes"),Rect.new(id*32,0,32,32))
  end
end

#-------------------------------------------------------------------------------
# * Arc LWindow
#-------------------------------------------------------------------------------

class Arc_LWindow < Sprite
  def initialize(x,y,opacity=0)
    super(nil)
    self.x = x
    self.y = y
    self.z = 1000
    @w = 211
    @h = 56
    @last = 0
    self.ox = 106
    self.oy = 28
    self.bitmap = Bitmap.new(@w,@h)
    self.opacity = opacity
    Arc_Core.set_font(self.bitmap)
    draw_bg
    draw_text(0,4,@w,16," Arc Engine ",1,Arc_Core::AWC)
    draw_text(0,26,@w,16," Loading... ",1,Arc_Core::AWC)
    hr(22)
    loading_bg
  end
  def hr(y)
    Arc_Whr.new(y,@w).draw_at(self.bitmap)
  end
  def change_text(new_text,color=Arc_Core::AWC)
    self.bitmap.fill_rect(4,26,@w-8,16,Arc_Core::AWB)
    draw_text(0,26,@w,16," #{new_text} ",1,color)
  end
  def draw_bg
    self.bitmap.fill_rect(0,1,@w,@h-2,Arc_Core::AWB)
    self.bitmap.fill_rect(1,0,@w-2,@h,Arc_Core::AWB)
    self.bitmap.fill_rect(2,1,@w-4,1,Arc_Core::AWC)
    self.bitmap.fill_rect(2,@h-2,@w-4,1,Arc_Core::AWC)
    self.bitmap.fill_rect(1,2,1,@h-4,Arc_Core::AWC)
    self.bitmap.fill_rect(@w-2,2,1,@h-4,Arc_Core::AWC)
    self.bitmap.set_pixel(2,2,Arc_Core::AWC)
    self.bitmap.set_pixel(2,@h-3,Arc_Core::AWC)
    self.bitmap.set_pixel(@w-3,2,Arc_Core::AWC)
    self.bitmap.set_pixel(@w-3,@h-3,Arc_Core::AWC)
  end
  def draw_text(x,y,w,h,text,align=1,color=Arc_Core::AWC)
    w = @w if w == :w
    h = @h if h == :h
    Arc_WString.new(x,y,w,h,text,align,color).draw_at(self.bitmap)
  end
  def loading_bg
    self.bitmap.fill_rect(5,44,201,1,Arc_Core::AWF)
    self.bitmap.fill_rect(5,49,201,1,Arc_Core::AWF)
    self.bitmap.fill_rect(5,45,1,4,Arc_Core::AWF)
    self.bitmap.fill_rect(205,45,1,4,Arc_Core::AWF)
  end
  def progress(rate)
    return if @last == rate.to_i
    @last = rate.to_i
    for i in 1..@last
      self.bitmap.fill_rect(4+i*2,45,1,4,Arc_Core::AWA)
    end
    Graphics.update
  end
  def clear_progress
    self.bitmap.fill_rect(6,45,199,4,Arc_Core::AWB)
  end
  def dispose
    self.bitmap.dispose
    super
  end
  def enter
    ssx(320,20)
    21.times do
      update_slide
      self.opacity += 13
      Graphics.update
    end
  end
  def leave
    progress(100)
    ssx(640,20)
    21.times do
      update_slide
      self.opacity -= 13
      Graphics.update
    end
    dispose
  end
end

#-------------------------------------------------------------------------------
# * Arc Button
#-------------------------------------------------------------------------------

class Arc_Button < Sprite
  attr_reader :label
  attr_reader :status
  attr_accessor :active
  def initialize(x,y,w,h,label,align,active)
    super(nil)
    self.x = x
    self.y = y
    self.bitmap = Bitmap.new(w,h)
    Arc_Core.set_font(self.bitmap)
    @w = w
    @h = h
    @label = label
    @align = align
    @active = active
    @status = false
  end
  def refresh(mx,my)
    return false unless @active
    @status = (mx >= self.x && mx < (self.x+@w)) && (my >= self.y && my < (self.y+@h))
    redraw
  end
  def redraw
    self.bitmap.clear
    self.bitmap.font.color = (@status ? Arc_Core::AWA : Arc_Core::AWF)
    self.bitmap.draw_text(0,0,@w,@h," #{@label} ",@align)
  end
  def dispose
    self.bitmap.dispose
    super
  end
end

#-------------------------------------------------------------------------------
# * Arc ZR
#-------------------------------------------------------------------------------

class Arc_ZR < Sprite
  attr_reader :rt
  def initialize(viewport)
    super(viewport)
    self.bitmap = Bitmap.new(34,34)
    self.bitmap.fill_rect(0,0,34,1,Color.new(255,255,255))
    self.bitmap.fill_rect(0,33,34,1,Color.new(255,255,255))
    self.bitmap.fill_rect(0,1,1,32,Color.new(255,255,255))
    self.bitmap.fill_rect(33,1,1,32,Color.new(255,255,255))
    self.z = 200
    set_pos(0,0)
  end
  def set_pos(rx,ry)
    self.x = rx - 1
    self.y = ry - 1
    self.x = -1 if self.x < -1
    self.x = 475 if self.x > 475
    self.y = -1 if self.y < -1
    self.y = 339 if self.y > 339
  end
  def dispose
    self.bitmap.dispose
    super
  end
end

#-------------------------------------------------------------------------------
# * Arc Interface
#-------------------------------------------------------------------------------

class Arc_Interface
  include Arc_Core
  def load
    unless try_load
      $map_data = {}
      save
      cmap_dir = Dir::pwd + "/Graphics/Custom Maps"
      unless FileTest::directory?(cmap_dir)
        Dir::mkdir(cmap_dir)
      end
    end
  end
  private
  def save
    File.open("Data/ArcData.rgss3a",'wb') {|file| Marshal.dump($map_data,file)}
  end
  def try_load
    File.open("Data/ArcData.rgss3a",'rb') {|data| $map_data = Marshal.load(data)} rescue (return false)
    return true
  end
  public
  def call_menu
    create_background
    main_menu
    dispose_background
  end
  def main_menu(fi=0)
    open_menu(fi)
    menu_loop
  end
  def menu_loop
    @action = nil
    loop do
      Graphics.update
      Input.update
      @menu_window.update
      @help_window.update
      if @index != @menu_window.active_index
        @index = @menu_window.active_index
        @help_window.erase_contents
        @help_window.draw_text(0,4,:w,16," Description ",1,AWT)
        @help_window.hr(22)
        case @index
        when 0
          @help_window.draw_text(4,26,248,16," Launch your game Scene_Title with Arc Engine",0,AWC)
          @help_window.draw_text(4,44,248,16," fully loaded.",0,AWC)
        when 1
          @help_window.draw_text(4,26,248,16," Start the Physics Editor.",0,AWC)
          @help_window.draw_text(4,44,248,16," You must load your maps at this editor to ",0,AWC)
          @help_window.draw_text(4,62,248,16," configure them. It will activate the",0,AWC)
          @help_window.draw_text(4,80,248,16," Pixel Perfect collision system.",0,AWC)
          @help_window.draw_text(4,116,248,16," Use your Keyboard and your Mouse to edit.",0,AWC)
        when 2
          @help_window.draw_text(4,26,248,16," Arc Engine - Platform v1.0",0,AWT)
          @help_window.draw_text(4,44,248,16," Created by Khas Arcthunder",0,AWC)
          @help_window.draw_text(4,80,248,16," Visit Arcthunder Blog for more!",0,AWC)
          @help_window.draw_text(4,98,248,16," http://arcthunder.com",0,AWA)
          @help_window.draw_text(4,116,248,16," http://rgssx.com",0,AWA)
        when 3
          @help_window.draw_text(4,26,248,16," Exit to RPG Maker VX Ace.",0,AWC)
        end
      end
      if Input.trigger?(:C)
        case @menu_window.active_index
        when 0
          RPG::SE.new("Decision2",80,100).play
          close_menu
          @action = :launch
          break
        when 1
          RPG::SE.new("Decision2",80,100).play
          close_menu
          @action = :editor
          break
        when 2
          RPG::SE.new("Decision2",80,100).play
          confirm_browser
        when 3
          RPG::SE.new("Decision2",80,100).play
          close_menu
          dispose_background
          exit
        end
      end
    end
    start_physics_editor if @action == :editor
  end
  def open_menu(force_index=0)
    mw = 128; mh = 208; hw = 256; hh = 208
    @menu_window = Arc_Window.new(544,208-mh/2,mw,mh)
    @help_window = Arc_Window.new(-hw,208-hh/2,hw,hh)
    @menu_window.ssx(272-(mw+hw+4)/2,30)
    @help_window.ssx(276-(mw+hw+4)/2+mw,30)
    @menu_window.draw_text(0,4,:w,16," Arc Engine ",1,AWT)
    @help_window.draw_text(0,4,:w,16," Description ",1,AWT)
    @menu_window.hr(22)
    @help_window.hr(22)
    @menu_window.add_item(4,26,96,16,"- Launch Game",0,force_index == 0)
    @menu_window.add_item(4,44,96,16,"- Physics Editor",0,force_index == 1)
    @menu_window.add_item(4,62,96,16,"- About Arc Engine",0,force_index == 2)
    @menu_window.add_item(4,80,96,16,"- Exit",0,force_index == 3)
    @menu_window.input_sensitive = true
    @menu_window.z = 100
    @help_window.z = 100
    @menu_window.active_index = force_index
    @index = 10
    20.times do
      Graphics.update
      @menu_window.update
      @help_window.update
      @menu_window.opacity += 10
      @help_window.opacity += 10
    end
  end
  def close_menu
    @menu_window.ssx(544,30)
    @help_window.ssx(-256,30)
    20.times do
      Graphics.update
      @menu_window.update
      @help_window.update
      @menu_window.opacity -= 10
      @help_window.opacity -= 10
    end
    @menu_window.dispose
    @help_window.dispose
    @menu_window = nil
    @help_window = nil
  end
  def confirm_browser
    close_menu
    @confirm_window = Arc_Window.new(144,416,256,96)
    @confirm_window.draw_text(0,4,:w,16," Arc Engine ",1,AWT)
    @confirm_window.hr(22)
    @confirm_window.draw_text(4,26,248,16," Press ENTER to open Arcthunder Blog or",0,AWC)
    @confirm_window.draw_text(4,44,248,16," press X to go back.",0,AWC)
    @confirm_window.draw_text(4,62,248,16," http://arcthunder.com",0,AWA)
    @confirm_window.ssy(160,20)
    @confirm_window.z = 20
    20.times do
      Graphics.update
      @confirm_window.opacity += 13
      @confirm_window.update
    end
    loop do
      Graphics.update
      Input.update
      @confirm_window.update
      if Input.trigger?(:C)
        RPG::SE.new("Decision2",80,100).play
        system("start http://arcthunder.com")
      elsif Input.trigger?(:B)
        RPG::SE.new("Decision2",80,100).play
        break
      end
    end
    @confirm_window.ssy(416,20)
    20.times do
      Graphics.update
      @confirm_window.opacity -= 13
      @confirm_window.update
    end   
    @confirm_window.dispose
    @confirm_window = nil
    open_menu(2)
  end
  def create_background
    @background = Sprite.new
    @background.bitmap = Bitmap.new(544,416)
    @background.bitmap.fill_rect(0,0,544,416,Color.new(255,255,255))
    @super_background = Sprite.new
    @super_background.bitmap = Bitmap.new(544,416)
    for i in 0...96
      @super_background.bitmap.fill_rect(0,i,544,1,Color.new(0,0,0,96-i))
      @super_background.bitmap.fill_rect(0,415-i,544,1,Color.new(0,0,0,96-i))
    end
    @logo = Sprite.new
    @logo.bitmap = Cache.system("arc")
    @logo.z = 90
    @background.opacity = 0
    @super_background.opacity = 0
    @logo.opacity = 0
    30.times do
      @background.opacity += 9
      @super_background.opacity += 9
      @logo.opacity += 9
      Graphics.update
    end
  end
  def dispose_background
    30.times do
      @background.opacity -= 9
      @super_background.opacity -= 9
      @logo.opacity -= 9
      Graphics.update
    end
    @background.bitmap.dispose
    @background.dispose
    @background = nil
    @super_background.bitmap.dispose
    @super_background.dispose
    @super_background = nil
    @logo.bitmap.dispose
    @logo.dispose
    @logo = nil
  end
  def create_editorbg
    @background = Sprite.new
    @background.bitmap = Bitmap.new(640,480)
    @background.bitmap.fill_rect(0,0,640,480,Color.new(255,255,255))
    @super_background = Sprite.new
    @super_background.bitmap = Bitmap.new(640,480)
    for i in 0...96
      @super_background.bitmap.fill_rect(0,i,640,1,Color.new(0,0,0,96-i))
      @super_background.bitmap.fill_rect(0,479-i,640,1,Color.new(0,0,0,96-i))
    end
    @logo = Sprite.new
    @logo.bitmap = Cache.system("arc")
    @logo.x = 320
    @logo.z = 90
    @logo.ox = 272
    @background.opacity = 0
    @super_background.opacity = 0
    @logo.opacity = 0
    30.times do
      @background.opacity += 9
      @super_background.opacity += 9
      @logo.opacity += 9
      Graphics.update
    end
  end
  def start_physics_editor
    change_resolution
    show_nmw
  end
  def change_resolution
    dispose_background
    Graphics.resize_screen(640,480)
    load_brushes
    create_editorbg
  end
  def restore_resolution
    dispose_background
    Graphics.resize_screen(544,416)
    create_background
  end
  def show_nmw
    @new_window = Arc_Window.new(192,416,256,64)
    @new_window.draw_text(0,4,:w,16," Physics Editor ",1,AWT)
    @new_window.hr(22)
    @new_window.draw_text(4,26,124,16," Select Map:",2,AWC)
    @new_window.draw_text(128,26,124,16," Type Map ID ",0,AWA)
    @new_window.ssy(160,20)
    @new_window.z = 20
    20.times do
      Graphics.update
      @new_window.opacity += 13
      @new_window.update
    end
    @map_id = ""
    @action = nil
    @confirm = Arc_Button.new(256,204,64,16," Ok ",1,true)
    @cancel = Arc_Button.new(320,204,64,16," Cancel ",1,true)
    @confirm.z = 30
    @cancel.z = 30
    Input_Core.refresh_state
    loop do
      Graphics.update
      mpos = Input_Core.mpos
      num = Input_Core.any_number?
      @confirm.refresh(mpos[0],mpos[1])
      @cancel.refresh(mpos[0],mpos[1])
      if num != nil
        @map_id += num.to_s unless @map_id.size > 3
        @new_window.erase_contents
        @new_window.draw_text(0,4,:w,16," Physics Editor ",1,AWT)
        @new_window.hr(22)
        @new_window.draw_text(4,26,124,16," Select Map:",2,AWC)
        @new_window.draw_text(128,26,124,16," #{@map_id} ",0,AWA)
      elsif Input_Core.trigger?(:Backspace)
        @map_id[@map_id.size-1] = "" unless @map_id.size < 1
        @new_window.erase_contents
        @new_window.draw_text(0,4,:w,16," Physics Editor ",1,AWT)
        @new_window.hr(22)
        @new_window.draw_text(4,26,124,16," Select Map:",2,AWC)
        @new_window.draw_text(128,26,124,16," #{@map_id} ",0,AWA)
      elsif Input_Core.trigger?(:ML)
        if @confirm.status
          if load_map(@map_id.to_i)
            RPG::SE.new("Decision2",80,100).play
            @action = :confirm
            break
          else
            RPG::SE.new("Buzzer1",80,100).play
            @new_window.erase_contents
            @new_window.draw_text(0,4,:w,16," Physics Editor ",1,AWT)
            @new_window.hr(22)
            @new_window.draw_text(4,26,124,16," Select Map:",2,AWC)
            @new_window.draw_text(128,26,124,16," Invalid Map ",0,AWE)
            @map_id = ""
          end 
        elsif @cancel.status
          RPG::SE.new("Decision2",80,100).play
          @action = :cancel
          break
        end
      end
    end
    @confirm.dispose
    @cancel.dispose
    @confirm = nil
    @cancel = nil
    @new_window.ssy(416,20)
    20.times do
      Graphics.update
      @new_window.opacity -= 13
      @new_window.update
    end   
    @new_window.dispose
    @new_window = nil
    if @action == :cancel
      restore_resolution
      @brush_data.clear
      main_menu(1)
    elsif @action == :confirm
      @map_id.to_i
      @mapcore = Arc_MapCore.new(@map_id.to_i,@map.display_name,TILE_RDG)
      create_editor_windows
      @mapcore.scan(@map,@tileset)
      @collision = Sprite.new(@map_viewport)
      @collision.bitmap = @mapcore.get_table_bitmap
      @collision.z = 150
      @areas = Sprite.new(@map_viewport)
      @areas.bitmap = @collision.bitmap.clone
      @areas.bitmap.clear
      @areas.visible = false
      @areas.z = 150
      editor_loop
    end
  end
  def load_map(id)
    @map = load_data(sprintf("Data/Map%03d.rvdata2",id.to_i)) rescue (return false)
    return true
  end
  def select_map_options
    @options_window = Arc_Window.new(192,416,256,156)
    @options_window.draw_text(0,4,:w,16," Map Options ",1,AWT)
    @options_window.hr(22)
    @options_window.draw_text(4,26,248,16," Map ID: #{@mapcore.id}",0,AWC)
    @options_window.draw_text(4,44,248,16," Display Name: #{@mapcore.name == "" ? "No Name" : @mapcore.name}",0,AWC)
    @options_window.draw_text(4,62,248,16," Scan mode: #{@mapcore.mode == 0x0 ? "Default" : "Custom"}",0,AWC)
    @options_window.draw_text(4,80,248,16," Custom Background:",0,AWC)
    @options_window.draw_text(4,98,248,16," Custom Main:",0,AWC)
    @options_window.draw_text(4,116,248,16," Custom Top:",0,AWC)
    @rect = [124,[80,98,116],128,16,316,[222,240,258]]
    @options_window.bitmap.fill_rect(@rect[0],@rect[1][0],@rect[2],@rect[3],AWLB)
    @options_window.draw_text(@rect[0],@rect[1][0],@rect[2],@rect[3]," disabled",2,AWC)
    @options_window.bitmap.fill_rect(@rect[0],@rect[1][1],@rect[2],@rect[3],AWLB)
    @options_window.draw_text(@rect[0],@rect[1][1],@rect[2],@rect[3]," disabled",2,AWC)
    @options_window.bitmap.fill_rect(@rect[0],@rect[1][2],@rect[2],@rect[3],AWLB)
    @options_window.draw_text(@rect[0],@rect[1][2],@rect[2],@rect[3]," disabled",2,AWC)
    @options_window.ssy(142,20)
    @options_window.z = 20
    20.times do
      Graphics.update
      @options_window.opacity += 13
      @options_window.update
    end
    @help_window = Arc_Window.new(0,0,168,112)
    @help_window.z = 40
    @confirm = Arc_Button.new(256,276,64,16," Scan ",1,true)
    @cancel = Arc_Button.new(320,276,64,16," Cancel ",1,true)
    @confirm.z = 30
    @cancel.z = 30
    @active_input = nil
    Input_Core.refresh_state
    loop do
      Graphics.update
      mpos = Input_Core.mpos
      letter = Input_Core.letter_number?
      @help_window.x = mpos[0]+18
      @help_window.y = mpos[1]+6
      @confirm.refresh(mpos[0],mpos[1])
      @cancel.refresh(mpos[0],mpos[1])
      if mpos[0] > 191 && mpos[0] < 444 && mpos[1] > 203 && mpos[1] < 220
        unless @help_window.active_index == 0
          @help_window.active_index = 0
          @help_window.opacity = 255
          @help_window.erase_contents
          @help_window.draw_text(4,4,160,16," Click to change scan mode.",0,AWH)
          @help_window.draw_text(4,22,160,16," If set to DEFAULT, your map",0,AWH)
          @help_window.draw_text(4,40,160,16," will be scanned by tiles.",0,AWH)
          @help_window.draw_text(4,58,160,16," If set to CUSTOM, your map's",0,AWH)
          @help_window.draw_text(4,76,160,16," main Custom Graphic will be",0,AWH)
          @help_window.draw_text(4,94,160,16," scanned by pixels.",0,AWH)
        end
      elsif mpos[0] > 191 && mpos[0] < 444 && mpos[1] > 221 && mpos[1] < 238
        unless @help_window.active_index == 1
          @help_window.active_index = 1
          @help_window.opacity = 255
          @help_window.erase_contents
          @help_window.draw_text(4,4,160,16," Click to add a Custom Graphic.",0,AWH)
          @help_window.draw_text(4,22,160,16," This graphic will be displayed",0,AWH)
          @help_window.draw_text(4,40,160,16," as your map background layer.",0,AWH)
          @help_window.draw_text(4,58,160,16," It must be located at ",0,AWH)
          @help_window.draw_text(4,76,160,16," Graphics/Custom Maps folder.",0,AWH)
          @help_window.draw_text(4,94,160,16," Extension must be omitted.",0,AWH)
        end
      elsif mpos[0] > 191 && mpos[0] < 444 && mpos[1] > 239 && mpos[1] < 256
        unless @help_window.active_index == 2
          @help_window.active_index = 2
          @help_window.opacity = 255
          @help_window.erase_contents
          @help_window.draw_text(4,4,160,16," Click to add a Custom Graphic.",0,AWH)
          @help_window.draw_text(4,22,160,16," This graphic will be displayed",0,AWH)
          @help_window.draw_text(4,40,160,16," as your map main layer.",0,AWH)
          @help_window.draw_text(4,58,160,16," It must be located at ",0,AWH)
          @help_window.draw_text(4,76,160,16," Graphics/Custom Maps folder.",0,AWH)
          @help_window.draw_text(4,94,160,16," Extension must be omitted.",0,AWH)
        end
      elsif mpos[0] > 191 && mpos[0] < 444 && mpos[1] > 257 && mpos[1] < 274
        unless @help_window.active_index == 3
          @help_window.active_index = 3
          @help_window.opacity = 255
          @help_window.erase_contents
          @help_window.draw_text(4,4,160,16," Click to add a Custom Graphic.",0,AWH)
          @help_window.draw_text(4,22,160,16," This graphic will be displayed",0,AWH)
          @help_window.draw_text(4,40,160,16," as your map top layer.",0,AWH)
          @help_window.draw_text(4,58,160,16," It must be located at ",0,AWH)
          @help_window.draw_text(4,76,160,16," Graphics/Custom Maps folder.",0,AWH)
          @help_window.draw_text(4,94,160,16," Extension must be omitted.",0,AWH)
        end
      else
        @help_window.active_index = nil
        @help_window.erase_contents
        @help_window.opacity = 0
      end
      if letter != nil
        letter.is_a?(Symbol) ? letter = Input_Core::LettersTable[letter][Input_Core.toggled?(:CapsLock) || Input_Core.press?(:Shift) ? 1 : 0] : letter = letter.to_s
        case @active_input
        when 0; @mapcore.background += letter if @mapcore.background.size < 20
        when 1; @mapcore.main += letter if @mapcore.main.size < 20
        when 2; @mapcore.top += letter if @mapcore.top.size < 20
        end
        @options_window.bitmap.fill_rect(@rect[0],@rect[1][0],@rect[2],@rect[3],AWLB)
        @options_window.bitmap.fill_rect(@rect[0],@rect[1][1],@rect[2],@rect[3],AWLB)
        @options_window.bitmap.fill_rect(@rect[0],@rect[1][2],@rect[2],@rect[3],AWLB)
        @options_window.draw_text(@rect[0],@rect[1][0],@rect[2],@rect[3],@mapcore.background.size == 0 ? " disabled" : " #{@mapcore.background}",2,@active_input == 0 ? AWA : AWC)
        @options_window.draw_text(@rect[0],@rect[1][1],@rect[2],@rect[3],@mapcore.main.size == 0 ? " disabled" : " #{@mapcore.main}",2,@active_input == 1 ? AWA : AWC)
        @options_window.draw_text(@rect[0],@rect[1][2],@rect[2],@rect[3],@mapcore.top.size == 0 ? " disabled" : " #{@mapcore.top}",2,@active_input == 2 ? AWA : AWC)
      elsif Input_Core.trigger?(:Backspace)
        case @active_input
        when 0; @mapcore.background[@mapcore.background.size-1] = "" unless @mapcore.background.size < 1
        when 1; @mapcore.main[@mapcore.main.size-1] = "" unless @mapcore.main.size < 1
        when 2; @mapcore.top[@mapcore.top.size-1] = "" unless @mapcore.top.size < 1
        end
        @options_window.bitmap.fill_rect(@rect[0],@rect[1][0],@rect[2],@rect[3],AWLB)
        @options_window.bitmap.fill_rect(@rect[0],@rect[1][1],@rect[2],@rect[3],AWLB)
        @options_window.bitmap.fill_rect(@rect[0],@rect[1][2],@rect[2],@rect[3],AWLB)
        @options_window.draw_text(@rect[0],@rect[1][0],@rect[2],@rect[3],@mapcore.background.size == 0 ? " disabled" : " #{@mapcore.background}",2,@active_input == 0 ? AWA : AWC)
        @options_window.draw_text(@rect[0],@rect[1][1],@rect[2],@rect[3],@mapcore.main.size == 0 ? " disabled" : " #{@mapcore.main}",2,@active_input == 1 ? AWA : AWC)
        @options_window.draw_text(@rect[0],@rect[1][2],@rect[2],@rect[3],@mapcore.top.size == 0 ? " disabled" : " #{@mapcore.top}",2,@active_input == 2 ? AWA : AWC)
      elsif Input_Core.trigger?(:ML)
        @active_input = nil
        for i in 0..2
          @active_input = i if mpos[0] >= @rect[4] && mpos[0] < (@rect[4] + @rect[2]) && mpos[1] >= @rect[5][i] && mpos[1] < (@rect[5][i] + @rect[3])
        end
        @options_window.bitmap.fill_rect(@rect[0],@rect[1][0],@rect[2],@rect[3],AWLB)
        @options_window.bitmap.fill_rect(@rect[0],@rect[1][1],@rect[2],@rect[3],AWLB)
        @options_window.bitmap.fill_rect(@rect[0],@rect[1][2],@rect[2],@rect[3],AWLB)
        @options_window.draw_text(@rect[0],@rect[1][0],@rect[2],@rect[3],@mapcore.background.size == 0 ? " disabled" : " #{@mapcore.background}",2,@active_input == 0 ? AWA : AWC)
        @options_window.draw_text(@rect[0],@rect[1][1],@rect[2],@rect[3],@mapcore.main.size == 0 ? " disabled" : " #{@mapcore.main}",2,@active_input == 1 ? AWA : AWC)
        @options_window.draw_text(@rect[0],@rect[1][2],@rect[2],@rect[3],@mapcore.top.size == 0 ? " disabled" : " #{@mapcore.top}",2,@active_input == 2 ? AWA : AWC)
        if @active_input == nil
          if mpos[0] > 191 && mpos[0] < 444 && mpos[1] > 203 && mpos[1] < 220
            @mapcore.mode = (@mapcore.mode == 0x0 ? 0x1 : 0x0)
            @options_window.bitmap.fill_rect(4,62,248,16,AWB)
            @options_window.bitmap.font.color = AWC
            @options_window.bitmap.draw_text(4,62,248,16," Scan mode: #{@mapcore.mode == 0x0 ? "Default" : "Custom"}")
          elsif @confirm.status
            if !@mapcore.try_loadbackground
              RPG::SE.new("Buzzer1",80,100).play
              @mapcore.background = ""
              @options_window.bitmap.fill_rect(@rect[0],@rect[1][0],@rect[2],@rect[3],AWLB)
              @options_window.bitmap.fill_rect(@rect[0],@rect[1][1],@rect[2],@rect[3],AWLB)
              @options_window.bitmap.fill_rect(@rect[0],@rect[1][2],@rect[2],@rect[3],AWLB)
              @options_window.draw_text(@rect[0],@rect[1][0],@rect[2],@rect[3]," Invalid Graphic!",2,AWE)
              @options_window.draw_text(@rect[0],@rect[1][1],@rect[2],@rect[3],@mapcore.main.size == 0 ? " disabled" : " #{@mapcore.main}",2,@active_input == 1 ? AWA : AWC)
              @options_window.draw_text(@rect[0],@rect[1][2],@rect[2],@rect[3],@mapcore.top.size == 0 ? " disabled" : " #{@mapcore.top}",2,@active_input == 2 ? AWA : AWC)
            elsif !@mapcore.try_loadmain
              RPG::SE.new("Buzzer1",80,100).play
              @mapcore.main = ""
              @options_window.bitmap.fill_rect(@rect[0],@rect[1][0],@rect[2],@rect[3],AWLB)
              @options_window.bitmap.fill_rect(@rect[0],@rect[1][1],@rect[2],@rect[3],AWLB)
              @options_window.bitmap.fill_rect(@rect[0],@rect[1][2],@rect[2],@rect[3],AWLB)
              @options_window.draw_text(@rect[0],@rect[1][0],@rect[2],@rect[3],@mapcore.background.size == 0 ? " disabled" : " #{@mapcore.background}",2,@active_input == 0 ? AWA : AWC)
              @options_window.draw_text(@rect[0],@rect[1][1],@rect[2],@rect[3]," Invalid Graphic!",2,AWE)
              @options_window.draw_text(@rect[0],@rect[1][2],@rect[2],@rect[3],@mapcore.top.size == 0 ? " disabled" : " #{@mapcore.top}",2,@active_input == 2 ? AWA : AWC)
            elsif !@mapcore.try_loadtop
              @mapcore.top = ""
              RPG::SE.new("Buzzer1",80,100).play
              @options_window.bitmap.fill_rect(@rect[0],@rect[1][0],@rect[2],@rect[3],AWLB)
              @options_window.bitmap.fill_rect(@rect[0],@rect[1][1],@rect[2],@rect[3],AWLB)
              @options_window.bitmap.fill_rect(@rect[0],@rect[1][2],@rect[2],@rect[3],AWLB)
              @options_window.draw_text(@rect[0],@rect[1][0],@rect[2],@rect[3],@mapcore.background.size == 0 ? " disabled" : " #{@mapcore.background}",2,@active_input == 0 ? AWA : AWC)
              @options_window.draw_text(@rect[0],@rect[1][1],@rect[2],@rect[3],@mapcore.main.size == 0 ? " disabled" : " #{@mapcore.main}",2,@active_input == 1 ? AWA : AWC)
              @options_window.draw_text(@rect[0],@rect[1][2],@rect[2],@rect[3]," Invalid Graphic!",2,AWE)
            else
              RPG::SE.new("Decision2",80,100).play
              @action = :confirm
              break
            end
          elsif @cancel.status
            RPG::SE.new("Decision2",80,100).play
            @action = :cancel
            break
          end
        end
      end
    end
    @confirm.dispose
    @cancel.dispose
    @confirm = nil
    @cancel = nil
    @help_window.dispose
    @help_window = nil
    @options_window.ssy(416,20)
    20.times do
      Graphics.update
      @options_window.opacity -= 13
      @options_window.update
    end   
    @options_window.dispose
    @options_window = nil
    case @action
    when :confirm
      create_editor_windows
      @mapcore.scan(@map,@tileset)
      @collision = Sprite.new(@map_viewport)
      @collision.bitmap = @mapcore.get_table_bitmap
      @collision.z = 150
      @areas = Sprite.new(@map_viewport)
      @areas.bitmap = @collision.bitmap.clone
      @areas.bitmap.clear
      @areas.visible = false
      @areas.z = 150
      editor_loop
    when :cancel
      show_nmw
    end 
  end
  def editor_loop
    loop do
      Graphics.update
      Input.update
      mpos = Input_Core.mpos
      @confirm.refresh(mpos[0],mpos[1])
      @cancel.refresh(mpos[0],mpos[1])
      if @tilegrid
        if mpos[0] > 7 && mpos[0] < 516 && mpos[1] > 99 && mpos[1] < 472
          @brush.x = mpos[0] - 16 - (mpos[0]-24) % 32 + @collision.x % 32
          @brush.y = mpos[1] - 16 - (mpos[1]-20) % 32 + @collision.y % 32
        end
      else
        @brush.x = mpos[0]-16
        @brush.y = mpos[1]-16
      end
      case Input.dir4
      when 2
        if @collision.y > (372-@collision.height)
          @collision.y -= 4
          @areas.y -= 4
          @tilemap.oy += 4
          @mapcore.scroll_y(-4)
          refresh_preview
        end
      when 4
        if @collision.x < 0
          @collision.x += 4
          @areas.x += 4
          @tilemap.ox -= 4
          @mapcore.scroll_x(4)
          refresh_preview
        end
      when 6
        if @collision.x > (508-@collision.width)
          @collision.x -= 4
          @areas.x -= 4
          @tilemap.ox += 4
          @mapcore.scroll_x(-4)
          refresh_preview
        end
      when 8
        if @collision.y < 0
          @collision.y += 4
          @areas.y += 4
          @tilemap.oy -= 4
          @mapcore.scroll_y(4)
          refresh_preview
        end
      end
      if Input_Core.press?(:ML) && @active_mode == 0
        if mpos[0] > 7 && mpos[0] < 516 && mpos[1] > 99 && mpos[1] < 472
          apply_brush(0b1)
        elsif mpos[0] > 531 && mpos[0] < 628 && mpos[1] > 371 && mpos[1] < 468
          set_pixel((mpos[0]-529)/3+@zoom_rect.x-@collision.x,(mpos[1]-369)/3+@zoom_rect.y-@collision.y,0b1)
        end
      elsif Input_Core.press?(:MR) && @active_mode == 0
        if mpos[0] > 7 && mpos[0] < 516 && mpos[1] > 99 && mpos[1] < 472
          apply_brush(0b0)
        elsif mpos[0] > 531 && mpos[0] < 628 && mpos[1] > 371 && mpos[1] < 468
          set_pixel((mpos[0]-529)/3+@zoom_rect.x-@collision.x,(mpos[1]-369)/3+@zoom_rect.y-@collision.y,0b0)
        end
      elsif Input_Core.press?(:MM) && @active_mode == 0
        if mpos[0] > 7 && mpos[0] < 516 && mpos[1] > 99 && mpos[1] < 472
          apply_brush(0b100)
        elsif mpos[0] > 531 && mpos[0] < 628 && mpos[1] > 371 && mpos[1] < 468
          set_pixel((mpos[0]-529)/3+@zoom_rect.x-@collision.x,(mpos[1]-369)/3+@zoom_rect.y-@collision.y,0b100)
        end
      elsif Input.press?(:CTRL)
        @zoom_rect.set_pos(mpos[0]-23,mpos[1]-115)
        refresh_preview
      elsif Input_Core.trigger?(:ML)
        if @confirm.status
          RPG::SE.new("Decision2",80,100).play
          @action = :confirm
          break
        elsif @cancel.status
          RPG::SE.new("Decision2",80,100).play
          @action = :cancel
          break
        elsif @active_mode != 0 && mpos[0] > 7 && mpos[0] < 516 && mpos[1] > 99 && mpos[1] < 472
          if @active_mode == 3
            toggle_stair(mpos)
          else
            @area_mode == 0 ? @area_vert1 = [mpos[0]-8-@collision.x,mpos[1]-100-@collision.y] : delete_area(mpos)
          end
        elsif  mpos[0] > 527 && mpos[0] < 632 && mpos[1] > 197 && mpos[1] < 214
          if @active_mode == 0
            @active_mode = 3
            refresh_areas
            @areas.visible = true
            @brush.visible = false
            @collision.visible = false
            @brush_window.bitmap.font.color = AWA
            @brush_window.bitmap.fill_rect(4,98,104,16,Arc_Core::AWB)
            @brush_window.bitmap.draw_text(4,98,104,16," Stairs ",1)
          elsif @active_mode == 3
            @active_mode = 0
            @areas.visible = false
            @brush.visible = true
            @collision.visible = true
            @brush_window.bitmap.font.color = AWC
            @brush_window.bitmap.fill_rect(4,98,104,16,Arc_Core::AWB)
            @brush_window.bitmap.draw_text(4,98,104,16," Stairs ",1)
          end
        elsif mpos[0] > 527 && mpos[0] < 632 && mpos[1] > 179 && mpos[1] < 196 && @active_mode == 0
          @tilegrid = !@tilegrid
          @brush_window.bitmap.font.color = (@tilegrid ? AWA : AWC)
          @brush_window.bitmap.fill_rect(4,80,104,16,Arc_Core::AWB)
          @brush_window.bitmap.draw_text(4,80,104,16," Tile Grid",1)
          @brush.x = 8
          @brush.y = 100
        elsif mpos[1] > 99 && mpos[1] < 132
          if mpos[0] > 527 && mpos[0] < 560 
            @active_mode = 0
            @areas.visible = false
            @brush.visible = true
            @collision.visible = true
            @brush_window.erase_contents
            @brush_window.bitmap.fill_rect(4,4,104,96,Arc_Core::AWB)
            @brush_window.draw_text(40,48,68,16," Brush",0,@active_mode == 0 ? AWA : AWF)
            @brush_window.draw_brush(4,40,@active_brush)
            @brush_window.draw_32rect(4,4,@active_mode == 0)
            @brush_window.draw_32rect(40,4,@active_mode == 1)
            @brush_window.draw_32rect(76,4,@active_mode == 2)
            @brush_window.draw_icon(8,8,28,@active_mode == 0)
            @brush_window.draw_icon(44,8,107,@active_mode == 1)
            @brush_window.draw_icon(80,8,105,@active_mode == 2)
            @brush_window.bitmap.font.color = (@tilegrid ? AWA : AWC)
            @brush_window.bitmap.draw_text(4,80,104,16," Tile Grid",1)
            @brush_window.bitmap.font.color = AWC
            @brush_window.bitmap.draw_text(4,98,104,16," Stairs ",1)
            @brush_window.bitmap.draw_text(4,260,104,16," Zoom ",1)
          elsif mpos[0] > 563 && mpos[0] < 596 
            RPG::SE.new("Buzzer1",80,100).play
          elsif mpos[0] > 599 && mpos[0] < 632 
            RPG::SE.new("Buzzer1",80,100).play
          end
        elsif @active_mode == 0 && mpos[0] > 527 && mpos[0] < 632 && mpos[1] > 139 && mpos[1] < 172
          @active_brush = (@active_brush + 1) % 8
          @brush.bitmap.clear
          @brush.bitmap.blt(0,0,Cache.system("brushes"),Rect.new(@active_brush*32,0,32,32))
          @brush_window.draw_brush(4,40,@active_brush)
        elsif @active_mode == 1 || @active_mode == 2
          if mpos[0] > 527 && mpos[0] < 632 && mpos[1] > 139 && mpos[1] < 156
            @area_mode = 0
            @brush_window.bitmap.fill_rect(4,44,104,34,Arc_Core::AWB)
            @brush_window.draw_text(0,44,:w,16," Add Area ",1,AWA)
            @brush_window.draw_text(0,62,:w,16," Delete Area ",1,AWF)
          elsif mpos[0] > 527 && mpos[0] < 632 && mpos[1] > 147 && mpos[1] < 174
            @area_mode = 1
            @brush_window.bitmap.fill_rect(4,44,104,34,Arc_Core::AWB)
            @brush_window.draw_text(0,44,:w,16," Add Area ",1,AWF)
            @brush_window.draw_text(0,62,:w,16," Delete Area ",1,AWA)
          end
        end
      elsif Input_Core.trigger?(:MR)
        if mpos[0] > 7 && mpos[0] < 516 && mpos[1] > 99 && mpos[1] < 472 && (@active_mode == 1 || @active_mode == 2)
          @area_vert2 = [mpos[0]-8-@collision.x,mpos[1]-100-@collision.y] if @area_mode == 0
        end
      elsif Input.trigger?(:C)
        if @active_mode == 1 || @active_mode == 2
          if @area_mode == 0 && ((@area_vert1[0] - @area_vert2[0]).abs > 0) && ((@area_vert1[1] - @area_vert2[1]).abs > 0)
            x1 = (@area_vert1[0] <= @area_vert2[0] ? @area_vert1[0] : @area_vert2[0])
            x2 = (@area_vert1[0] <= @area_vert2[0] ? @area_vert2[0] : @area_vert1[0])
            y1 = (@area_vert1[1] <= @area_vert2[1] ? @area_vert1[1] : @area_vert2[1])
            y2 = (@area_vert1[1] <= @area_vert2[1] ? @area_vert2[1] : @area_vert1[1])
            x1 -= x1 % 32
            y1 -= y1 % 32
            x2 -= x2 % 32
            y2 -= y2 % 32
            x2 += 32
            y2 += 32
            add_area(Rect.new(x1,y1,x2-x1,y2-y1)) 
          end
        end
      end
    end
    @mapcore.unload_sprites
    case @action
    when :confirm
      dispose_editor_windows
      @mapcore.compress
      @mapcore.unload
      $map_data[@mapcore.id] = @mapcore
      save
      show_nmw
    when :cancel
      dispose_editor_windows
      @mapcore = Arc_MapCore.new(@map_id.to_i,@map.display_name,TILE_RDG)
      show_nmw
    end
  end
  def refresh_preview
    return unless Enable_Zoom
    prv = Graphics.snap_to_bitmap
    @preview_image.bitmap.blt(0,0,prv,Rect.new(@zoom_rect.x+9,@zoom_rect.y+101,32,32))
    prv.dispose
  end
  def refresh_areas
    @areas.bitmap.clear
    case @active_mode
    when 1
      for area in @mapcore.water
        @areas.bitmap.fill_rect(area.x,area.y,area.width,area.height,AWW)
      end
    when 2
      for area in @mapcore.ice
        @areas.bitmap.fill_rect(area.x,area.y,area.width,area.height,AWW)
      end
    when 3
      for stair in @mapcore.stairs
        @areas.bitmap.fill_rect(stair[0],stair[1],16,16,AWST)
      end
    end
  end
  def add_area(area)
    @active_mode == 1 ? @mapcore.water << area : @mapcore.ice << area
    @areas.bitmap.fill_rect(area.x,area.y,area.width,area.height,AWW)
  end
  def toggle_stair(mpos)
    x = mpos[0] - 8 - @collision.x - (mpos[0] - 8 - @collision.x) % 16
    y = mpos[1] - 100 - @collision.y - (mpos[1] - 4 - @collision.y) % 16
    trash = nil
    for stair in @mapcore.stairs
      trash = stair if stair[0] == x && stair[1] == y
    end
    if trash.nil? 
      @mapcore.stairs << [x,y] 
      @areas.bitmap.fill_rect(x,y,16,16,AWST)
    else
      @areas.bitmap.clear_rect(x,y,16,16)
      @mapcore.stairs.delete(trash)
    end
  end
  def delete_area(mpos)
    x = mpos[0]-8-@collision.x
    y = mpos[1]-100-@collision.y
    trash = []
    for area in (@active_mode == 1 ? @mapcore.water : @mapcore.ice)
      trash << area if x >= area.x && x < (area.x + area.width) && y >= area.y && y < (area.y + area.height)
    end
    trash.each {|item| @active_mode == 1 ? @mapcore.water.delete(item) : @mapcore.ice.delete(item)}
    trash.clear
    refresh_areas
  end
  def set_pixel(x,y,flag)
    @mapcore.table[x,y] = flag
    @collision.bitmap.set_pixel(x,y,COLORS[flag])
    refresh_preview
  end
  def apply_brush(flag)
    x = @brush.x-8-@collision.x
    y = @brush.y-100-@collision.y
    for point in @brush_data[@active_brush]
      @mapcore.table[x+point[0],y+point[1]] = flag
      @collision.bitmap.set_pixel(x+point[0],y+point[1],COLORS[flag])
    end
    refresh_preview
  end
  def load_brushes
    @brush_data = {}
    brush_resource = Cache.system("brushes")
    for i in 0..7
      @brush_data[i] = []
      for x in 0..31
        for y in 0..31
          @brush_data[i] << [x,y] if brush_resource.get_pixel(x+i*32,y).alpha != 0
        end
      end
    end
    brush_resource.dispose
    brush_resource = nil
  end
  def create_editor_windows
    @map_window = Arc_Window.new(640,96,516,380)
    @brush_window = Arc_Window.new(0,96,112,380)
    @save_window = Arc_Window.new(640,4,112,88)
    @save_window.draw_text(0,4,:w,16," Physics Editor ",1,AWC)
    @save_window.hr(22)
    @save_window.draw_text(0,26,:w,16," Map ID: #{@mapcore.id}" ,1,AWC)
    @confirm = Arc_Button.new(548,54,64,16," Save ",1,true)
    @cancel = Arc_Button.new(548,72,64,16," Cancel ",1,true)
    @confirm.z = 50
    @cancel.z = 50
    @save_window.ssx(524,20)
    @logo.ssx(260,20)
    @active_brush = 0
    @active_mode = 0
    @area_mode = 0
    @area_vert1 = [0,0]
    @area_vert2 = [0,0]
    @tilegrid = false
    @brush_window.bitmap.font.color = AWF
    @brush_window.bitmap.draw_text(4,80,104,16," Tile Grid",1)
    @brush_window.bitmap.draw_text(4,98,104,16," Stairs ",1)
    @brush_window.draw_32rect(4,4,@active_mode == 0)
    @brush_window.draw_32rect(40,4,@active_mode == 1)
    @brush_window.draw_32rect(76,4,@active_mode == 2)
    @brush_window.draw_icon(8,8,28,@active_mode == 0)
    @brush_window.draw_icon(44,8,107,@active_mode == 1)
    @brush_window.draw_icon(80,8,105,@active_mode == 2)
    @brush_window.draw_brush(4,40,@active_brush)
    @brush_window.draw_text(40,48,68,16," Brush",0,@active_mode == 0 ? AWA : AWF)
    @brush_window.bitmap.font.color = AWC
    @brush_window.bitmap.draw_text(4,260,104,16," Zoom ",1)
    @map_window.ssx(4,20)
    @brush_window.ssx(524,20)
    @map_window.z = 20
    @brush_window.z = 30
    22.times do
      Graphics.update
      @map_window.opacity += 13
      @map_window.update
      @brush_window.opacity += 13
      @brush_window.update
      @logo.update_slide
      @save_window.opacity += 13
      @save_window.update
    end
    @map_viewport = Viewport.new(8,100,508,372)
    @map_viewport.z = 40
    @tilemap = Tilemap.new(@map_viewport)
    @tilemap.map_data = @map.data
    $data_tilesets = load_data("Data/Tilesets.rvdata2")
    @tileset = $data_tilesets[@map.tileset_id]
    @tileset.tileset_names.each_with_index {|name,i| @tilemap.bitmaps[i] = Cache.tileset(name) }
    @tilemap.flags = @tileset.flags
    @map_viewport.update
    @tilemap.update
    @mapcore.load_sprites_fe(@map_viewport,20,50)
    @zoom_rect = Arc_ZR.new(@map_viewport)
    @brush = Sprite.new
    @brush.z = 300
    @brush.bitmap = Bitmap.new(32,32)
    @brush.bitmap.blt(0,0,Cache.system("brushes"),Rect.new(@active_brush*32,0,32,32))
    @brush.opacity = 150
    @preview_image = Sprite.new
    @preview_image.bitmap = Bitmap.new(32,32)
    @preview_image.z = 200
    @preview_image.x = 532
    @preview_image.y = 372
    @preview_image.zoom_x = 3
    @preview_image.zoom_y = 3
    @preview_image.bitmap.blt(0,0, Graphics.snap_to_bitmap,Rect.new(@zoom_rect.x+9,@zoom_rect.y+101,32,32)) if Enable_Zoom
  end
  def dispose_editor_windows
    @collision.bitmap.dispose
    @collision.dispose
    @collision = nil
    @zoom_rect.bitmap.dispose
    @zoom_rect.dispose
    @zoom_rect = nil
    @areas.bitmap.dispose
    @areas.dispose
    @areas = nil
    @brush.bitmap.dispose
    @brush.dispose
    @brush = nil
    @tileset = nil
    @preview_image.bitmap.dispose
    @preview_image.dispose
    @preview_image = nil
    @confirm.dispose
    @cancel.dispose
    @confirm = nil
    @cancel = nil
    @tilemap.dispose
    @tilemap = nil
    @map_viewport.dispose
    @map_viewport = nil
    @map_window.ssx(640,20)
    @brush_window.ssx(0,20)
    @logo.ssx(320,20)
    @save_window.ssx(640,20)
    20.times do
      Graphics.update
      @map_window.opacity -= 13
      @map_window.update
      @brush_window.opacity -= 13
      @brush_window.update
      @logo.update_slide
      @save_window.opacity -= 13
      @save_window.update_slide
    end   
    @map_window.dispose
    @map_window = nil
    @brush_window.dispose
    @brush_window = nil
    @save_window.dispose
    @save_window = nil
  end
end

$arc_engine = Arc_Interface.new
$arc_engine.load
$arc_engine.call_menu if $TEST && !Arc_Core::Disable_Editor

#-------------------------------------------------------------------------------
# * Arc Camera
#-------------------------------------------------------------------------------

class Arc_Camera
  include Arc_Core
  def initialize
    @object = nil
  end
  def refresh_limits
    @map_lx = $game_map.core.table.xsize/32.0 - Screen_TX
    @map_ly = $game_map.y_limit/32.0 - Screen_TY
  end
  def focus(*args)
    @object = (args.size == 1 ? args[0] : Arc_VirtualObject.new(args[0],args[1]))
    $game_map.set_display_pos(@object.ax/32.0 - Map_CX,@object.ay/32.0 - Map_CY)
  end
  def update
    cx = @object.ax/32.0 - Map_CX
    if (cx - $game_map.display_x).abs > Max_SX
      $game_map.display_x = [0, [cx + (cx > $game_map.display_x ? -Max_SX : Max_SX),@map_lx].min].max 
      $game_map.parallax_x = $game_map.display_x
    end
    cy = @object.ay/32.0 - Map_CY
    if (cy - $game_map.display_y).abs > Max_SY
      $game_map.display_y = [0, [cy + (cy > $game_map.display_y ? -Max_SY : Max_SY),@map_ly].min].max
      $game_map.parallax_y = $game_map.display_y
    end
  end
  def on_screen?(object)
    return false if (@object.ax-object.ax).abs > On_ScreenX
    return false if (@object.ay-object.ay).abs > On_ScreenY
    return true
  end
end

#-------------------------------------------------------------------------------
# * Arc VirtualObject
#-------------------------------------------------------------------------------

class Arc_VirtualObject
  attr_accessor :ax
  attr_accessor :ay
  def initialize(ax,ay)
    @ax = ax
    @ay = ay
  end
end

#-------------------------------------------------------------------------------
# * Game Map
#-------------------------------------------------------------------------------

class Game_Map
  include Arc_Core
  attr_reader :arc
  attr_reader :y_limit
  attr_accessor :core
  attr_accessor :camera
  attr_accessor :display_x
  attr_accessor :display_y
  attr_accessor :parallax_x
  attr_accessor :parallax_y
  alias arc_initialize initialize
  alias arc_setup setup
  alias arc_update update
  def initialize
    @arc = false
    @core = nil
    @y_limit = 16000
    @camera = Arc_Camera.new
    arc_initialize
  end
  def setup(mid)
    @arc = false
    $map_data.each_value {|core| core.unload}
    if $map_data.keys.include?(mid)
      @arc = true
      @core = $map_data[mid]
      @core.load
      @y_limit = @core.height
    end
    arc_setup(mid)
    if @arc
      @camera.refresh_limits 
      @camera.focus($game_player)
    end
  end
  def update(main=false)
    arc_update(main)
    @camera.update if @arc
  end
  def air?(tx,ty)
    return false if $game_map.invalid?(tx,ty)
    @core.table[tx,ty] < 8
  end
  def solid?(tx,ty)
    return true if $game_map.invalid?(tx,ty)
    @core.table[tx,ty] > 7
  end
  def can_kick?(tx,ty)
    return false if $game_map.invalid?(tx,ty)
    @core.table[tx,ty] > 7
  end
  def surface?(tx,ty)
    return true if $game_map.invalid?(tx,ty)
    @core.table[tx,ty] > 8 || @core.table[tx,ty] == 7
  end
  def passable_surface?(tx,ty)
    return false if $game_map.invalid?(tx,ty)
    @core.table[tx,ty] == 7
  end
  def stair?(tx,ty)
    @core.table[tx,ty] == 1
  end
  def surface(tx,ty)
    @core.table[tx,ty]
  end
  def surface_y(cx,cy,tx)
    return nil if $game_map.invalid?(tx,cy)
    @core.surface[@core.table[cx,cy]][tx]
  end
  def water?(tx,ty)
    @core.water.each {|a| return true  if tx > a[0] && tx < a[2] && ty > a[1] && ty < a[3]}
    false
  end
  def ice?(tx,ty)
    @core.ice.each {|a| return true if tx > a[0] && tx < a[2] && ty > a[1] && ty < a[3]}
    false
  end
  def invalid?(tx,ty)
    @core.table[tx,ty] == nil
  end
end

#-------------------------------------------------------------------------------
# * Game Interpreter
#-------------------------------------------------------------------------------

class Game_Interpreter
  def self_event
    $game_map.events[@event_id]
  end
end

#-------------------------------------------------------------------------------
# * Game CharacterBase
#-------------------------------------------------------------------------------

class Game_CharacterBase
  include Arc_Core
  attr_reader :ax
  attr_reader :ay
  attr_accessor :vx
  attr_accessor :vy
  attr_accessor :pattern
  attr_reader :sw1
  attr_reader :sw2
  attr_reader :ch
  alias arc_gcbi initialize
  alias arc_gcsx screen_x
  alias arc_gcsy screen_y
  alias arc_ubd update_bush_depth
  def initialize
    @ax = 0.0
    @ay = 0.0
    reset_vx
    reset_vy
    @wait_c = 0
    set_width(Default_Width)
    set_height(Default_Height)
    set_weight(Default_Weight)
    @tphy = false
    @agrvt = true
    @atimer = 0
    arc_gcbi
  end
  def reset_vx
    @vx = 0.0
    @tx = nil
  end
  def reset_vy
    @vy = 0.0
    @ty = nil
  end
  def screen_x
    @tphy ? arc_sx : arc_gcsx
  end
  def screen_y
    @tphy ? arc_sy : arc_gcsy
  end
  def ladder?
    @tphy ? $game_map.ladder?(@ax/32,@ay/32) : $game_map.ladder?(@x,@y)
  end
  def bush?
    @tphy ? $game_map.bush?(@ax/32,@ay/32) : $game_map.bush?(@x,@y)
  end
  def update_bush_depth
    @tphy ? @bush_depth = 0 : arc_ubd
  end
  def terrain_tag
    @tphy ? $game_map.terrain_tag(@ax/32,@ay/32) : $game_map.terrain_tag(@x,@y)
  end
  def region_id
    @tphy ? $game_map.region_id(@ax/32,@ay/32) : $game_map.region_id(@x,@y)
  end
  def moveto(x,y)
    @x = x % $game_map.width
    @y = y % $game_map.height
    @real_x = @x
    @real_y = @y
    @ax = @x*32+X_Axis
    @ay = @y*32+Y_Axis
    reset_vx
    reset_vy
    @prelock_direction = 0
    straighten
    refresh_tphy
    reset_ss
  end
  def reset_ss
  end
  def refresh_tphy
    @tphy = $game_map.arc 
  end
  def arc_sx
    @ax-$game_map.display_x*32
  end
  def arc_sy
    @ay-$game_map.display_y*32
  end
  def set_height(gh)
    @ch = gh
    @h = @ch - 1
  end
  def set_width(gw)
    @w = gw
    @sw1 = @w/2
    @sw2 = @sw1 - 1
  end
  def set_weight(wg)
    @wg = wg
    @res_coef = @wg*Meter_Size
  end
  def arc_update
    @wait_c -= 1 if @wait_c > 0
    if @agrvt
      @vy += Gravity 
      @vy -= Air_Resistance*@vy*@vy/(@wg*Meter_Size) if @vy > Insignificant
    end
    if @tx != nil
      @tx > 0 ? @tx -= 1 : reset_vx
    end
    if @ty != nil
      @ty > 0 ? @ty -= 1 : reset_vy
    end
    arc_move
    if @vx.abs > Insignificant
      et = event_below_type
      if (surface_below? || et == 0x01)
        refresh_animation 
      elsif et == 0x02
        @pattern = 1
      else
        @pattern = 0
      end
    else
      @pattern = 1
      @atimer = 13
    end
  end
  def refresh_animation
    if @atimer > 15 - @vx.abs*2
      @atimer = 0
      @pattern = (@pattern + 1) % 4
    end
    @atimer += 1
  end
  def enter_water
    @water = true
    RPG::SE.new("Water1",80).play
  end
  def leave_water
    @water = false
  end
  def apply_xforce(fx)
    @vx += fx.to_f/@wg
  end
  def apply_yforce(fy)
    @vy += fy.to_f/@wg
  end
  def move_x(vx,tx=nil)
    @vx = vx
    @tx = tx
  end
  def move_y(vy,ty=nil)
    @vy = vy
    @ty = ty
  end
  def move_dx(dx,tx)
    @vx = dx.to_f/tx
    @tx = tx
  end
  def move_dy(dy,ty)
    @vy = dy.to_f/ty
    @ty = ty
  end
  def push(pusher)
    move_x(@move_speed*(@ax <=> pusher.ax))
    set_direction(@vx > 0 ? 6 : 4)
    move_y(@move_speed*(@ay <=> pusher.ay)) if !@agrvt
  end
  def stop
    reset_vx
    reset_vy
  end
  def surface_below?
    for h in 1..Surface_T
      return true if $game_map.surface?(@ax-@sw1,@ay+h) || $game_map.surface?(@ax+@sw2,@ay+h)
    end
    false
  end
  def event_below?
    for event in $game_map.events.values
      if (@ax-event.ax).abs < (@sw1+event.sw1) && (@ay+Surface_T-event.ay).abs < (event.ay > @ay ? event.ch : @ch)
        next if event.through
        return true if event.priority_type == 1
      end
    end
    false
  end
  def event_below_type
    for event in $game_map.events.values
      if (@ax-event.ax).abs < (@sw1+event.sw1) && (@ay+Surface_T-event.ay).abs < (event.ay > @ay ? event.ch : @ch)
        next if event.through 
        return 0x02 if event.sticky && event.vx == @vx
        return 0x01 if event.priority_type == 1
      end
    end
    0x00
  end
  def relative_stop?
    (@vx == 0.0 && @vy == 0.0)
  end
  def enough_speed?
    (@vx.abs > Insignificant || @vy.abs > Insignificant)
  end
  def arc_move
    dx = @vx <=> 0
    dy = @vy <=> 0
    @vy.abs.to_i.times do
      free_cll?(@ax,@ay+dy) ? @ay += dy : reset_vy
    end
    @vx.abs.to_i.times do
      free_cll?(@ax+dx,@ay) ? @ax += dx : reset_vx
    end
  end
  def free_cll?(tx,ty)
    unless @vy < 0
      return false if $game_map.surface?(tx-@sw1,ty)
      return false if $game_map.surface?(tx+@sw2,ty) 
    end
    for ht in 0..(@h/Height_CL)
      return false if $game_map.solid?(tx-@sw1,ty-ht*Height_CL)
      return false if $game_map.solid?(tx+@sw2,ty-ht*Height_CL)
    end
    return false if $game_map.solid?(tx-@sw1,ty-@h)
    return false if $game_map.solid?(tx+@sw2,ty-@h)
    return false if touch?(tx,ty)
    return true
  end
  def touch?(tx,ty)
    for event in $game_map.events.values
      if (tx-event.ax).abs < (@sw1+event.sw1) && (ty-event.ay).abs < (event.ay > ty ? event.ch : @ch)
        next if event == self || event.through
        event.reflex(self)
        return true if event.priority_type == 1
      end
    end
    return false
  end
  def trigger_direction(ref,obj)
    if (ref.ax-obj.ax).abs < ref.sw1 + obj.sw2
      return (ref.ay > obj.ay ? 2 : 8)
    else
      return (ref.ax > obj.ax ? 4 : 6)
    end
  end
end

#-------------------------------------------------------------------------------
# * Game Character
#-------------------------------------------------------------------------------

class Game_Character < Game_CharacterBase
  alias default_command process_move_command
  alias default_fmr force_move_route
  def force_move_route(r)
    stop if @tphy
    default_fmr(r)
  end
  def arc_update
    super
    update_routine_move if @move_route_forcing && relative_stop?
  end
  def process_move_command(command)
    @tphy ? arc_command(command) : default_command(command)
  end
  def arc_command(command)
    params = command.parameters
    case command.code
    when ROUTE_END
      process_route_end
    when ROUTE_MOVE_DOWN
      move_y(@move_speed,32/@move_speed)
    when ROUTE_MOVE_LEFT
      move_x(-@move_speed,32/@move_speed)
      set_direction(4)
    when ROUTE_MOVE_RIGHT
      move_x(@move_speed,32/@move_speed)
      set_direction(6)
    when ROUTE_MOVE_UP
      move_y(-@move_speed,32/@move_speed)
    when ROUTE_MOVE_LOWER_L
      move_y(@move_speed,32/@move_speed)
      move_x(-@move_speed,32/@move_speed)
      set_direction(4)
    when ROUTE_MOVE_LOWER_R
      move_y(@move_speed,32/@move_speed)
      move_x(@move_speed,32/@move_speed)
      set_direction(6)
    when ROUTE_MOVE_UPPER_L
      move_y(-@move_speed,32/@move_speed)
      move_x(-@move_speed,32/@move_speed)
      set_direction(4)
    when ROUTE_MOVE_UPPER_R
      move_y(-@move_speed,32/@move_speed)
      move_x(@move_speed,32/@move_speed)
      set_direction(6)
    when ROUTE_MOVE_RANDOM
      arc_rand_move
    when ROUTE_MOVE_TOWARD
      arc_follow($game_player)
    when ROUTE_MOVE_AWAY 
      arc_escape($game_player)
    when ROUTE_MOVE_FORWARD
      move_x(@move_speed*(@direction == 4 ? -1 : 1),32/@move_speed)
    when ROUTE_MOVE_BACKWARD
      move_x(@move_speed*(@direction == 6 ? -1 : 1),32/@move_speed)
    when ROUTE_JUMP
      apply_xforce(params[0]*32)
      apply_yforce(params[1]*32)
    when ROUTE_WAIT
      @wait_count = params[0] - 1
      @wait_c = params[0] - 1
    when ROUTE_TURN_DOWN;         set_direction(2)
    when ROUTE_TURN_LEFT;         set_direction(4)
    when ROUTE_TURN_RIGHT;        set_direction(6)
    when ROUTE_TURN_UP;           set_direction(8)
    when ROUTE_TURN_90D_R;        turn_right_90
    when ROUTE_TURN_90D_L;        turn_left_90
    when ROUTE_TURN_180D;         turn_180
    when ROUTE_TURN_90D_R_L;      turn_right_or_left_90
    when ROUTE_TURN_RANDOM
      set_direction(rand(2) == 0 ? 4 : 6)
    when ROUTE_TURN_TOWARD
      arc_focus($game_player)
    when ROUTE_TURN_AWAY
      arc_away($game_player)
    when ROUTE_SWITCH_ON;         $game_switches[params[0]] = true
    when ROUTE_SWITCH_OFF;        $game_switches[params[0]] = false
    when ROUTE_CHANGE_SPEED;      @move_speed = params[0]
    when ROUTE_CHANGE_FREQ;       @move_frequency = params[0]
    when ROUTE_WALK_ANIME_ON;     @walk_anime = true
    when ROUTE_WALK_ANIME_OFF;    @walk_anime = false
    when ROUTE_STEP_ANIME_ON;     @step_anime = true
    when ROUTE_STEP_ANIME_OFF;    @step_anime = false
    when ROUTE_DIR_FIX_ON;        @direction_fix = true
    when ROUTE_DIR_FIX_OFF;       @direction_fix = false
    when ROUTE_THROUGH_ON;        @through = true
    when ROUTE_THROUGH_OFF;       @through = false
    when ROUTE_TRANSPARENT_ON;    @transparent = true
    when ROUTE_TRANSPARENT_OFF;   @transparent = false
    when ROUTE_CHANGE_GRAPHIC;    set_graphic(params[0], params[1])
    when ROUTE_CHANGE_OPACITY;    @opacity = params[0]
    when ROUTE_CHANGE_BLENDING;   @blend_type = params[0]
    when ROUTE_PLAY_SE;           params[0].play
    when ROUTE_SCRIPT;            eval(params[0])
    end
  end
  def arc_rand_move
    case rand(8)
    when 0..3
      set_direction(6)
      move_x(@move_speed,(rand(6)+1)*30)
    when 4..6
      set_direction(4)
      move_x(-@move_speed,(rand(6)+1)*30)
    when 7
      @wait_c = (rand(6)+1)*30
    end
  end
  def arc_follow(object)
    move_x(@move_speed*(object.ax <=> @ax),5) if (@ax - object.ax).abs > AI_Approach
    set_direction(@vx > 0 ? 6 : 4)
    move_y(@move_speed*(object.ay <=> @ay),5) if !@agrvt && (@ay - object.ay).abs > AI_Approach
  end
  def arc_escape(object)
    move_x(@move_speed*(@ax <=> object.ax),5) if (@ax - object.ax).abs > AI_Approach
    set_direction(@vx > 0 ? 6 : 4)
    move_y(@move_speed*(@ay <=> object.ay),5) if !@agrvt && (@ay - object.ay).abs > AI_Approach
  end
  def arc_focus(object)
    set_direction((object.ax <=> @ax) == -1 ? 4 : 6)
  end
  def arc_away(object)
    set_direction((object.ax <=> @ax) == -1 ? 6 : 4)
  end
end

#-------------------------------------------------------------------------------
# * Game Player
#-------------------------------------------------------------------------------

class Game_Player < Game_Character
  attr_accessor :deny_resistance
  attr_reader :groundpound
  alias arc_gpi initialize
  alias arc_gpu update
  def initialize
    reset_ss
    arc_gpi
  end
  def set_weight(wg)
    super(wg)
    @key_acc = Key_Force/@wg
  end
  def reset_vx
    super
    @wallkick = false
  end
  def reset_vy
    super
    @wallkick = false
  end
  def update 
    @tphy ? arc_update : arc_gpu
  end
  def reset_ss
    @wk_pos = [0,0]
    @wallkick = false
    @deny_resistance = false
    @groundpound = false
    @grab_stair = false
  end
  def reset_vy
    super
    @wk_pos = [0,0]
    if @groundpound
      @groundpound = false
      Arc_Sound.groundpound
    end
  end
  def arc_update
    try_event if Input.trigger?(:C)
    @wait_c -= 1 if @wait_c > 0
    unless @grab_stair
      if Input.trigger?(:DOWN) 
        if !jump_enabled? && !@groundpound
          stop
          apply_yforce(-Jump_Impulse)
          @groundpound = true
        end
      end
      @vy += Gravity 
      @vy -= Air_Resistance*@vy*@vy/(@wg*Meter_Size) if @vy > Insignificant
    end
    if @tx != nil
      @tx > 0 ? @tx -= 1 : reset_vx
    end
    if @ty != nil
      @ty > 0 ? @ty -= 1 : reset_vy
    end
    if @move_route_forcing
      arc_move
      check_move_route
    else
      update_arcinput
      arc_move
      check_ungrab
    end
    kill if @ay > $game_map.y_limit
    if @vx.abs > Insignificant
      et = event_below_type
      if (@grab_stair || surface_below? || et == 0x01)
        refresh_animation
      elsif et == 0x02
        @pattern = 1
      else
        @pattern = 0
      end
    elsif @grab_stair && @vy.abs > Insignificant
      stair_animation
    else
      @pattern = 1 unless @move_route_forcing
      @atimer = 13
    end
  end
   def stair_animation
    if @atimer > 11
      @atimer = 0
      @pattern = (@pattern + 1) % 4
    end
    @atimer += 1
  end
  def kill
    reset_vx
    $game_switches[Death_Zone_Switch] = true
  end
  def try_event
    return if $game_map.interpreter.running? || $game_message.busy? || $game_message.visible
    case @direction
    when 4
      for event in $game_map.events.values
        event.try_trigger if (@ax-event.ax).abs < (@sw1+event.sw1) && (@ay-event.ay).abs < (event.ay > @ay ? event.ch : @ch)
      end
      return if $game_map.setup_starting_event
      for event in $game_map.events.values
        event.try_trigger if (@ax-Trigger_X-event.ax).abs < (@sw1+event.sw1) && (@ay-event.ay).abs < (event.ay > @ay ? event.ch : @ch) + Trigger_Y
      end
    when 6
      for event in $game_map.events.values
        event.try_trigger if (@ax-event.ax).abs < (@sw1+event.sw1) && (@ay-event.ay).abs < (event.ay > @ay ? event.ch : @ch)
      end
      return if $game_map.setup_starting_event
      for event in $game_map.events.values
        event.try_trigger if (@ax+Trigger_X-event.ax).abs < (@sw1+event.sw1) && (@ay-event.ay).abs < (event.ay > @ay ? event.ch : @ch) + Trigger_Y
      end
    else
      for event in $game_map.events.values
        event.try_trigger if (@ax-event.ax).abs < (@sw1+event.sw1) && (@ay-event.ay).abs < (event.ay > @ay ? event.ch : @ch)
      end
    end
  end
  def check_ungrab
    unless $game_map.stair?(@ax,@ay-Stair_OY)
      @grab_stair = false 
      set_direction(@vx > 0 ? 6 : 4) if @direction == 8
    end
  end
  def try_grab
    if $game_map.stair?(@ax,@ay-Stair_OY)
      @grab_stair = true
      set_direction(8)
    end
  end
  def check_move_route
    return if !relative_stop? || @wait_c > 0
    update_routine_move
  end
  def update_arcinput
    return if $game_map.interpreter.running? || $game_message.busy? || $game_message.visible
    try_grab if Input.trigger?(:UP)
    if @grab_stair
      case Input.dir8
      when 1
        move_x(-Stair_Speed)
        move_y(Stair_Speed)
      when 2
        reset_vx
        move_y(Stair_Speed)
      when 3
        move_x(Stair_Speed)
        move_y(Stair_Speed)
      when 4
        move_x(-Stair_Speed)
        reset_vy
      when 6
        move_x(Stair_Speed)
        reset_vy
      when 7
        move_x(-Stair_Speed)
        move_y(-Stair_Speed)
      when 8
        reset_vx
        move_y(-Stair_Speed)
      when 9
        move_x(Stair_Speed)
        move_y(-Stair_Speed)
      else
        reset_vx
        reset_vy
      end
      if Input.trigger?(:X)
        apply_yforce(Jump_Impulse)
        Arc_Sound.jump
        @grab_stair = false
        set_direction(@vx > 0 ? 6 : 4)
      end
    else
      case Input.dir4
      when 4
        @vx -= @key_acc
        set_direction(4)
        @deny_resistance = false
        r = (Input.press?(:SHIFT) ? Running_Resistance : Body_Resistance)
      when 6
        @vx += @key_acc
        set_direction(6)
        @deny_resistance = false
        r = (Input.press?(:SHIFT) ? Running_Resistance : Body_Resistance)
      else
        r = (@wallkick ? Body_Resistance : Stop_Resistance)
      end
      if Input.trigger?(:X)
        if jump_enabled?
          apply_yforce(Jump_Impulse + Jump_RBonus*@vx.abs)
          Arc_Sound.jump
        elsif wkick_left?
          stop
          @wk_pos = [@ax,@ay]
          @wallkick = true
          @deny_resistance = true
          apply_xforce(WKick_XImpulse)
          apply_yforce(WKick_YImpulse)
          Arc_Sound.jump
        elsif wkick_right?
          stop
          @wk_pos = [@ax,@ay]
          @wallkick = true
          @deny_resistance = true
          apply_xforce(-WKick_XImpulse)
          apply_yforce(WKick_YImpulse)
          Arc_Sound.jump
        end
      end
      if @deny_resistance
        @deny_resistance = false
      else
        if @vx.abs > Insignificant
          rb = r*@vx*@vx/@res_coef
          @vx += (@vx > 0 ? -rb : rb)
        end
      end
    end
  end
  def jump_enabled?
    return true if surface_below? || event_below?
    false
  end
  def pass_surface?
    return false if event_below?
    $game_map.passable_surface?(@ax-@sw1,@ay+1) && $game_map.passable_surface?(@ax+@sw2,@ay+1)
  end
  def deny_wallkick?
    (@wk_pos[0] - @ax).abs < WKick_XRadius && (@wk_pos[1] - @ay).abs < WKick_YRadius
  end
  def wkick_right?
    return false if @direction != 6 || deny_wallkick?
    for d in 1..WKick_T
      return true if $game_map.can_kick?(@ax+@sw2+d,@ay-WKick_OY)
    end
    false
  end
  def wkick_left?
    return false if @direction != 4 || deny_wallkick?
    for d in 1..WKick_T
      return true if $game_map.can_kick?(@ax-@sw1-d,@ay-WKick_OY)
    end
    false
  end
  def refresh_tphy
    @tphy = $game_map.arc 
    if @tphy
      @followers.visible = false
    else
      @followers.visible = $data_system.opt_followers
    end
  end
  def touch?(tx,ty)
    rst = false
    for event in $game_map.events.values
      if (tx-event.ax).abs < (@sw1+event.sw1) && (ty-event.ay).abs < (event.ay > ty ? event.ch : @ch)
        next if event.through
        event.reflex(self)
        rst = true if event.priority_type == 1
      end
    end
    rst
  end
  def reflex(object)
    if object.sticky && object.ay > @ay
      @ay -= 1
    end
  end
end

#-------------------------------------------------------------------------------
# * Game Event
#-------------------------------------------------------------------------------

class Game_Event < Game_Character
  attr_accessor :direction
  attr_reader :last_trigger_direction
  attr_reader :last_trigger_type
  attr_reader :sticky
  attr_reader :pushable
  attr_reader :enemy
  attr_reader :block_event
  alias arc_gei initialize
  alias arc_geu update
  alias arc_sps setup_page_settings
  alias arc_cps clear_page_settings
  def initialize(m,e)
    arc_clear
    arc_gei(m,e)
  end
  def lock
    unless @locked
      @prelock_direction = @direction
      arc_focus($game_player)
      @locked = true
    end
  end
  def update 
    @tphy ? arc_update : arc_geu
  end
  def arc_move
    $game_player.vy += @move_speed if @sticky && touch_player?(@ax,@ay-1) && @vy > 0
    apply_rforce if @apply_friction
    super
    update_ai if $game_map.camera.on_screen?(self) && relative_stop? && @wait_c <= 0
  end
  def arc_update
    super
    return unless @interpreter
    @interpreter.setup(@list,@event.id) unless @interpreter.running?
    @interpreter.update
  end
  def update_ai
    return if $game_map.interpreter.running? || $game_message.busy? || $game_message.visible
    case @move_type
    when 1
      arc_rand_move
    when 2
      arc_follow($game_player)
    when 3
      update_routine_move
    when 4
      @last_dir = @last_dir*-1
      move_x(@move_speed*@last_dir)
      set_direction(@vx > 0 ? 6 : 4)
    end
  end
  def apply_rforce
    if @vx.abs > Insignificant
      rb = Body_Resistance*@vx*@vx/@res_coef
      @vx += (@vx > 0 ? -rb : rb)
    end
  end
  def setup_page_settings
    arc_sps
    arc_clear
    arc_setup
  end
  def clear_page_settings
    arc_cps
    arc_clear
  end
  def arc_setup
    return if @list.nil?
    for value in 0...@list.size
      next if @list[value].code != 108 && @list[value].code != 408
      @sticky = true if @list[value].parameters[0] == "[sticky]"
      @pushable = true if @list[value].parameters[0] == "[pushable]"
      @tphy = false if @list[value].parameters[0] == "[deny_physics]"
      @agrvt = false if @list[value].parameters[0] == "[deny_gravity]"
      @apply_friction = true if @list[value].parameters[0] == "[apply_friction]"
      @move_type = 4 if @list[value].parameters[0] == "[turtle]"
      @block_event = true if @list[value].parameters[0] == "[block_event]"
      @groundpound = true if @list[value].parameters[0] == "[groundpound]"
      @stop_player = true if @list[value].parameters[0] == "[stop_player]"
      @deny_player = true if @list[value].parameters[0] == "[deny_player]"
      @deny_triggers << 2 if @list[value].parameters[0] == "[deny_up]"
      @deny_triggers << 4 if @list[value].parameters[0] == "[deny_left]"
      @deny_triggers << 6 if @list[value].parameters[0] == "[deny_right]"
      @deny_triggers << 8 if @list[value].parameters[0] == "[deny_down]"
      if @list[value].parameters[0].include?("[weight ")
        @list[value].parameters[0].scan(/\[weight ([0.0-9.9]+)\]/)
        set_weight($1.to_i)
      end
      if @list[value].parameters[0].include?("[width ")
        @list[value].parameters[0].scan(/\[width ([0.0-9.9]+)\]/)
        set_width($1.to_i)
      end
      if @list[value].parameters[0].include?("[height ")
        @list[value].parameters[0].scan(/\[height ([0.0-9.9]+)\]/)
        set_height($1.to_i)
      end
      if @list[value].parameters[0].include?("[item_trigger ")
        @list[value].parameters[0].scan(/\[item_trigger ([0.0-9.9]+)\]/)
        @projectile_triggers << $1.to_i
      end
      if @list[value].parameters[0].include?("[object_trigger ")
        @list[value].parameters[0].scan(/\[object_trigger ([0.0-9.9]+)\]/)
        @enemy_triggers << $1.to_i
      end
      if @list[value].parameters[0].include?("[event_trigger ")
        @list[value].parameters[0].scan(/\[event_trigger ([0.0-9.9]+)\]/)
        @event_triggers << $1.to_i
      end
    end
  end  
  def arc_clear
    refresh_tphy
    @last_trigger_direction = 2
    @last_dir = 1
    @agrvt = true
    @enemy = nil
    @sticky = false
    @pushable = false
    @groundpound = false
    @stop_player = false
    @block_event = false
    @deny_player = false
    @apply_friction = false
    @deny_triggers = []
    @projectile_triggers = []
    @enemy_triggers = []
    @event_triggers = []
  end
  def touch?(tx,ty)
    for event in $game_map.events.values
      if (tx-event.ax).abs < (@sw1+event.sw1) && (ty-event.ay).abs < (event.ay > ty ? event.ch : @ch)
        next if event == self || event.through
        event.reflex(self)
        return true if event.priority_type == 1 || event.block_event
      end
    end
    if (tx-$game_player.ax).abs < (@sw1+$game_player.sw1) && (ty-$game_player.ay).abs < ($game_player.ay > ty ? $game_player.ch : @ch)
      $game_player.reflex(self)
      try_start if @trigger == 2
      return true unless (@sticky && (@ay-@h) > $game_player.ay)
    end
    return false
  end
  def touch_player?(tx,ty)
    return (tx-$game_player.ax).abs < (@sw1+$game_player.sw1) && (ty-$game_player.ay).abs < ($game_player.ay > ty ? $game_player.ch : @ch)
  end
  def reflex(object)
    if object == $game_player
      if @sticky && $game_player.vx.abs <= @vx.abs && $game_player.ay < (@ay-@h) && (@ax-$game_player.ax).abs < (@sw1+$game_player.sw1)
        $game_player.vx = @vx
        $game_player.deny_resistance = true
      elsif @pushable
        try_push
      else
        try_start
      end
    elsif @event_triggers.include?(object.id)
      try_e_start(object)
    end
  end
  def try_push
    return if @deny_triggers.include?(trigger_direction(self,$game_player))
    push($game_player)
  end
  def try_e_start(trigger)
    return if @deny_triggers.include?(trigger_direction(self,trigger))
    @last_trigger_direction = trigger_direction(self,trigger)
    @last_trigger_type = :event
    stop
    start
  end
  def try_start
    return if @deny_player
    return unless (@trigger == 1 || @trigger == 2)
    return if @deny_triggers.include?(trigger_direction(self,$game_player))
    return if @groundpound && !$game_player.groundpound
    return if @stop_player && ($game_map.interpreter.running? || $game_message.busy? || $game_message.visible)
    $game_player.stop if @stop_player
    @last_trigger_direction = trigger_direction(self,$game_player)
    @last_trigger_type = ($game_player.groundpound ? :groundpound : :touch)
    stop
    start
  end
  def try_trigger
    return if @deny_player
    return if @deny_triggers.include?(trigger_direction(self,$game_player))
    return if @groundpound
    $game_player.stop
    @last_trigger_direction = trigger_direction(self,$game_player)
    @last_trigger_type = :action
    stop
    start
  end
end

#-------------------------------------------------------------------------------
# * Sprite Character
#-------------------------------------------------------------------------------

class Sprite_Character < Sprite_Base
  def set_tile_bitmap
    sx = (@tile_id / 128 % 2 * 8 + @tile_id % 8) * 32;
    sy = @tile_id % 256 / 8 % 16 * 32;
    self.bitmap = tileset_bitmap(@tile_id)
    self.src_rect.set(sx, sy, 32, 32)
    self.ox = 16
    self.oy = 31
  end
  def set_character_bitmap
    self.bitmap = Cache.character(@character_name)
    sign = @character_name[/^[\!\$]./]
    if sign && sign.include?('$')
      @cw = bitmap.width / 3
      @ch = bitmap.height / 4
    else
      @cw = bitmap.width / 12
      @ch = bitmap.height / 8
    end
    self.ox = @cw / 2
    self.oy = @ch -1
  end
end

#-------------------------------------------------------------------------------
# * End of Arc Engine (by Khas Arcthunder)
#-------------------------------------------------------------------------------