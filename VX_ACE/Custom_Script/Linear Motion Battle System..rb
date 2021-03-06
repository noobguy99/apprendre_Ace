#==============================================================================
# +++ MOG - LMBS (Linear Motion Battle System) (V0.8 Beta) +++
#==============================================================================
# *(Full Motion Battle System (FMBS) / Tales of Phantasia Battle System)*
#==============================================================================
# By Moghunter
# https://atelierrgss.wordpress.com/
#==============================================================================
# Sistema de batalha linear com movimentação livre onde a ação acontece em
# tempo real.
#==============================================================================

#==============================================================================
# ■ NOTA
#==============================================================================
#
# Este script está em fase de teste (Versão Beta), portanto algumas funções
# ainda não foram implementadas,tais como.
# - Função da condição confusão. (Aliados atacarem entre si)
#
#==============================================================================

#==============================================================================
# ■ HISTÓRICO
#==============================================================================
# v0.8 - Implementação básica do sistema de turnos. (Páginas de Eventos)
#      - Melhoria no sistema de dano.
#      - Melhoria no tempo das poses de vitória.
#      - Melhoria no sistema de dispose de skills.
#      - Correção nas poses dos battlers durante a transição de batalha.
# v0.7 - Melhoria e correção de bugs no sistema de Guard.
#      - Correção de não separar as skills por tipo no modo padrão.
#      - Correção de bugs no sistema de janelas de equipar skills.
# v0.6 - Correção do glitch do sprite do cursor aparecer no canto da tela.
# v0.5 - Versão funcional. 
# v0.1..04 - Criação básica do sistema
#==============================================================================

#==============================================================================
# ■ ARQUIVOS DE SISTEMA NECESSÁRIOS
#==============================================================================
# Serão necessários os seguintes arquivos. (GRAPHICS/SYSTEM)
#
# Battle_Cursor.png
# Battle_Cursor_Actor.png
# F_Escape_A.png
# F_Escape_B.png
# F_Iconset.png
# F_Shadow.png
#
#==============================================================================

#==============================================================================
# ■ SISTEMA DE ARQUIVOS DE IMAGES DOS BATTLERS.
#==============================================================================
# 1 - A primeira tarefa é escolher através do banco de dados a imagem padrão do 
# battler. É nesta imagem que o cálculo do tamanho do battler é baseado.
# 2 - Após isso você deverá nomear as imagens das poses da sequinte forma.
#
# BATTLER_NAME[POSE_TYPE][F][S][H].png
#
# BATTLER_NAME = Nome do Battler
# POSE = Tipo de pose.
# F = Número de frames da pose.
# S = Velocidade de animação da pose. (Opcional)
# H = Definição da altura da imagem, para fazer ajustes. (Opcional)
#
# Na prática a nomeação é feita da seguinte forma.
#
# Leon.png
# Leon[Cast][F1].png
# Leon[Damage][F1].png
# Leon[Dash][F4][S6].png
# Leon[Dead][F1][H10].png
# Leon[Fall][F1].png
# Leon[Guard][F1].png
# Leon[Idle][F4][S12].png
# Leon[Jump][F1].png
# Leon[Victory][F4][12].png
# Leon[Walk][F4][S8].png
# Leon[Skill_1][F3][S6].png
# Leon[Item_1][F1].png
#
# 3 - Abaixo está a lista completa de poses que podem ser usadas.
#     (Não é obrigatório ter todas as poses.)
#
#   [Cast] [Damage] [Dash] [Dead] [Fall] [Guard] [Idle] [Jump] [Victory]
#   [Walk] [Skill_X] [Item_X]
#
# No caso das habilidades ou itens [Skill_X] [Item_X], o X significa a ID
# da habilidade ou item, no entanto é possível usar a mesma pose em habilidades
# diferentes, evitando de criar uma pose para cada habilidade.
# A função de escolher a ID da pose é feita através do banco de dados na caixa
# de notas. (Use a Tag abaixo se deseja definir a ID da pose em uma habilidade)
#
# <F Pose Index = X>
#
#==============================================================================

#==============================================================================
# ■ SISTEMA DE ARQUIVOS DE IMAGES DOS PROJETEIS.
#==============================================================================
# Basicamente é a mesma dos battlers, com excessão da função de poses.
# As imagens deverão ser gravadas na pasta. /GRAPHICS/Projectile/
#
# Ex - Fire_Ball[F2][S4].png
#
#==============================================================================

#==============================================================================
# ■ DEFININDO PARÂMETROS DOS BATTLES
#==============================================================================
# Use as tags abaixo na caixa de notas para definir os parâmetros dos battlers.
#
# ● <Battler Name = NAME>
# Define o nome do arquivo da imagem do battler.
#
# ● <Move Speed = X>
# Define a velocidade de movimento do battler.
#
# ● <Jump>
# Ativa a função de pulo.
#
# ● <Double Jump>
# Ativa a função de pulo duplo. (É necessário ter a função jump ativada)
#
# ● <Dash>
# Ativa a função Dash.
#
# ● <Air Dash>
# Ativa a função de dash aério.
#
# ● <Flying Height = X>
# Ativa a função flutuar. (X é altura)
#
# ● <Guard Type = X>
# Definine o tipo da função GUARD.
# 0 - Desativa  / 1 - Cancela o impacto do dano. / 2 - Diminue 50% do dano.
#
# ● <Guard Rate = X>
# Ativa a probabilidade do battler ativar a função GUARD. 
#
# ● <Super Guard>
# Desativa o Knockback, ou seja, o personagem não recua ao receber dano.
#
# ● <Disable Movement>
# Desativa o movimento do battler.
#
# ● <Disable Action>
# Desativa as ações do battler.
#
# ● <Breath Effect>
# Ativa o efeito de respirar no sprite do battler.
#
# ● <Jump Height = X>
# Define a altura do pulo.
#
# ● <Jump Speed = X>
# Define a velocidade do pulo.
#
#==============================================================================

#==============================================================================
# ■ DEFININDO PARÂMETROS DAS HABILIDADES E ITEMS
#==============================================================================
# Use as tags abaixo na caixa de notas para definir os parâmetros das
# habilidades e itens.
#
# ● <F Skill Type = X>
# Define o tipo de habilidade.
# - Ground   - A habilidade só é ativada se o battler estiver no chão.
# - Aerial   - A habilidade só é ativada se o battler estiver no ar.
# - All      - A habilidade é ativada em qualquer situação.
#
# ● <F Duration = X>
# Define a duração da habilidade.
#
# ● <F Pose Duration = X>
# Define a duração da pose de ação
#
# ● <F Pose Index = X>
# Define a Index da pose da habilidade.
#
# ● <F Sprite = NAME>
# Define o nome do arquivo de sprite da habilidade.
#
# ● <F Blend Type = X>
# Define o tipo de blend do sprite da habilidade.
#
# ● <F Chain Action = X>
# Ativa automaticamente uma habilidade após a primeira ter finalizado.
#
# ● <F Multi Hit>
# A Habilidade causa multiplos acertos.
#
# ● <F Auto Target>
# A Habilidade acerta automaticamente o alvo.
#
# ● <F Auto Target Area>
# A Habilidade acerta automaticamente o alvo e os alvos que estiverem ao redor.
#
# ● <F Wait Collision = X>
# Define X tempo para que a habilidade cause impacto.
#
# ● <F Disable Piercing>
# Desativa a função atravessar o alvo.
#
# ● <F Knockback Stun>
# Faz com que o impacto da habilidade faça o battler cair no chão.
#
# ● <F Disable Knockback>
# Desativa a função knockback da habilidade.
#
# ● <F Super Guard>
# O usuário não recebe knockback durante a ação.
#
# ● <F Invunerable>
# O usuário fica invencível durante a ação.
#
# ● <F Ignore Guard>
# A Habilidade ignora se alvo estiver usando a função Guard.
#
# ● <F Ignore Knockback>
# A Habilidade causa acerto mesmo quando o alvo estiver sobre knockback
#
# ● <F Reflect> 
# O usuário reflete a habilidade durante a ação.
#
# ● <F Ignore Reflect>
# A Habilidade ignora a função Reflect.
#
# ● <F Hit Animation = X>
# Define a animação de acerto da habilidade.
#
# ● <F User Animation = X>
# Define a animação de uso da habilidade no usuário.
#
# ● <F Loop Pose>
# Faz a animação da pose dar loop.
#
# ● <F Move Speed = xX yY>
# Faz o usuário se mover durante a ação.
#
# ● <F User Move = xX yY>
# Define uma trajetória de movimento para habilidade. (uso de projéteis)
#
# ● <F Area = X1 - X2 - Y1 - Y2>
# Define a área de impacto da habilidade.
#
#         Y1
#
#
#   X1          X2
#
#
#         Y2
#
#==============================================================================

#==============================================================================
# ■ EVENT COMMANDS
#==============================================================================
# Use os comandos abaixo através da função chamar script, se deseja modificar
# algum parâmetro no meio do jogo.
#
# ● dash(actor_id,value)
# Ativa ou desativa a função DASH
#
# ● air_dash(actor_id,value)
# Ativa ou desativa a função AIR DASH
# 
# ● jump(actor_id,value)
# Ativa ou desativa a função pulo.
#
# ● double_jump(actor_id,value)
# Ativa ou desativa a função pulo duplo.
#
# ● guard_type(actor_id,value)
# Define o tipo de defesa
#
# ● gain_move_speed(actor_id,value)
# Aumenta ou diminui a velocidade de movimento.
#
# ● gain_jump_height(actor_id,value)
# Aumenta ou diminui a altura do pulo.
#
# ● gain_jump_speed(actor_id,value)
# Aumenta ou diminui a velocidade do pulo.
#
# ● set_skill(actor_id,slot_index,skill_id)
# Equipa automaticamente a habilidade no battler. (de 0 a 6)
#
# ● set_ground_height(value)
# Define a altura do chão.
# 
# ● auto_adjust_position(value)
# Ajusta automaticamente a posição inicial do battler.
#
#==============================================================================
module MOG_LMBS

  #--------------------------------------------------------------------------
  # Definição da velocidade padrão da animação do sprite do battler.
  # É possível definir uma animação específica no sprite adicionando esse
  # sufixo no nome da imagem.
  #
  # SPRITE_NAME[S + Animation Speed].png
  #
  # Athena[S10].png
  #
  #--------------------------------------------------------------------------
  DEFAULT_SPRITE_ANIMATION_SPEED = 8
  
  #--------------------------------------------------------------------------
  # ● Definição Y-axis do chão.
  #--------------------------------------------------------------------------
  GROUND_HEIGHT = 160  
  
  #--------------------------------------------------------------------------
  # ● Definição da duração do turno.
  #--------------------------------------------------------------------------
  TURN_DURATION = 500
  
  #--------------------------------------------------------------------------
  # ● Definição da duração do turno das condições
  #--------------------------------------------------------------------------
  STATES_TURN_DURATION = 200
  
  #--------------------------------------------------------------------------
  # ● Definição do tempo para escapar da batalha.
  # Esse valor é proporcional a média de agilidade de todos os battlers
  # somados.
  #--------------------------------------------------------------------------
  ESCAPE_RATIO = 100
  
  #--------------------------------------------------------------------------
  # ● Definição da velocidade de movimento padrão do Battler.
  #--------------------------------------------------------------------------
  DEFAULT_BATTLER_MOVE_SPEED = 4  
  
  #--------------------------------------------------------------------------
  # ● Definição da altura padrão do pulo do battler.
  #--------------------------------------------------------------------------
  DEFAULT_BATTLER_JUMP_HEIGHT = 150
  
  #--------------------------------------------------------------------------
  # ● Definição da velocidade padrão do pulo do battler. (Gravidade)
  #--------------------------------------------------------------------------
  DEFAULT_BATTLER_JUMP_SPEED = 7
  
  #--------------------------------------------------------------------------
  # ● Definição do tipo de defesa padrão para todos os battlers
  #--------------------------------------------------------------------------
  # 0 - Nada (Desativa a defesa)
  # 1 - Defesa perfeita. (Cancela o impacto da habilidade)
  # 2 - Reduz 50% do dano.
  #--------------------------------------------------------------------------
  DEFAULT_GUARD_TYPE = 1
  
  #--------------------------------------------------------------------------
  # ● Ativar a função Dash em todos os battlers.
  #  É possível usar o código abaixo para ativar o Dash
  # 
  # dash(ACTOR_ID,true)
  #
  # ou colocar a tag abaixo na caixa de notas.
  #
  # <Dash>
  #
  #--------------------------------------------------------------------------
  ENABLE_DASH_FOR_ALL = false
  
  #--------------------------------------------------------------------------
  # ● Ativar a função JUMP em todos os battlers.
  #  É possível usar o código abaixo para ativar o Dash
  # 
  # jump(ACTOR_ID,true)
  #
  # ou colocar a tag abaixo na caixa de notas.
  #
  # <Jump>
  #
  #-------------------------------------------------------------------------- 
  ENABLE_JUMP_FOR_ALL = false
  
  #--------------------------------------------------------------------------
  # ● Ativar o pulo duplo em todos os battlers.
  #  É possível usar o código abaixo para ativar o Air Dash
  # 
  # double_jump(ACTOR_ID,true)
  #
  # ou colocar a tag abaixo na caixa de notas.
  #
  # <Double Jump>
  #
  #--------------------------------------------------------------------------
  ENABLE_DOUBLE_JUMP_FOR_ALL = false
  
  #--------------------------------------------------------------------------
  # ● Definição da animação do pulo duplo
  #--------------------------------------------------------------------------
  DOUBLE_JUMP_ANIMATION_ID = 126
  
  #--------------------------------------------------------------------------
  # ● Possibilitar o pulo duplo durante o Dash.
  #--------------------------------------------------------------------------
  ALLOW_DOUBLE_JUMP_DURING_DASH_SPEED = false  
  
  #--------------------------------------------------------------------------
  # ● Ativar o movimento Air Dash em todos os battlers.
  #  É possível usar o código abaixo para ativar o Air Dash
  # 
  # air_dash(ACTOR_ID,true)
  #
  # ou colocar a tag abaixo na caixa de notas.
  #
  # <Air Dash>
  #
  #--------------------------------------------------------------------------
  ENABLE_AIR_DASH_FOR_ALL = false
  
  #--------------------------------------------------------------------------
  # ● Definição da animação ID do Air Dash.
  #--------------------------------------------------------------------------
  AIR_DASH_ANIMATION_ID = 125  
  
  #--------------------------------------------------------------------------
  # ● Possibilitar o movimento do Air Dash durante o Dash.
  #--------------------------------------------------------------------------
  ALLOW_AIR_DASH_DURING_DASH_SPEED = false
  
  #--------------------------------------------------------------------------
  # ● Ativa sombra nos battlers
  # É necessário ter o arquivo F_Shadow.png na pasta /Graphics/System/
  #--------------------------------------------------------------------------
  SHADOW_ENABLE = true
 
  #--------------------------------------------------------------------------
  # Definição da posição da sombra.
  #--------------------------------------------------------------------------
  SHADOW_POSITION = [0,-5]
  
  #--------------------------------------------------------------------------
  # ● Definir a posição do inimigo automaticamente.
  # É possível ativar ou desativar essa opção no meio do jogo usando o
  # código abaixo.
  #
  # auto_adjuste_position(false)
  #
  #--------------------------------------------------------------------------
  AUTO_ADJUSTE_ENEMY_POSITION = true  
  
  #--------------------------------------------------------------------------
  # ● Definição da posição da janela de comando.
  #--------------------------------------------------------------------------
  COMMAND_WINDOW_POSITION = [0,0]
  
  #--------------------------------------------------------------------------
  # ● Posição da janela de habilidades do LMBS 
  #--------------------------------------------------------------------------
  SKILL_LIST_POSITION = [0,96]  
  
  #--------------------------------------------------------------------------
  # ● Definição da posição inicial dos battlers
  #--------------------------------------------------------------------------
  START_POSITION = 150
  
  #--------------------------------------------------------------------------
  # ● Definição dos nomes dos comandos da janela de comandos.
  #--------------------------------------------------------------------------
  COMMAND_WINDOW_LIST_NAME = ["Item","Equip Skill"]  
  
  #--------------------------------------------------------------------------
  # ● Definição do nome da cena de equipar Skill.
  #--------------------------------------------------------------------------
  SCENE_EQUIP_SKILL_NAME = "Equip Skill"
  
  #--------------------------------------------------------------------------
  # ● Definição do som ativado quando battler não tem MP or TP.
  #--------------------------------------------------------------------------
  MP_COST_SE = "Cursor1"
 
  #--------------------------------------------------------------------------
  # ● Definição da posição do cursor.
  #--------------------------------------------------------------------------
  CURSOR_POSITION = [0,0]
  CURSOR_NAME_POSITION = [0,10]  
  CURSOR_ACTOR_POSITION = [0,0]
  
  #--------------------------------------------------------------------------
  # ● Ativar fade no cursor após alguns segundos.
  #--------------------------------------------------------------------------
  CURSOR_ACTOR_FADE_EFFECT = true
  
  #--------------------------------------------------------------------------
  # ● Definição da posição do sprite de escape.
  #--------------------------------------------------------------------------
  ESCAPE_SPRITE_POSITION = [Graphics.width / 2,100]
  ESCAPE_SPRITE_METER_POSITION = [0,17]
  
  #--------------------------------------------------------------------------
  # ● Definição do botão de ataque.
  #--------------------------------------------------------------------------
  ATTACK_BUTTON = :C
  #--------------------------------------------------------------------------
  # ● Definição do botão de habilidade.
  #--------------------------------------------------------------------------
  SKILL_BUTTON = :Z
  #--------------------------------------------------------------------------
  # ● Definição do botão de defesa.
  #--------------------------------------------------------------------------
  GUARD_BUTTON = :Y
  #--------------------------------------------------------------------------
  # ● Definição do botão de corrida.
  #--------------------------------------------------------------------------  
  DASH_BUTTON = :X
  #--------------------------------------------------------------------------
  # ● Definição do botão para ativar o menu.
  #--------------------------------------------------------------------------  
  MENU_BUTTON = :B
end

$imported = {} if $imported.nil?
$imported[:mog_lmbs] = true

#==============================================================================
# ■ Game Temp
#==============================================================================
class Game_Temp
  
  attr_accessor :battle_end
  attr_accessor :fmb_arena
  attr_accessor :fmb_phase_data
  attr_accessor :fmb_menu_phase
  attr_accessor :fmb_phase_end
  attr_accessor :f_cursor_target
  attr_accessor :f_cursor_data
  attr_accessor :f_sprite_fade
  attr_accessor :f_escape_phase
  attr_accessor :f_actor_cursor_d
  
  #--------------------------------------------------------------------------
  # ● Initialize
  #--------------------------------------------------------------------------             
  alias mog_fmbs_temp_initialize initialize
  def initialize
      @battle_end = false
      @fmb_arena = [[],1.00]
      @fmb_phase_data = [0,0]
      @fmb_menu_phase = [false,0,false]
      @f_cursor_data  = [nil,nil]
      @f_escape_phase = [false,0,0,0]
      @fmb_phase_end = 0
      @f_actor_cursor_d = 0
      mog_fmbs_temp_initialize
  end
  
  #--------------------------------------------------------------------------
  # ● F Fmbs Clear
  #--------------------------------------------------------------------------             
  def f_fmbs_clear
      @battle_end = false
      @fmb_phase_data = [0,0]
      @fmb_menu_phase = [false,0,false]
      @f_cursor_data  = [nil,nil]
      @f_sprite_fade = [false,0]
      @f_escape_phase = [false,0,0,0]
  end    
  
  #--------------------------------------------------------------------------
  # ● f In Action?
  #--------------------------------------------------------------------------
  def f_in_action?
      return false if $game_troop.interpreter.running?
      return false if $game_temp.battle_end
      return false if $game_temp.fmb_phase_data[1] > 0 
      return true
  end
    
end

#==============================================================================
# ■ Game System
#==============================================================================
class Game_System
  
  attr_accessor :fmbs_data
  attr_accessor :f_turn_data
  attr_accessor :f_adjust_position_auto
  attr_accessor :f_collision_effect
  
  #--------------------------------------------------------------------------
  # ● Initialize
  #--------------------------------------------------------------------------             
  alias mog_fmbs_sys_initialize initialize
  def initialize
      @fmbs_data = [true,0]
      @fmbs_data[1] = [[MOG_LMBS::GROUND_HEIGHT, Graphics.height - 32].min, 32].max 
      @f_adjust_position_auto = MOG_LMBS::AUTO_ADJUSTE_ENEMY_POSITION
      @f_collision_effect = [true,false]
      @f_turn_data = [0,MOG_LMBS::STATES_TURN_DURATION,0]
      mog_fmbs_sys_initialize
  end
  
end

#==============================================================================
# ■ Cache
#==============================================================================
module Cache
  
  #--------------------------------------------------------------------------
  # ● Projectile
  #--------------------------------------------------------------------------
  def self.projectile(filename)
      load_bitmap("Graphics/Projectile/", filename)    
  end
  
end

#==============================================================================
# ■ Sound
#==============================================================================
module Sound
  
  #--------------------------------------------------------------------------
  # ● Play MP Cost
  #--------------------------------------------------------------------------
  def self.play_mp_cost
     Audio.se_play("Audio/SE/" + MOG_LMBS::MP_COST_SE, 100, 100)
  end
  
end

#==============================================================================
# ■ Game Interpreter
#==============================================================================
class Game_Interpreter
  
  #--------------------------------------------------------------------------
  # ● Dash
  #--------------------------------------------------------------------------             
  def dash(actor_id,value)
      $game_party.all_members.each do |actor|
      actor.f_dash[0] = value if actor.id == actor_id  end 
  end
  
  #--------------------------------------------------------------------------
  # ● Jump
  #--------------------------------------------------------------------------             
  def jump(actor_id,value)
      $game_party.all_members.each do |actor|
      actor.f_jump[0] = value if actor.id == actor_id  end 
  end   
  
  #--------------------------------------------------------------------------
  # ● Double Jump
  #--------------------------------------------------------------------------             
  def double_jump(actor_id,value)
      $game_party.all_members.each do |actor|
      actor.f_double_jump[0] = value if actor.id == actor_id end
  end  
    
  #--------------------------------------------------------------------------
  # ● Air Dash
  #--------------------------------------------------------------------------             
  def air_dash(actor_id,value)
      $game_party.all_members.each do |actor|
      actor.f_air_dash[0] = value if actor.id == actor_id  end 
  end
  
  #--------------------------------------------------------------------------
  # ● Gain Move Speed
  #--------------------------------------------------------------------------             
  def gain_move_speed(actor_id,value)
      $game_party.all_members.each do |actor|
      if actor.id == actor_id
         actor.move_speed += value
         actor.move_speed = 1 if actor.move_speed < 1
      end   
      end
  end    
  
  #--------------------------------------------------------------------------
  # ● Gain Jump Height
  #--------------------------------------------------------------------------             
  def gain_jump_height(actor_id,value)
      $game_party.all_members.each do |actor|
      if actor.id == actor_id
         actor.jump_height += value
         actor.jump_height = 32 if actor.jump_height < 32
      end
      end 
  end  
  
  #--------------------------------------------------------------------------
  # ● Gain Jump Speed
  #--------------------------------------------------------------------------             
  def gain_jump_speed(actor_id,value)
      $game_party.all_members.each do |actor|
      if actor.id == actor_id
         actor.jump_speed += value
         actor.jump_speed = 1 if actor.jump_height < 1
      end
      end 
  end    
 
  #--------------------------------------------------------------------------
  # ● Guard Type
  #--------------------------------------------------------------------------             
  def guard_type(actor_id,value)
      $game_party.all_members.each do |actor|
      if actor.id == actor_id
         actor.f_guard[0] = [[value, 2].min, 0].max
      end
      end 
  end      
  
  #--------------------------------------------------------------------------
  # ● Set skill
  #--------------------------------------------------------------------------             
  def set_skill(actor_id,slot_id,skill_id)
      return if slot_id > 7
      skill = $data_skills[skill_id] rescue nil
      return if skill.nil?
      $game_party.all_members.each do |actor|
      break if slot_id.abs >= actor.f_equipped_skill.size  
      if actor.id == actor_id
         actor.f_equipped_skill[slot_id] = skill_id
      end
      end 
  end   
  
  #--------------------------------------------------------------------------
  # ● Auto Adjust Position
  #--------------------------------------------------------------------------             
  def auto_adjust_position(value)
      $game_system.f_adjust_position_auto = value
  end
    
  #--------------------------------------------------------------------------
  # ● Set Ground Height
  #--------------------------------------------------------------------------             
  def set_ground_height(value)
      $game_system.fmbs_data[1] = [[Graphics.height - value, Graphics.height - 32].min, 32].max
  end  
   
  #--------------------------------------------------------------------------
  # ● Command 339
  #--------------------------------------------------------------------------             
  def command_339
      pr_t = nil
      if @params[0] == 0
         enemies = $game_party.battle_members
         allies = $game_troop.alive_members
         batr = $game_troop.members[@params[1] - 1]
      else  
         enemies = $game_troop.alive_members
         allies = $game_party.battle_members
         batr = $game_party.members[@params[1] - 1]
      end  
      return if batr.dead?
      skill_id = @params[2]
      skill = $data_skills[skill_id]
      batr.f_action[1] = nil
      batr.f_action_clear
      if skill.note =~ /<F Auto Target Area>/ or skill.note =~ /<F Auto Target>/
         if skill.for_opponent?
            pr_t = enemies[@params[3]] rescue nil if @params[3] >= 0
            pr_t = batr.f_target if pr_t.nil?
         else  
            pr_t = allies[@params[3]] rescue nil if @params[3] >= 0
            pr_t = batr if pr_t.nil?
         end 
         batr.f_execute_skill(skill_id,pr_t,0)
      else
         batr.f_execute_skill(skill_id)
      end   
      Fiber.yield while batr.f_mov_acting?
  end
  
end

#==============================================================================
# ■ BattleManager
#==============================================================================
class << BattleManager
  
  attr_accessor :f_targets
  attr_accessor :escape_ratio
  
  #--------------------------------------------------------------------------
  # ● Init Members
  #--------------------------------------------------------------------------             
  alias mog_fmbs_init_members init_members
  def init_members
      @active_actor = nil ; @active_actor_index = 0 ; next_actor_index(0)
      @f_targets = nil ; @f_cursor_index = 0
      mog_fmbs_init_members
  end
  
  #--------------------------------------------------------------------------
  # ● Actor
  #--------------------------------------------------------------------------             
  alias mog_fmbs_bm_actor actor
  def actor
      return @active_actor if $game_system.fmbs_data[0]
      mog_fmbs_bm_actor
  end  
  
  #--------------------------------------------------------------------------
  # ● Process Victory
  #--------------------------------------------------------------------------            
  alias mog_fmbs_process_victory process_victory
  def process_victory
      $game_temp.fmb_phase_end = 1
      $game_temp.battle_end = true
      mog_fmbs_process_victory
      $game_temp.fmb_phase_end = 4
  end
    
  #--------------------------------------------------------------------------
  # ● Process Defeat
  #--------------------------------------------------------------------------            
  alias mog_fmbs_process_defeat process_defeat
  def process_defeat
      $game_temp.fmb_phase_end = 2
      $game_temp.battle_end = true
      mog_fmbs_process_defeat
      $game_temp.fmb_phase_end = 4
  end
    
  #--------------------------------------------------------------------------
  # ● Process Abort
  #--------------------------------------------------------------------------            
  alias mog_fmbs_process_abort process_abort
  def process_abort
      $game_temp.fmb_phase_end = 3
      $game_temp.battle_end = true
      mog_fmbs_process_abort
      #$game_temp.fmb_phase_end = 4
  end  
  
end

#==============================================================================
# ■ BattleManager
#==============================================================================
module BattleManager
  
  #--------------------------------------------------------------------------
  # ● Self Next Actor Index
  #--------------------------------------------------------------------------             
  def self.next_actor_index(value)
      set_active_actor(nil)
      $game_party.battle_members.size.times do
           @active_actor_index += value
           @active_actor_index = 0 if @active_actor_index >= $game_party.battle_members.size
           @active_actor_index = $game_party.battle_members.size - 1 if @active_actor_index < 0
           act = $game_party.battle_members[@active_actor_index] 
           if !act.nil? and !act.dead? and act.restriction == 0
              set_active_actor(act)
              break
           end
      end          
      set_usable_actor if @active_actor.nil?
      $game_temp.f_actor_cursor_d = 120
  end
  
  #--------------------------------------------------------------------------
  # ● Set Usable Actor
  #--------------------------------------------------------------------------             
  def self.set_usable_actor
      $game_party.battle_members.each_with_index do |act,i|
          next if act.dead? or act.restriction != 0
          set_active_actor(act)
          break
      end
  end
  
  #--------------------------------------------------------------------------
  # ● Set Active Actor
  #--------------------------------------------------------------------------             
  def self.set_active_actor(actor)
      @active_actor = actor
  end
  
  #--------------------------------------------------------------------------
  # ● Active Actor
  #--------------------------------------------------------------------------             
  def self.active_actor
      return @active_actor
  end
  
  #--------------------------------------------------------------------------
  # ● Set F Targets
  #--------------------------------------------------------------------------             
  def self.set_f_targets(targets)
      @f_targets = targets
  end
  
  #--------------------------------------------------------------------------
  # ● Cursor Next Target
  #--------------------------------------------------------------------------             
  def self.cursor_next_target(value,type)
      $game_temp.f_cursor_target = nil ; ftrg = []
      trgt = $game_troop.alive_members if type == 0
      trgt = $game_party.battle_members if type == 1
      trgt.each_with_index do |b,i| ; next if b.nil? ; ftrg.push([b,i]) ; end
      ftrg.sort! {|a,b| a[0].screen_x - b[0].screen_x }
      if $game_temp.f_cursor_data[0].nil?
         @f_cursor_index = ftrg[0][1] ; $game_temp.f_cursor_data[0] = true
      end  
      ftrg.size.times do
          @f_cursor_index += value
          @f_cursor_index = 0 if @f_cursor_index >= ftrg.size
          @f_cursor_index = ftrg.size - 1 if @f_cursor_index < 0
          next if ftrg[@f_cursor_index][0].nil?
          $game_temp.f_cursor_target = ftrg[@f_cursor_index][0]
          break
      end
  end
 
  #--------------------------------------------------------------------------
  # ● F Cursor Index
  #--------------------------------------------------------------------------             
  def self.f_cursor_index
      @f_cursor_index
  end
  
  #--------------------------------------------------------------------------
  # ● F Make Targets
  #--------------------------------------------------------------------------             
  def self.f_make_targets(item,user,last_target = nil)      
      targets = []
      return targets if user.nil? or item.nil? or item.scope == 0
      if user.is_a?(Game_Actor)
         allies_targets = $game_party.battle_members 
         enemies_targets = $game_troop.alive_members
      else
         allies_targets = $game_troop.alive_members
         enemies_targets = $game_party.battle_members 
      end   
      if [1,2,3,4,5,6].include?(item.scope)
         last_target = user.f_target if last_target.nil?
         enemies_targets.each_with_index do |t,i|
           next if t.dead?
           targets.push(t) if [1].include?(item.scope) and t == last_target
           targets.push(t) if [2].include?(item.scope)
           targets.push(t) if [3].include?(item.scope) and i < 1
           targets.push(t) if [4].include?(item.scope) and i < 2
           targets.push(t) if [5].include?(item.scope) and i < 3
           targets.push(t) if [6].include?(item.scope) and i < 4
         end
       elsif [7,8,9,10].include?(item.scope)
          last_target = f_make_p_target(0,allies_targets,item) if last_target.nil?
          allies_targets.each_with_index do |t,i|
            targets.push(t) if [9].include?(item.scope) and t == last_target and t.dead?
            targets.push(t) if [10].include?(item.scope) and t.dead?
            next if t.dead?
            targets.push(t) if [7].include?(item.scope) and t == last_target
            targets.push(t) if [8].include?(item.scope)
           end 
       else
            targets.push(user)
       end
       return targets
  end
  
  #--------------------------------------------------------------------------
  # ● F Make P Target
  #--------------------------------------------------------------------------             
  def self.f_make_p_target(type,members,item)
      mb = []
      if [9,10].include?(item.scope)
         members.each do |m| mb.push(m) if m.dead? end  
      else  
         members.each do |m| mb.push(m) if !m.dead? end 
      end  
        mb.sort! {|a,b| a.hp - b.hp } if type == 0
        mb.sort! {|a,b| b.hp - a.hp } if type == 1
      return mb[0]
  end
  
  #--------------------------------------------------------------------------
  # ● F Process Escape
  #--------------------------------------------------------------------------             
  def self.f_process_escape
      $game_party.battle_members.each do |actor|
         actor.f_sprite_fade = [true,0]
      end   
      $game_temp.battle_end = true
      $game_message.add(sprintf(Vocab::EscapeStart, $game_party.name))
      process_abort
      wait_for_message
  end  
  
  #--------------------------------------------------------------------------
  # ● P Target Near
  #--------------------------------------------------------------------------             
  def self.p_target_near(user)
      p_index = 0 ; ftrg = []
      trgt = $game_troop.alive_members if user.is_a?(Game_Actor)
      trgt = $game_party.battle_members if user.is_a?(Game_Enemy)
      return if trgt.empty?
      trgt.each do |b| 
          next if b.nil?
          next if b.dead?
          df = (user.screen_x - b.screen_x).abs
          ftrg.push([b,df])
      end
      return if ftrg.empty?
      ftrg.sort! {|a,b| a[1] - b[1]}
      user.f_target = ftrg[0][0]
  end  
  
  #--------------------------------------------------------------------------
  # ● F Execute Action
  #--------------------------------------------------------------------------
  def self.f_execute_action(user,item)
      return if item.nil?
      execute_auto_target(user,item)
   end
   
  #--------------------------------------------------------------------------
  # ● Execute Auto Target
  #--------------------------------------------------------------------------
  def self.execute_auto_target(user,item)
      target = $game_temp.f_cursor_target
      trg = BattleManager.f_make_targets(item,user,target)
      return if trg.empty?
      user.f_force_action = [item,trg]
  end  
  
  #--------------------------------------------------------------------------
  # ● F Clear Command Selection
  #--------------------------------------------------------------------------
  def self.f_clear_command_selection
      $game_temp.fmb_menu_phase = [false,0,false]
      $game_temp.f_cursor_target = nil
      $game_temp.f_cursor_data = [nil,nil]      
  end  
  
end

#==============================================================================
# ■ Game_BattlerBase
#==============================================================================
class Game_BattlerBase

  #--------------------------------------------------------------------------
  # ● Guard?
  #--------------------------------------------------------------------------
  alias mog_fmbs_guard? guard?
  def guard?
      return true if @f_guard[1]
      mog_fmbs_guard?
  end
   
end

#==============================================================================
# ■ Game_Battler
#==============================================================================
class Game_Battler < Game_BattlerBase

  attr_accessor :f_action
  attr_accessor :f_action_m
  attr_accessor :f_force_action
  attr_accessor :f_target
  attr_accessor :f_damage
  attr_accessor :f_damage_effect  
  attr_accessor :f_knockback
  attr_accessor :f_equipped_skill
  attr_accessor :f_ai_data
  attr_accessor :f_char_data
  attr_accessor :f_dash
  attr_accessor :f_crouch
  attr_accessor :f_guard
  attr_accessor :f_air_dash 
  attr_accessor :f_double_jump
  attr_accessor :f_sprite_fade
  attr_accessor :f_flying_type
  attr_accessor :f_breath_effect
  attr_accessor :f_force_move_to
  attr_accessor :f_action_time
  attr_accessor :f_fix_direction
  attr_accessor :f_air_ground
  attr_accessor :f_cast_data
  attr_accessor :f_a_target
  attr_accessor :f_turn_data
  attr_accessor :f_action_freq
  attr_accessor :f_wep_data
  attr_accessor :f_ai_guard
  attr_accessor :f_super_guard
  attr_accessor :f_move
  attr_accessor :f_e_action
  attr_accessor :sprite_data
  attr_accessor :move_speed
  attr_accessor :jump_height
  attr_accessor :jump_speed  
  attr_accessor :skill_list
  attr_accessor :normal_list
  attr_accessor :recover_list
  attr_accessor :revive_list
  
  #--------------------------------------------------------------------------
  # ● Initialize
  #--------------------------------------------------------------------------
  alias mog_fmbs_gb_initialize initialize
  def initialize
      set_f_basic_parameters
      mog_fmbs_gb_initialize
      set_initial_f_data
  end

  #--------------------------------------------------------------------------
  # ● Set F Basic Para
  #--------------------------------------------------------------------------
  def set_f_basic_parameters
      @f_char_data = [false,0,0,false] ; @f_knockback = [true,20,5,0,0]
      @f_dash = [MOG_LMBS::ENABLE_DASH_FOR_ALL,0]
      @f_crouch = [false,0]
      @f_air_dash = [MOG_LMBS::ENABLE_AIR_DASH_FOR_ALL,false,false,0] 
      @f_double_jump = [MOG_LMBS::ENABLE_DOUBLE_JUMP_FOR_ALL,false,false,0]
      @f_equipped_skill = [nil,nil,nil,nil,nil,nil,nil] ; @f_guard = [0,0]      
      @f_guard[0] = [[MOG_LMBS::DEFAULT_GUARD_TYPE, 2].min, 0].max
      @move_speed = [[MOG_LMBS::DEFAULT_BATTLER_MOVE_SPEED, 9999].min, 1].max
      @jump_height = [[MOG_LMBS::DEFAULT_BATTLER_JUMP_HEIGHT, 9999].min, 30].max
      @jump_speed = [[MOG_LMBS::DEFAULT_BATTLER_JUMP_SPEED, 9999].min, 1].max
      @f_jump = [MOG_LMBS::ENABLE_JUMP_FOR_ALL,0]
      @f_flying_type  = [false,0,0,0,100]
      @f_breath_effect = [false,0,0,0,0.0015]
      @f_action_time = [false,0,0]
      @f_super_guard = [false,0]
      @f_move = [true,0]
      @f_e_action = [true,0]
      #A - Move Freq
      #B - Move to Target Freq
      #C - Force Move to Target
      #D - Jump Enable
      @f_action_freq = [45,4,false,true,0,90]
      @f_ai_guard = [false,0,false,0]      
  end    
  
  #--------------------------------------------------------------------------
  # ● Set Initial F Data
  #--------------------------------------------------------------------------
  def set_initial_f_data      
      @arena_range = [16 ,Graphics.width - 16,0,0]
      @f_damage = [0,nil,0,false,0,1,7,0,0,0]
      @f_damage_effect = [0,nil,0,false]
      @f_action_m = [false,0,0,0]
      @f_force_action = [nil,[]]
      @f_force_move_to = [false,0,0]
      @f_ai_data = [0, 
            rand(f_action_freq) + 10,
            0,
            [0,0,0,0,0,0], #3 - Movement
            0,
            0]
      @f_fix_direction = [false,0]
      @f_air_ground = [false,0]
      @f_cast_data = [nil,0]
      @f_ai_guard[0] = false
      @f_ai_guard[2] = false
      @f_ai_guard[3] = 0
      @f_a_target = nil
      @f_wep_data = nil
      @normal_list = [] 
      @recover_list = []
      @revive_list = []
      @skill_list = []
      @f_turn_data = [0,MOG_LMBS::STATES_TURN_DURATION,0]
      # @sprite_data = [A,B,C,D,E,F,G[D,P],H....]
      # A0  - Sprite Index
      # B1  - Animation Index
      # C2  - Animation Speed (Current Index)
      # D3  - Battler Direction (0 - Left , 1 - Right)
      # E4  - Crouch
      # F5  - Dash
      # G6  - Jump (Jumping?, D - Direction / Phase / Jump Height )
      # H7  - Pressed Key
      # I8  - Walking? [true,Direction]
      # J9  - Pressed Direction (0 - Left , 1 - Right)
      # L10 - Guard 
      # N11 - Skill Action [Skill,Action Duration ]
      # M12 - Sprite Size [Width,Height,Limit X1, Limit X2, Limit Y1, Limit Y2  ]
      # O13 - Auto Direction Time
      # P14 - Sprite Height Fix
      #               A B C D   E          F              G               H     I                
      @sprite_data = [0,0,0,0,false,[false,false],[false,0,0,false,false,0],0,[false,0],
      #               J      L               N                          M      
                      0,[false,false],[nil,0,0,false,false,false],[0,0,0,0,0,0],
      #               O P                 
                      0,0]      
      set_sprite_size      
      f_action_clear
      @f_action_freq[4] = rand(@f_action_freq[5] / 2)
  end
           
  #--------------------------------------------------------------------------
  # ● Set Fmbs Initial Parameters
  #--------------------------------------------------------------------------             
  def set_fmbs_initial_parameters(f_battler)
      @battler_name = $1.to_s if f_battler.note =~ /<Battler Name = (\S+)>/
      @move_speed = $1.to_i if f_battler.note =~ /<Move Speed = (\d+)>/
      @jump_height = $1.to_i if f_battler.note =~ /<Jump Height = (\d+)>/
      @jump_speed = $1.to_i if f_battler.note =~ /<Jump Speed = (\d+)>/
      @f_dash[0] = true if f_battler.note =~ /<Dash>/
      @f_air_dash[0] = true if f_battler.note =~ /<Air Dash>/
      @f_jump[0] = true if f_battler.note =~ /<Jump>/
      @f_double_jump[0] = true if f_battler.note =~ /<Double Jump>/
      @f_action_freq[5] = [[$1.to_i, 999].min, 10].max if f_battler.note =~ /<Action Frequence = (\d+)>/
      if f_battler.note =~ /<Breath Effect>/
         @f_breath_effect = [false,0,rand(30),0,0.0015]
         @f_breath_effect[1] = @f_breath_effect[2] * @f_breath_effect[4]         
         @f_breath_effect[0] = true 
      end   
      if f_battler.note =~ /<Flying Height = (\d+)>/
         @f_flying_type  = [false,rand(15),0,rand(4),100] ; @f_flying_type[2] = @f_flying_type[1]
         @f_flying_type[0] = true 
         @f_flying_type[4] = $1.to_i.abs
      end   
      @f_sprite_fade = [false,0] ; @f_escape_ratio = 0
      @f_ai_guard[1] = $1.to_i if f_battler.note =~ /<Guard Rate = (\d+)>/
      @f_super_guard[0] = true if f_battler.note =~ /<Super Guard>/
      @f_move[0] = false if f_battler.note =~ /<Disable Movement>/
      @f_e_action[0] = false if f_battler.note =~ /<Disable Action>/
      if f_battler.note =~ /<Guard Type = (\d+)>/
         @f_guard[0] = [[$1.to_i, 2].min, 0].max
      end    
  end   
  
  #--------------------------------------------------------------------------
  # ● Set Sprite Size
  #--------------------------------------------------------------------------
  def set_sprite_size
      return if @f_char_data[0]
      return if @battler_name.nil? or @battler_name == "" 
      original_sprite = Cache.battler(@battler_name.to_s, 0) rescue nil
      return if original_sprite.nil?
      cw = [[original_sprite.width, 999].min, 32].max 
      ch = [[original_sprite.height, 999].min, 32].max
      @sprite_data[12] = [cw, ch,cw / 2, ch / 2]
      @f_breath_effect[4] = 0.0030 - (f_body_height * 0.000006) if f_breath_effect?
      @f_escape_ratio = MOG_LMBS::ESCAPE_RATIO + (MOG_LMBS::ESCAPE_RATIO * ($game_troop.agi / $game_party.agi))
      @f_action_freq[4] = rand(@f_action_freq[5] / 2)
  end  
 
  #--------------------------------------------------------------------------
  # ● Set Equip Data
  #--------------------------------------------------------------------------
  def set_equip_data
      return if self.is_a?(Game_Enemy)
      return if @equips[0].nil?
      @f_wep_data = @equips[0]
  end  
  
  #--------------------------------------------------------------------------
  # ● F Set Action
  #--------------------------------------------------------------------------
  def f_set_action(skill_id)
      clear_actions
      action = Game_Action.new(self, true)
      action.set_skill(skill_id)
      @actions.push(action)    
  end   
  
  #--------------------------------------------------------------------------
  # ● F Clear Poses
  #--------------------------------------------------------------------------
  def f_clear_poses
      @sprite_data[0] = 0
      @sprite_data[1] = 0
      @sprite_data[4] = false
      @sprite_data[5][0] = false
      @sprite_data[6] = [false,0,0,false,false,0] 
      @sprite_data[8] = false
      @sprite_data[10][0] = false
  end  
  
  #--------------------------------------------------------------------------
  # ● F Clear Basic Poses
  #--------------------------------------------------------------------------
  def f_clear_basic_poses
      @sprite_data[5][0] = false
      @sprite_data[10][0] = false
      @sprite_data[8] = false
      @sprite_data[7] = 0
      @sprite_data[4] = false
      @sprite_data[9] = -1 
  end
  
  #--------------------------------------------------------------------------
  # ● F Update Animation Mirror
  #--------------------------------------------------------------------------
  def f_update_animation_mirror
      @animation_mirror = f_direction == 0 ? true : false
  end
    
  #--------------------------------------------------------------------------
  # ● F Execute Chain Action
  #--------------------------------------------------------------------------
  def f_execute_chain_action(skill)
      if !skill.nil? and skill.note =~ /<F Chain Action = (\d+)>/
         @f_action_time[2] = 0
         f_execute_skill($1.to_i)
      end   
  end
    
  #--------------------------------------------------------------------------
  # ● ATB
  #--------------------------------------------------------------------------             
  if $imported[:mog_atb_system] 
  alias mog_fmbs_atb atb
  def atb
      return 0 if $game_system.fmbs_data[0]
      mog_fmbs_atb
  end  
  end
  
  #--------------------------------------------------------------------------
  # ● F Move
  #--------------------------------------------------------------------------             
  def f_move(type)
      @sprite_data[7] = type
      case type
        when 0 ; f_mov_crouch
        when 1 ; f_mov_jump
        when 2 ; f_mov_side(0)
        when 3 ; f_mov_side(1)
      end
  end
  
  #--------------------------------------------------------------------------
  # ● F Mov
  #--------------------------------------------------------------------------             
  def f_mov_crouch
      return if !f_crouch_conditions_met?
      @sprite_data[4] = true
      @sprite_data[5][0] = false
      @sprite_data[8] = false
  end
  
  #--------------------------------------------------------------------------
  # ● F Crouch Conditions Met?
  #--------------------------------------------------------------------------             
  def f_crouch_conditions_met?
      return false if !f_crouch_usable?
      return false if f_mov_jumping?
      return false if f_mov_acting?
      return false if f_mov_damage?
      return false if f_force_movement?    
      return false if f_casting?
      return false if $game_temp.fmb_phase_data != [0,0]   
      return true
  end
  
  #--------------------------------------------------------------------------
  # ● F Mov Speed
  #--------------------------------------------------------------------------             
  def f_mov_speed
      return 2
  end
  
  #--------------------------------------------------------------------------
  # ● F Mov Jumping?
  #--------------------------------------------------------------------------             
  def f_mov_jumping?
      return @sprite_data[6][0]
  end

  #--------------------------------------------------------------------------
  # ● F Mov Falling
  #--------------------------------------------------------------------------             
  def f_mov_falling?
      return @sprite_data[6][3]
  end  
  
  #--------------------------------------------------------------------------
  # ● F Mov Victory
  #--------------------------------------------------------------------------             
  def f_mov_victory?
      return $game_temp.fmb_phase_end == 1
  end
  
  #--------------------------------------------------------------------------
  # ● F Waking
  #--------------------------------------------------------------------------             
  def f_walking?
      return false if $game_temp.fmb_phase_data != [0,0]
      return false if !f_ground? and !f_flying_type?
      return false if !f_movable?
      return false if f_mov_dashing? 
      return false if f_mov_guarding?
      return true if [2,3].include?(@sprite_data[7])  
      return false if @sprite_data[9] == -1        
      return @sprite_data[8]
  end
  
  #--------------------------------------------------------------------------
  # ● F Mov Crouching
  #--------------------------------------------------------------------------             
  def f_mov_crouching?
      return false if $game_temp.fmb_phase_data != [0,0]
      return false if !f_ground?
      return false if !f_movable?
      return @sprite_data[4]
  end
  
  #--------------------------------------------------------------------------
  # ● F Mov Guarding
  #--------------------------------------------------------------------------             
  def f_mov_guarding?
      return false if $game_temp.fmb_phase_data != [0,0]
      return false if !f_movable?
      return false if !f_ground? and !f_flying_type?
      return true if @f_knockback[4] > 0
      return @sprite_data[10][0]
  end  
  
  #--------------------------------------------------------------------------
  # ● F Force Movement?
  #--------------------------------------------------------------------------             
  def f_force_movement?
      @f_action_m[0]
  end   
  
  #--------------------------------------------------------------------------
  # ● F Mov Damage
  #--------------------------------------------------------------------------             
  def f_mov_damage?
      return false if dead?
      return true if f_mov_unconscious?
      @f_damage[3]
  end  
    
  #--------------------------------------------------------------------------
  # ● F Movable?
  #--------------------------------------------------------------------------             
  def f_movable?      
      return false if f_mov_damage?
      return false if f_mov_acting?
      return false if f_mov_unconscious?
      return false if restriction == 4
      return false if @f_action_time[2] > 0
      return true
  end
  
  #--------------------------------------------------------------------------
  # ● F Mov Acting
  #--------------------------------------------------------------------------             
  def f_mov_acting?
      return false if f_mov_damage?      
      return !@sprite_data[11][0].nil?
  end
  
  #--------------------------------------------------------------------------
  # ● F Mov Unconcious
  #--------------------------------------------------------------------------             
  def f_mov_unconscious?
      return true if dead?
      @f_knockback[3] > 0
  end
  
  #--------------------------------------------------------------------------
  # ● F air Knockback?
  #--------------------------------------------------------------------------             
  def f_mov_air_knockback?
      @f_damage_effect[0] == 2
  end
  
  #--------------------------------------------------------------------------
  # ● F Update Base Pose
  #--------------------------------------------------------------------------             
  def f_update_base_pose
      @f_ai_data[2] -= 1 if @f_ai_data[2] > 0
      @f_action_time[0] = false if f_ground?   
      @f_action_time[2] -= 1if @f_action_time[2] > 0
      @sprite_data[0] = f_set_pose
      f_clear_basic_poses
      f_check_screen_xy_limit
  end
  
  #--------------------------------------------------------------------------
  # ● F Set Pose
  #--------------------------------------------------------------------------             
  def f_set_pose
      return 9 if f_mov_unconscious?
      return 8 if f_mov_damage?
      if f_mov_acting?
         return @sprite_data[11][2] + 1000 if @f_action[4] == 0
         return @sprite_data[11][2] + 2000 if @f_action[4] == 1
      end    
      return 11 if f_mov_victory?
      return 10 if f_casting?
      return 1 if f_walking?
      return 5 if f_mov_air_dash?
      return 3 if f_mov_falling? and !f_mov_acting?
      return 2 if f_mov_double_jump? and !f_mov_acting?
      return 2 if f_mov_jumping? and !f_mov_acting?
      return 4 if f_mov_crouching? and !f_mov_guarding?
      return 5 if f_mov_dashing?
      return 7 if f_mov_guarding? and f_mov_crouching?
      return 6 if f_mov_guarding?
      return 0
  end
  
  #--------------------------------------------------------------------------
  # ● F Noloop Animation
  #--------------------------------------------------------------------------             
  def f_noloop_animation?
      return false if @f_action[6]
      return true if f_mov_acting?
      return true if f_mov_victory?
      return true if f_mov_jumping? 
      return true if f_mov_double_jump?
      return true if f_mov_crouching?
      return true if f_mov_guarding?
      return true if !f_movable?
      return true if f_mov_air_dash?
      return true if f_mov_unconscious?
      return true if @sprite_data[6][3]
      return false
  end
  
end

#==============================================================================
# ■ Game_Battler
#==============================================================================
class Game_Battler < Game_BattlerBase
  
  #--------------------------------------------------------------------------
  # ● F Direction 
  #--------------------------------------------------------------------------             
  def f_direction
      @sprite_data[3]
  end
  
  #--------------------------------------------------------------------------
  # ● F Flying Type?
  #--------------------------------------------------------------------------             
  def f_flying_type?
      @f_flying_type[0]
  end

  #--------------------------------------------------------------------------
  # ● F Casting?
  #--------------------------------------------------------------------------             
  def f_casting?
      !@f_cast_data[0].nil?
  end    
  
  #--------------------------------------------------------------------------
  # ● F Reflect
  #--------------------------------------------------------------------------             
  def f_reflect?
      return true if @sprite_data[11][5]
      return false
  end
  
  #--------------------------------------------------------------------------
  # ● F Invunerable?
  #--------------------------------------------------------------------------             
  def f_invunerable?
      return true if @sprite_data[11][4]
      return false
  end  
  
  #--------------------------------------------------------------------------
  # ● F Move Usable?
  #--------------------------------------------------------------------------             
  def f_move_usable?
      @f_move[0]
  end
  
  #--------------------------------------------------------------------------
  # ● F Action Usable?
  #--------------------------------------------------------------------------             
  def f_action_usable?
      @f_e_action[0]
  end
    
  #--------------------------------------------------------------------------
  # ● F Breath Effect?
  #--------------------------------------------------------------------------             
  def f_breath_effect?
      f_breath_effect[0]
  end
  
  #--------------------------------------------------------------------------
  # ● F Guard Usable?
  #--------------------------------------------------------------------------             
  def f_guard_usable?
      @f_guard[0] != 0
  end    
      
  #--------------------------------------------------------------------------
  # ● F Dash Usable?
  #--------------------------------------------------------------------------             
  def f_dash_usable?
      return @f_dash[0]
  end
  
  #--------------------------------------------------------------------------
  # ● F Air Dash Usable?
  #--------------------------------------------------------------------------             
  def f_air_dash_usable?
      return @f_air_dash[0]
  end
  
  #--------------------------------------------------------------------------
  # ● F Jump Usable
  #--------------------------------------------------------------------------             
  def f_jump_usable?
      return @f_jump[0]
  end
  
  #--------------------------------------------------------------------------
  # ● F Double Jump Usable?
  #--------------------------------------------------------------------------             
  def f_dounble_jump_usable?
      return @f_double_jump[0]
  end
  
  #--------------------------------------------------------------------------
  # ● F Crouch Usable?
  #--------------------------------------------------------------------------             
  def f_crouch_usable?
      return @f_crouch[0]
  end
  
  #--------------------------------------------------------------------------
  # ● F Action Freq
  #--------------------------------------------------------------------------             
  def f_action_freq
      return 120
  end
  
  #--------------------------------------------------------------------------
  # ● F Grv Speed
  #--------------------------------------------------------------------------             
  def f_grv_speed
      return @jump_speed
  end
  
  #--------------------------------------------------------------------------
  # ● F Base Jh
  #--------------------------------------------------------------------------             
  def f_jump_height
      return @jump_height
  end
 
  #--------------------------------------------------------------------------
  # ● F Body Width
  #--------------------------------------------------------------------------             
  def f_body_width
      return @sprite_data[12][0]
  end    

  #--------------------------------------------------------------------------
  # ● F Body Width 2
  #--------------------------------------------------------------------------             
  def f_body_width2
      return @sprite_data[12][2]
  end     
  
  #--------------------------------------------------------------------------
  # ● F Height
  #--------------------------------------------------------------------------             
  def f_body_height
      return f_body_height2 if f_mov_crouching?
      return @sprite_data[12][1]
  end
  
  #--------------------------------------------------------------------------
  # ● F Height 2
  #--------------------------------------------------------------------------             
  def f_body_height2
      return @sprite_data[12][3]
  end  
  
  #--------------------------------------------------------------------------
  # ● F Jump Max
  #--------------------------------------------------------------------------             
  def f_jump_max
      return f_ground - f_jump_height
  end
  
  #--------------------------------------------------------------------------
  # ● F Super Guard
  #--------------------------------------------------------------------------             
  def f_super_guard?
      return true if @sprite_data[11][3]
      @f_super_guard[0]
  end
    
end

#==============================================================================
# ■ Game_Battler
#==============================================================================
class Game_Battler < Game_BattlerBase
  
  #--------------------------------------------------------------------------
  # ● F Check Screen XY Limit
  #--------------------------------------------------------------------------             
  def f_check_screen_xy_limit
      @screen_x = (@arena_range[0] + bcx1) if @screen_x < f_limit_x1
      @screen_x = (@arena_range[1] - bcx2) if @screen_x > f_limit_x2
      if @screen_y < -screen_y_limit
         @screen_y = -screen_y_limit
         f_clear_double_jump if f_mov_double_jump?
      end
      @screen_y = f_ground if @screen_y > f_ground
  end
      
  #--------------------------------------------------------------------------
  # ● Bcx1
  #--------------------------------------------------------------------------             
  def bcx1
      return $game_temp.bc_screen_range[0] if !$imported[:mog_battle_camera].nil?
      return 0
  end
  
  #--------------------------------------------------------------------------
  # ● Bcx2
  #--------------------------------------------------------------------------             
  def bcx2
      return $game_temp.bc_screen_range[0] if !$imported[:mog_battle_camera].nil?
      return 0
  end
  
  #--------------------------------------------------------------------------
  # ● Screen Y Limit
  #--------------------------------------------------------------------------             
  def screen_y_limit
      return -f_body_height2 + $game_temp.bc_screen_range[3] if !$imported[:mog_battle_camera].nil?
      return -f_body_height2
  end
  
  #--------------------------------------------------------------------------
  # ● Screen Y Limit2
  #--------------------------------------------------------------------------             
  def screen_y_limit2
  #    return Graphics.height + $game_temp.bc_screen_range[3] if !$imported[:mog_battle_camera].nil?
      return Graphics.height
  end  
  
  #--------------------------------------------------------------------------
  # ● F Limit X1
  #--------------------------------------------------------------------------             
  def f_limit_x1
      (@arena_range[0] + bcx1)
  end
  
  #--------------------------------------------------------------------------
  # ● F Limit X2
  #--------------------------------------------------------------------------             
  def f_limit_x2
      (@arena_range[1] - bcx2)
  end
  
  #--------------------------------------------------------------------------
  # ● F Limit y1
  #--------------------------------------------------------------------------             
  def f_limit_y1
      return -(32 + $game_temp.bc_screen_range[3]) if !$imported[:mog_battle_camera].nil?
      return -32
  end  
  
  #--------------------------------------------------------------------------
  # ● F Ground Limit
  #--------------------------------------------------------------------------             
  def f_ground      
      screen_y_limit2 - $game_system.fmbs_data[1]
  end
  
  #--------------------------------------------------------------------------
  # ● F Ground ?
  #--------------------------------------------------------------------------             
  def f_ground?
      return true if @f_air_ground[0] and $game_system.f_collision_effect[1]
      @screen_y >= f_ground
  end
  
  #--------------------------------------------------------------------------
  # ● F Air Ground H
  #--------------------------------------------------------------------------             
  def f_air_ground_h
      @f_air_ground[1]
  end    
  
  #--------------------------------------------------------------------------
  # ● F Air Ground?
  #--------------------------------------------------------------------------             
  def f_air_ground?
      @screen_y >= @f_air_ground[1]
  end
  
  #--------------------------------------------------------------------------
  # ● F Screen Y Limit?
  #--------------------------------------------------------------------------             
  def screen_y_limit?
      @screen_y <= -screen_y_limit
  end  
    
end

#==============================================================================
# ■ Game_Battler
#==============================================================================
class Game_Battler < Game_BattlerBase
  
  #--------------------------------------------------------------------------
  # ● F Dash?
  #--------------------------------------------------------------------------             
  def f_mov_dashing?
      return false if $game_temp.fmb_phase_data != [0,0]
      return false if !f_movable?
      return false if f_mov_guarding? or f_mov_crouching?
      return false if (f_mov_jumping? and !@sprite_data[5][1])
      return false if @sprite_data[9] == -1
      return @sprite_data[5][0]
  end  
  
  #--------------------------------------------------------------------------
  # ● F Mov Dash
  #--------------------------------------------------------------------------             
  def f_mov_dash
      return if !f_mov_dash_conditions_met?
      @sprite_data[10][0] = false
      @sprite_data[5][0] = true   
  end  
  
  #--------------------------------------------------------------------------
  # ● F Mov Dash Condition Met?
  #--------------------------------------------------------------------------             
  def f_mov_dash_conditions_met?
      return false if !f_dash_usable?
      return false if !f_movable?
      return false if $game_temp.fmb_phase_data != [0,0] 
      return true
  end
    
  #--------------------------------------------------------------------------
  # ● F Move Speed
  #--------------------------------------------------------------------------             
  def f_mov_speed
      return @move_speed
  end  
  
  #--------------------------------------------------------------------------
  # ● F Move Side
  #--------------------------------------------------------------------------             
  def f_mov_side(type)
      return if !f_mov_side_conditions_met?
      @sprite_data[4] = false
      @sprite_data[8] = true unless f_mov_jumping?
      @sprite_data[9] = type
      @sprite_data[3] = type unless f_mov_acting?
      d = type == 0 ? -f_mov_speed : f_mov_speed 
      d *= 1.5 if f_mov_dashing?
      f_move_screen_x(d) unless (!f_mov_jumping? and f_mov_acting?)
      f_update_escape if f_update_escape?
  end
    
  #--------------------------------------------------------------------------
  # ● F Move screen_x
  #--------------------------------------------------------------------------             
  def f_move_screen_x(value)
      return if !f_move_usable?
      @screen_x += value
  end
  
  #--------------------------------------------------------------------------
  # ● F Move screen_x Collision?
  #--------------------------------------------------------------------------             
  def f_move_screen_x_collision?(value)
      return false if !$game_system.f_collision_effect[0]
      for b in f_all_battlers
          next if b == self
          if @screen_x.between?(b.screen_x - b.f_body_width2 - value ,b.screen_x + b.f_body_width2 - value)
             if @screen_y.between?(b.screen_y - (b.f_body_height - 16),b.screen_y) or 
                (@screen_y - f_body_height2 - 16).between?(b.screen_y - (b.f_body_height - 16),b.screen_y) 
                return $game_system.f_collision_effect[1]
             end
          end
      end
      return false
  end  
  
  #--------------------------------------------------------------------------
  # ● F Move screen_x
  #--------------------------------------------------------------------------             
  def f_move_screen_x2(value)
      if !f_move_screen_x_collision2?(value)
          @screen_x += value if !f_move_screen_x_collision2?(value)
      else    
          @sprite_data[9] = -1 
      end  
  end
  
  #--------------------------------------------------------------------------
  # ● F Move screen_x Collision2?
  #--------------------------------------------------------------------------             
  def f_move_screen_x_collision2?(value)
      for b in f_all_battlers
          next if b == self
          next if !b.f_movable?
          if @screen_x.between?(b.screen_x - b.f_body_width2 - value ,b.screen_x + b.f_body_width2 - value)
             return true if @screen_y.between?(b.screen_y - (b.f_body_height - 16),b.screen_y)
             return true if (@screen_y - f_body_height2 - 16).between?(b.screen_y - (b.f_body_height - 16),b.screen_y)
          end
      end
      return false
  end  
  
  
  #--------------------------------------------------------------------------
  # ● F Move screen_y
  #--------------------------------------------------------------------------             
  def f_move_screen_y(value)
      return if !f_move_usable?
      @screen_y += value
  end    
  
  #--------------------------------------------------------------------------
  # ● F Move screen_y Collision?
  #--------------------------------------------------------------------------             
  def f_move_screen_y_collision?(value)
      return false if !$game_system.f_collision_effect[0]
      return false if value < 0 and !$game_system.f_collision_effect[1]
      for b in f_all_battlers
          next if b == self
          next if !b.f_movable?
          if (@screen_y.between?(b.screen_y - (b.f_body_height - 16) - value,b.screen_y - value))# or
             next if !@screen_x.between?(b.screen_x - b.f_body_width2,b.screen_x + b.f_body_width2) 
                f_clear_col(b,value)
                return $game_system.f_collision_effect[1]
           end
      end
      return false
  end    
      
  #--------------------------------------------------------------------------
  # ● F Clear Col
  #--------------------------------------------------------------------------             
  def f_clear_col(b,value)
      unless value < 0 or f_mov_acting?
          d = @sprite_data[3] == 1 ? 4 : -4
          f_move_screen_x(d)
          b.f_move_screen_x(-d) 
          if $game_system.f_collision_effect[1]
          f_clear_air_effects unless (f_flying_type? or f_mov_acting?)
          end
          @f_air_ground[0] = true
          @f_air_ground[1] = f_ground - @screen_y      
      end
      if $game_system.f_collision_effect[1]
         f_clear_jump if f_mov_jumping? and !f_force_movement?
      end     
      @f_fix_direction[0] = true
  end    
  
  #--------------------------------------------------------------------------
  # ● F All Battlers Alive
  #--------------------------------------------------------------------------             
  def f_all_battlers
      $game_party.battle_members + $game_troop.alive_members 
  end
  
  #--------------------------------------------------------------------------
  # ● F Update Escape
  #--------------------------------------------------------------------------             
  def f_update_escape?
      return false if self.is_a?(Game_Enemy)
      return false if !BattleManager.can_escape?
      return false if !f_ground? and !f_flying_type?
      return false if self != BattleManager.active_actor
      return true if f_limit_x1 >= @screen_x and @sprite_data[9] == 0
      return true if f_limit_x2 <= @screen_x and @sprite_data[9] == 1
      return false
  end  
  
  #--------------------------------------------------------------------------
  # ● F Update Escpae
  #--------------------------------------------------------------------------             
  def f_update_escape
      $game_temp.f_escape_phase[1] += 2 
      $game_temp.f_escape_phase[2] = 60
      BattleManager.f_process_escape if $game_temp.f_escape_phase[1] >= f_espace_duration
  end
  
  #--------------------------------------------------------------------------
  # ● F Escape Duration
  #--------------------------------------------------------------------------             
  def f_espace_duration
      return @f_escape_ratio
  end
  
  #--------------------------------------------------------------------------
  # ● F Move Side Condition Met?
  #--------------------------------------------------------------------------             
  def f_mov_side_conditions_met?
      return false if !f_move_usable?
      return false if f_mov_damage?
      return false if $game_temp.fmb_phase_data != [0,0]
      return false if f_mov_guarding?
      return false if f_force_movement?
      return false if f_mov_air_dash?
      return false if f_casting?
      return false if @f_action_time[2] > 0
      return true
  end
  
end

#==============================================================================
# ■ Game_Battler
#==============================================================================
class Game_Battler < Game_BattlerBase
  
  #--------------------------------------------------------------------------
  # ● F Guard Conditions Met?
  #--------------------------------------------------------------------------             
  def f_update_breath_effect
      @f_breath_effect[3] += 1
      return if @f_breath_effect[3] < 2
      @f_breath_effect[3] = 0
      @f_breath_effect[2] += 1
      case @f_breath_effect[2]
        when 0..30 ; @f_breath_effect[1] += @f_breath_effect[4]
        when 31..60 ; @f_breath_effect[1] -= @f_breath_effect[4]
        else
          @f_breath_effect[1] = 0
          @f_breath_effect[2] = 0
      end
  end
  
end

#==============================================================================
# ■ Game_Battler
#==============================================================================
class Game_Battler < Game_BattlerBase
  
  #--------------------------------------------------------------------------
  # ● F Cast Action?
  #--------------------------------------------------------------------------             
  def f_cast_action?(skill,casting)
      return true if !skill_cost_payable?(skill)
      return false if casting
      return false if f_mov_guarding?
      return true if !@f_cast_data[0].nil? 
      return false if skill.speed == 0      
      @f_cast_data = [skill,skill.speed]      
      return true
  end  
    
  #--------------------------------------------------------------------------
  # ● F Update Cast
  #--------------------------------------------------------------------------             
  def f_update_cast?
      return false if !f_movable?
      return false if !$game_temp.f_in_action?
      return f_casting?
  end
  
  #--------------------------------------------------------------------------
  # ● F Update Cast
  #--------------------------------------------------------------------------             
  def f_update_cast
      @f_cast_data[1] -= 1 if @f_cast_data[1] > 0
      f_execute_cast_action if f_execute_cast_action?
  end
  
  #--------------------------------------------------------------------------
  # ● F Execute Cast Action
  #--------------------------------------------------------------------------             
  def f_execute_cast_action?
      return false if @f_cast_data[1] > 0
      return true      
  end  
  
  #--------------------------------------------------------------------------
  # ● F Execute Cast Action
  #--------------------------------------------------------------------------             
  def f_execute_cast_action
      BattleManager.p_target_near(self) if @f_target.nil?
      if self == BattleManager.active_actor
         f_execute_skill_actor(@f_cast_data[0].id,nil,true)
      else
         f_execute_skill_b(@f_cast_data[0].id,nil,true)
      end
      f_cast_clear 
  end
  
  #--------------------------------------------------------------------------
  # ● F Execute Cast Action
  #--------------------------------------------------------------------------             
  def f_cast_clear
      @f_cast_data = [nil,0]
  end
  
end

#==============================================================================
# ■ Game_Battler
#==============================================================================
class Game_Battler < Game_BattlerBase 

  #--------------------------------------------------------------------------
  # ● F Mov Guad
  #--------------------------------------------------------------------------             
  def f_mov_guard
      return if !f_mov_guard_conditions_met?
      @sprite_data[10][0] = true
  end  

  #--------------------------------------------------------------------------
  # ● F Guard Conditions Met?
  #--------------------------------------------------------------------------             
  def f_mov_guard_conditions_met?
      return false if !f_guard_usable?
      return false if f_mov_jumping?
      return false if f_mov_acting?
      return false if !f_movable?
      return false if $game_temp.fmb_phase_data != [0,0]   
      return false if f_force_movement?
      return false if f_casting?
      return true
  end
      
end

#==============================================================================
# ■ Game_Battler
#==============================================================================
class Game_Battler < Game_BattlerBase
  
 #--------------------------------------------------------------------------
 # ● F Update Turn
 #--------------------------------------------------------------------------             
 def f_update_turn
     return if !$game_temp.f_in_action?
     @f_turn_data[0] += 1
     return if @f_turn_data[0] < @f_turn_data[1]
     @f_turn_data[0] = 0     
     f_on_turn_end 
 end
 
 #--------------------------------------------------------------------------
 # ● Remove States Auto
 #--------------------------------------------------------------------------             
 alias mog_fmbs_f_remove_states_auto remove_states_auto
 def remove_states_auto(timing)
     if SceneManager.scene_is?(Scene_Battle)
        states.each do |state|             
             remove_state(state.id) if @state_turns[state.id] == 0 and state.auto_removal_timing != 0
        end
        return
     end
     mog_fmbs_f_remove_states_auto(timing)
 end 
 
 #--------------------------------------------------------------------------
 # ● F On Turn End
 #--------------------------------------------------------------------------
 def f_on_turn_end 
     regenerate_all
     update_state_turns
     update_buff_turns
     remove_states_auto(1)
 end 
 
end

#==============================================================================
# ■ Game_Battler
#==============================================================================
class Game_Battler < Game_BattlerBase
  
  #--------------------------------------------------------------------------
  # ● F Mov Jump
  #--------------------------------------------------------------------------             
  def f_mov_jump
      return if !f_jump_conditions_met?
      @f_air_dash[2] = true unless f_mov_dashing? and !MOG_LMBS::ALLOW_AIR_DASH_DURING_DASH_SPEED
      @f_double_jump[1] = true unless f_mov_dashing? and !MOG_LMBS::ALLOW_DOUBLE_JUMP_DURING_DASH_SPEED
      @sprite_data[1] = 0
      @sprite_data[4] = false
      @sprite_data[5][1] = true if f_mov_dashing?
      @sprite_data[8] = false
      @sprite_data[10][0] = false
      @sprite_data[6] = [true,0,0,false,false,0]
      if f_direction == 0
         @sprite_data[6][1] = 1 if @sprite_data[9] == 0
         @sprite_data[6][1] = 2 if @sprite_data[9] == 1
      else
         @sprite_data[6][1] = 2 if @sprite_data[9] == 0
         @sprite_data[6][1] = 1 if @sprite_data[9] == 1    
      end
  end  

  #--------------------------------------------------------------------------
  # ● F Jump Condition Met?
  #--------------------------------------------------------------------------             
  def f_jump_conditions_met?
      return false if !f_jump_usable?
      return false if !f_ground?
      return false if f_casting?
      return false if !f_air_ground[0] and !f_ground?
      return false if f_mov_guarding?
      return false if f_mov_acting?
      return false if !f_movable?
      return false if f_force_movement?
      return false if @f_double_jump[2]
      return false if $game_temp.fmb_phase_data != [0,0]  
      return true
  end     
      
  #--------------------------------------------------------------------------
  # ● F Update Jump
  #--------------------------------------------------------------------------             
  def f_update_jump
      @sprite_data[4] = false ; @sprite_data[8] = false
      if f_mov_air_dash?
         @sprite_data[6][2] = 1
         return
      end      
      if @sprite_data[6][2] == 0
         f_move_screen_y(-f_grv_speed) unless f_force_movement?
         @sprite_data[6][2] = 1 if f_jump_limit?
      else  
         f_move_screen_y(f_grv_speed) unless f_force_movement?
         @sprite_data[6][3] = true
         if f_ground?
            f_clear_jump 
            f_clear_double_jump
            f_clear_air_action
         end   
      end  
  end
  
  #--------------------------------------------------------------------------
  # ● F Jump Limit?
  #--------------------------------------------------------------------------             
  def f_jump_limit?
      return false if @f_action_m[2] != 0
      return true if @screen_y <= f_jump_max - f_air_ground_h and @f_action_m[2] == 0
      return true if screen_y_limit?
      return false
  end

  #--------------------------------------------------------------------------
  # ● F Clear Jump
  #--------------------------------------------------------------------------             
  def f_clear_jump
      @sprite_data[6] = [false,0,0,false,true,0]
      @sprite_data[5][1] = false
      f_clear_air_dash
  end
  
  #--------------------------------------------------------------------------
  # ● F Clear Air Action
  #--------------------------------------------------------------------------             
  def f_clear_air_action
      return if !f_mov_acting?
      f_action_clear
      @f_action_time[2] = 10 if @f_action_time[2] == 0
      @f_ai_data[2] = 5 if @f_ai_data[2] == 0
  end
    
  #--------------------------------------------------------------------------
  # ● F Update Gravity
  #--------------------------------------------------------------------------             
  def f_update_gravity
      if f_update_flying? ; f_update_flying_gravity ; return ; end
      return if !f_gravity_conditions_met?  
      if @screen_y < f_ground
         f_move_screen_y(f_grv_speed)
         @sprite_data[6][3] = true
         @sprite_data[6][4] = true
         @sprite_data[5][1] = false
         @sprite_data[4] = false
         if @f_knockback[3] > 0 and @f_damage[3]
            d = @f_damage[4] == 0 ? 2 : -2
            d = 0 if @f_damage[4] == 0 and @screen_x < f_limit_x1 + 16
            d = 0 if @f_damage[4] == 1 and @screen_x > f_limit_x2 - 16
            f_move_screen_y(-d)
          end         
          if f_ground? 
             f_clear_air_effects
             f_clear_air_action
          end
          return
      end  
      @sprite_data[6][3] = false
  end
  
  #--------------------------------------------------------------------------
  # ● F Clear Air Effects
  #--------------------------------------------------------------------------             
  def f_clear_air_effects
      f_clear_jump
      f_clear_double_jump
      f_clear_damage if @f_damage[3]
  end    
  
  #--------------------------------------------------------------------------
  # ● F Gravity Conditions Met?
  #--------------------------------------------------------------------------             
  def f_gravity_conditions_met?
      return false if f_mov_jumping?
      return false if f_mov_air_knockback?
      return false if f_force_movement?
      return false if f_mov_air_dash?
      return false if f_mov_double_jump? 
      return false if f_flying_type? and f_mov_acting?
      return true
  end
   
end

#==============================================================================
# ■ Game_Battler
#==============================================================================
class Game_Battler < Game_BattlerBase 

  #--------------------------------------------------------------------------
  # ● F Update Fying?
  #--------------------------------------------------------------------------             
  def f_update_flying?
      return false if !f_flying_type?
      return false if !f_movable?
      return false if f_mov_air_dash?
      return false if f_mov_double_jump?
      return false if f_mov_jumping?
      return false if $game_temp.fmb_phase_end == 4
      return true
  end
  
  #--------------------------------------------------------------------------
  # ● F Fying Height?
  #--------------------------------------------------------------------------             
  def f_flying_height
      f_ground - @f_flying_type[4]
  end
  
  #--------------------------------------------------------------------------
  # ● F Update Flying Gravity
  #--------------------------------------------------------------------------             
  def f_update_flying_gravity
      if @screen_y < f_flying_height
         f_move_screen_y((f_grv_speed / 2))
         @sprite_data[6][3] = true
         @sprite_data[6][4] = true
         @sprite_data[5][1] = false
         @sprite_data[4] = false    
         @screen_y = f_flying_height if @screen_y > f_flying_height
      elsif @screen_y > f_flying_height
         f_move_screen_y(-(f_grv_speed / 2))
         @sprite_data[6][3] = false
         @screen_y = f_flying_height if @screen_y < f_flying_height
      end
  end
  
  #--------------------------------------------------------------------------
  # ● F Update Flying Effect
  #--------------------------------------------------------------------------             
  def f_update_fying_effect      
      if f_ground?
         @f_flying_type[1] = 0
         @f_flying_type[2] = 0
         return
      end         
      return if @f_action_m[2] != 0
      @f_flying_type[3] += 1
      if @f_flying_type[3] > 4
         @f_flying_type[3] = 0
         @f_flying_type[1] += 1
         case @f_flying_type[1]
            when 0..15; @f_flying_type[2] += 1
            when 16..30 ; @f_flying_type[2] -= 1
            else ; @f_flying_type[1] = 0 ; @f_flying_type[2] = 0
         end
      end 
  end  
    
end

#==============================================================================
# ■ Game_Battler
#==============================================================================
class Game_Battler < Game_BattlerBase
    
  #--------------------------------------------------------------------------
  # ● F Mov Air Dash
  #--------------------------------------------------------------------------             
  def f_mov_air_dash
      return if !f_air_dash_conditions_met?
      @f_air_dash[1] = true
      @f_air_dash[3] = 20
      @f_action = [true,nil,MOG_LMBS::AIR_DASH_ANIMATION_ID,nil,0,nil,false,60]
  end
  
  #--------------------------------------------------------------------------
  # ● F Air Dash Condition Met?
  #--------------------------------------------------------------------------             
  def f_air_dash_conditions_met?
      return false if !f_air_dash_usable?
      return false if !f_movable?
      return false if f_casting?
      return false if f_force_movement?
      return false if f_ground? and !f_flying_type?
      return false if @f_air_dash[1] and !f_flying_type?
      return true if f_flying_type?
      return false if !@f_air_dash[2]
      return false if f_mov_dashing? 
      return false if f_mov_double_jump?
      return false if @screen_y > f_ground - (f_jump_height / 3)  
      return true
  end  
    
  #--------------------------------------------------------------------------
  # ● F Mov Air Dash?
  #--------------------------------------------------------------------------             
  def f_mov_air_dash?
      (@f_air_dash[1] and @f_air_dash[3] > 0)
  end
    
  #--------------------------------------------------------------------------
  # ● F Update Air Dash
  #--------------------------------------------------------------------------             
  def f_update_air_dash
      @f_air_dash[3] -= 1
      d = f_direction == 0 ? -f_air_dash_speed : f_air_dash_speed
      f_move_screen_x(d) 
      f_clear_air_dash if @f_air_dash[3] <= 0
  end
  
  #--------------------------------------------------------------------------
  # ● F Air Dash Speed
  #--------------------------------------------------------------------------             
  def f_air_dash_speed
      @move_speed + 6
  end
  
  #--------------------------------------------------------------------------
  # ● F Clear Air Dash
  #--------------------------------------------------------------------------             
  def f_clear_air_dash
      @f_air_dash[1] = false
      @f_air_dash[2] = false
      @f_air_dash[3] = 0
  end  
  
end

#==============================================================================
# ■ Game_Battler
#==============================================================================
class Game_Battler < Game_BattlerBase
  
  #--------------------------------------------------------------------------
  # ● F Mov Double Jump
  #--------------------------------------------------------------------------             
  def f_mov_double_jump
      return if !f_double_jump_conditions_met?
      @f_double_jump[2] = true
      @f_double_jump[3] = 1
      @sprite_data[1] = 0
      @sprite_data[6] = [false,0,0,false,true,0] ; @sprite_data[1] = 0
      @sprite_data[5][1] = false
      @f_action = [true,nil,MOG_LMBS::DOUBLE_JUMP_ANIMATION_ID,nil,0,nil,false,60]
  end  
  
  #--------------------------------------------------------------------------
  # ● F Mov Double Jump Condition Met?
  #--------------------------------------------------------------------------             
  def f_double_jump_conditions_met?
      return false if !f_movable?
      return false if f_casting?
      return false if f_force_movement?
      return false if f_mov_dashing?
      return false if f_ground?
      return false if !f_dounble_jump_usable?
      return false if !@f_double_jump[1]
      return false if @f_double_jump[2] 
      return false if f_mov_air_dash?
      return false if @screen_y > f_ground - (f_jump_height / 4)    
      return true   
  end
  
  #--------------------------------------------------------------------------
  # ● F Mov Double Jump?
  #--------------------------------------------------------------------------             
  def f_mov_double_jump?
      @f_double_jump[3] > 0
  end
  
  #--------------------------------------------------------------------------
  # ● F Clear Air Dash
  #--------------------------------------------------------------------------             
  def f_clear_double_jump
      @f_double_jump[1] = false
      @f_double_jump[2] = false
      @f_double_jump[3] = 0
  end   
 
  #--------------------------------------------------------------------------
  # ● F Update Double Jump
  #--------------------------------------------------------------------------             
  def f_update_double_jump
      @sprite_data[4] = false ; @sprite_data[8] = false
      @f_double_jump[3] += 1
      f_move_screen_y(-f_grv_speed) unless @f_action_m[2] != 0
      @sprite_data[6][3] = false
      return if @f_double_jump[3] < (f_jump_height / 8)
      f_clear_double_jump
  end
  
end

#==============================================================================
# ■ Game_Battler
#==============================================================================
class Game_Battler < Game_BattlerBase
  
  #--------------------------------------------------------------------------
  # ● F Update Action
  #--------------------------------------------------------------------------             
  def f_update_action
      @f_action[7] -= 1 if @f_action[7] > 0
      if (f_flying_type? and @f_action[1].is_a?(RPG::Skill) and @f_action[1].id == attack_skill_id)
         f_update_flying_attack
      end
      return if @sprite_data[11][0].nil?
      @sprite_data[11][1] -= 1
      if @sprite_data[11][1] <= 0
         @sprite_data[1] = 0 
         f_action_clear
      end
  end  
  
  #--------------------------------------------------------------------------
  # ● F Update Fying Attack
  #--------------------------------------------------------------------------             
  def f_update_flying_attack
      f_face_to_target
      f_execute_move(0,@screen_x,@f_target.screen_x)
      f_execute_move(1,@screen_y,@f_target.screen_y - (@f_target.f_body_height2 / 2))
  end
 
  #--------------------------------------------------------------------------
  # ● Execute Move
  #--------------------------------------------------------------------------      
  def f_execute_move(type,cp,np)
      sp = 2
      if cp > np ;    cp -= sp ; cp = np if cp < np
      elsif cp < np ; cp += sp ; cp = np if cp > np
      end     
      @screen_x = cp if type == 0 ; @screen_y = cp if type == 1
  end  
  
  #--------------------------------------------------------------------------
  # ● F Action Clear
  #--------------------------------------------------------------------------
  def f_action_clear
      skill = @f_action[1] if !@f_action.nil?
      @f_action = [false,nil,0,nil,0,nil,false,0]       
      @f_action_m = [false,0,0,0]
      @sprite_data[11] = [nil,0,0,false,false,false]
      @sprite_data[1] = 0
      @sprite_data[13] = 2
      @f_ai_data[2] = 10
      @f_a_target = nil     
      clear_actions if !@actions.nil?
      f_execute_chain_action(skill) if f_execute_chain_action?(skill)
      BattleManager.p_target_near(self) rescue nil
  end     

  #--------------------------------------------------------------------------
  # ● F Execute Chain Action
  #--------------------------------------------------------------------------
  def f_execute_chain_action?(skill)
      return false if skill.nil?
      return false if !f_movable?
      return true
  end  
  
  #--------------------------------------------------------------------------
  # ● F Execute Skill Command
  #--------------------------------------------------------------------------             
  def f_execute_skill_command
      if Input.press?(:UP)
         sk1 = $data_skills[@f_equipped_skill[6]] rescue nil
         f_execute_skill_actor(@f_equipped_skill[6]) if !sk1.nil? and f_aerial_skill_usable?($data_skills[@f_equipped_skill[6]])
      elsif Input.press?(:RIGHT) or Input.press?(:LEFT)
         sk1 = $data_skills[@f_equipped_skill[1]] rescue nil
         sk2 = $data_skills[@f_equipped_skill[4]] rescue nil     
         f_execute_skill_actor(@f_equipped_skill[1]) if !sk1.nil? and f_ground_skill_usable?($data_skills[@f_equipped_skill[1]])
         f_execute_skill_actor(@f_equipped_skill[4]) if !sk2.nil? and f_aerial_skill_usable?($data_skills[@f_equipped_skill[4]])
      elsif Input.press?(:DOWN)
         sk1 = $data_skills[@f_equipped_skill[2]] rescue nil
         sk2 = $data_skills[@f_equipped_skill[5]] rescue nil        
         f_execute_skill_actor(@f_equipped_skill[2]) if !sk1.nil? and f_ground_skill_usable?($data_skills[@f_equipped_skill[2]])
         f_execute_skill_actor(@f_equipped_skill[5]) if !sk2.nil? and f_aerial_skill_usable?($data_skills[@f_equipped_skill[5]])
      else
         sk1 = $data_skills[@f_equipped_skill[0]] rescue nil
         sk2 = $data_skills[@f_equipped_skill[3]] rescue nil
         f_execute_skill_actor(@f_equipped_skill[0]) if !sk1.nil? and f_ground_skill_usable?($data_skills[@f_equipped_skill[0]])
         f_execute_skill_actor(@f_equipped_skill[3]) if !sk2.nil? and f_aerial_skill_usable?($data_skills[@f_equipped_skill[3]])
      end
  end
    
  #--------------------------------------------------------------------------
  # ● F Execute Attack Skill
  #--------------------------------------------------------------------------             
  def f_execute_attack_skill
      if BattleManager.active_actor == self
         f_execute_skill_actor(attack_skill_id)
      else 
         f_execute_skill_b(attack_skill_id)
      end
  end
  
  #--------------------------------------------------------------------------
  # ● F Skill Usable?
  #--------------------------------------------------------------------------             
  def f_skill_usable?(skill)
      return false if !f_action_usable?
      return true if self == BattleManager.active_actor
      return true if skill.id == attack_skill_id
      return true if f_ground_skill_usable?(skill)
      return true if f_aerial_skill_usable?(skill)
      return false
  end  
  
  #--------------------------------------------------------------------------
  # ● F Ground Skill Usable?
  #--------------------------------------------------------------------------             
  def f_ground_skill_usable?(skill)
      return false if skill.nil?
      return false if !f_ground?
      return false if f_flying_type?
      return true if skill.note =~ /<F Skill Type = All>/
      return true if skill.note =~ /<F Skill Type = Ground>/      
      return false
  end

  #--------------------------------------------------------------------------
  # ● F Aerial
  #--------------------------------------------------------------------------             
  def f_aerial_skill_usable?(skill)
      return false if skill.nil?
      return false if @screen_y > f_ground - (f_jump_height / 4)  
      return true if skill.note =~ /<F Skill Type = All>/
      return true if skill.note =~ /<F Skill Type = Aerial>/      
      return false
  end  
    
  #--------------------------------------------------------------------------
  # ● F Execute Skill Actor
  #--------------------------------------------------------------------------             
  def f_execute_skill_actor(skill_id,target = nil,casting = false)
      return if !f_action_usable?
      skill = $data_skills[skill_id] rescue nil
      return if skill.nil?
      return if f_cast_action?(skill,casting)
      type = skill.is_a?(RPG::Skill) ? 0 : 1
      if [2,3,4,5,6,8,10].include?(skill.scope)
         BattleManager.f_execute_action(BattleManager.active_actor,skill) if f_execute_skill_conditions_met?(skill,type)
      elsif (skill.note =~ /<F Auto Target>/ or skill.note =~ /<F Auto Target Area>/) and f_execute_skill_conditions_met?(skill,type) 
         $game_temp.fmb_menu_phase = [true,3,true]
         $game_temp.f_cursor_data[1] = skill     
         trg = skill.for_opponent? ? 0 : 1
         BattleManager.cursor_next_target(0,trg)
      else   
         f_execute_skill(skill_id,target)
      end
  end
  
  #--------------------------------------------------------------------------
  # ● F Execute Skill B
  #--------------------------------------------------------------------------             
  def f_execute_skill_b(skill_id,target = nil,casting = false)
      return if !f_action_usable?
      skill = $data_skills[skill_id] rescue nil
      @f_action_freq[4] = 0
      return if skill.nil?
      return if f_cast_action?(skill,casting)
      f_face_to_target
      type = skill.is_a?(RPG::Skill) ? 0 : 1
      if (skill.note =~ /<F Auto Target>/ or skill.note =~ /<F Auto Target Area>/) or [2,3,4,5,6,8,10].include?(skill.scope)
         BattleManager.f_execute_action(self,skill) if f_execute_skill_conditions_met?(skill,type) 
      else
         f_execute_skill(skill_id,target)
      end  
  end  
    
  #--------------------------------------------------------------------------
  # ● F Execute SKill
  #--------------------------------------------------------------------------             
  def f_execute_skill(skill_id,pr_target = nil,type = 0)  
      skill = $data_skills[skill_id] rescue nil if type == 0
      skill = $data_items[skill_id] rescue nil if type == 1
      BattleManager.p_target_near(self) if @f_target.nil?
      return if !f_skill_usable?(skill)
      return if !f_execute_skill_conditions_met?(skill,type)
      return if item_weapon?(skill) and equips[0].nil?      
      pay_skill_cost(skill) if type == 0
      pay_item_cost(skill) if type == 1 and !skill.key_item?
      f_action_clear
      f_clear_air_dash if f_mov_air_dash?
      f_set_action_data(skill,pr_target,type)
  end  
  
  #--------------------------------------------------------------------------
  # ● F Set Action Data
  #--------------------------------------------------------------------------             
  def f_set_action_data(skill,pr_target,type)
      f_set_action(skill.id)
      @sprite_data[10][0] = false
      @sprite_data[5][0] = false    
      @sprite_data[1] = 0
      item = skill
      item = equips[0] if item_weapon?(skill) and !equips[0].nil?
      duration = item.note =~ /<F Duration = (\d+)>/ ? $1.to_i : 60
      duration = 999 if duration > 999
      pose_duration = item.note =~ /<F Pose Duration = (\d+)>/ ? $1.to_i : 20
      pose_duration = 999 if pose_duration > 999
      pose_index = item.note =~ /<F Pose Index = (\d+)>/ ? $1.to_i : skill.id
      force_pose = item.note =~ /<F Super Guard>/ ? true : false
      invn = item.note =~ /<F Invunerable>/ ? true : false
      refl = item.note =~ /<F Reflect>/ ? true : false
      @sprite_data[11] = [skill,pose_duration,pose_index,force_pose,invn,refl]
      @f_action_time[0] = true unless item.note =~ /<F Chain Action = (\d+)>/
      if item.note =~ /<F User Move = x\s*(\-*\d+)\s* y\s*(\-*\d+)\s*>/
         xd = f_direction == 0 ? -$1.to_i : $1.to_i
         yd = $2.to_i
         @sprite_data[6] = [true,0,0,false,false,0] if yd > 0
         skill_type = item.note =~ /<F Skill Type = Aerial>/ ? 1 : 0
         @f_action_m = [true,xd,-yd,skill_type]
         @sprite_data[6][2] = 1 if skill_type == 1
       end
       loop = item.note =~ /<F Loop Pose>/ ? true : false
       pr_target = @f_a_target if !@f_a_target.nil?
       @f_action = [true,skill,0,pr_target,type,nil,loop,duration]
  end
     
  #--------------------------------------------------------------------------
  # ● Item Weapon
  #--------------------------------------------------------------------------             
  def item_weapon?(skill)
      return false if skill.nil?
      return false if self.is_a?(Game_Enemy)
      return false if skill.is_a?(RPG::Item)
      return false if skill.id != attack_skill_id
      return true
  end    
      
  #--------------------------------------------------------------------------
  # ● F Execute SKill Condition Met?
  #--------------------------------------------------------------------------             
  def f_execute_skill_conditions_met?(skill,type)
      return false if @f_action_time[0] and !f_flying_type?
      return false if skill.nil?
      return false if @f_target.nil?
      return false if f_mov_acting?
      return false if !f_movable?
      return false if $game_temp.fmb_phase_data != [0,0]
      return false if $game_temp.battle_end
      return false if f_mov_guarding?
      if type == 0 and !skill_cost_payable?(skill)
         Sound.play_mp_cost
         return false
      end
      return true
  end
  
  #--------------------------------------------------------------------------
  # ● Pay Item Cost
  #--------------------------------------------------------------------------             
  def pay_item_cost(item)
      $game_party.lose_item(item, 1)
  end
    
 #--------------------------------------------------------------------------
 # ● F Update Force Move
 #--------------------------------------------------------------------------             
 def f_update_force_move
     if @f_action[7] == 0
        @f_action_m = [false,0,0]
        @f_action_time[2] = @sprite_data[11][1] + 2
     end
     f_move_screen_x(@f_action_m[1])
     f_move_screen_y(@f_action_m[2])
     f_clear_jump if f_mov_jumping?
     if f_ground? and @f_action_m[3] == 1
        @f_action_time[2] = 10 if @f_action_time[2] == 0
        f_clear_jump
        f_action_clear        
    end
 end
 
end

#==============================================================================
# ■ Game_Battler
#==============================================================================
class Game_Battler < Game_BattlerBase
  
  #--------------------------------------------------------------------------
  # ● Update Fmbs Battler Damage
  #--------------------------------------------------------------------------             
  def f_update_fmbs_battler_damage
      @f_damage[0] -= 1 
      @f_damage[2] -= 1
      @f_damage[7] -= 1
      f_execute_knockback if f_execute_knokback?
      return if @f_damage[0] > 0 
      return if @f_knockback[3] > 0
      f_clear_damage
  end
  
  #--------------------------------------------------------------------------
  # ● F Clear Damage
  #--------------------------------------------------------------------------             
  def f_clear_damage
      @f_damage = [0,nil,0,false,0,1,7,0,0,0]
      @f_knockback[2] = 1
      @f_ai_data[2] = 4 unless f_mov_guarding?
  end  
      
  #--------------------------------------------------------------------------
  # ● F_execute Knockback?
  #--------------------------------------------------------------------------             
  def f_execute_knokback?
      return false if !f_move_usable?
      return false if !@f_knockback[0]
      return false if @f_damage[7] <= 0
      return false if !@f_damage[3]
      return false if @f_guard[1]
      return true
  end
    
  #--------------------------------------------------------------------------
  # ● F Execute Knockback
  #--------------------------------------------------------------------------             
  def f_execute_knockback
      d = @f_damage[4] == 0 ? @f_damage[5] : -@f_damage[5] 
      d = 0 if @f_damage[4] == 0 and @screen_x < f_limit_x1 + 16
      d = 0 if @f_damage[4] == 1 and @screen_x > f_limit_x2 - 16
      if @f_damage[7] > @f_damage[8]
         f_move_screen_x(-d)
         f_move_screen_y(-@f_damage[6])
      else   
         f_move_screen_y(-f_grv_speed / 2)
         if @f_knockback[3] > 0
            f_move_screen_x(-d)
         else   
            f_move_screen_x(-(d * 2))
         end
      end       
  end
 
  #--------------------------------------------------------------------------
  # ● Item Apply
  #--------------------------------------------------------------------------             
  alias mog_fmbs_item_apply item_apply
  def item_apply(user, item)
      return if f_invunerable?
      return if $game_temp.battle_end
      de = dead?
      mog_fmbs_item_apply(user, item)
      if @result.hit? and $game_system.fmbs_data[0] and SceneManager.scene_is?(Scene_Battle)
         @f_char_data[3] = true if de != dead? and @f_char_data[0]
         execute_target_animation(user, item)
         f_execute_dmg_dead_effect(user,item) if dead?
         @f_cast_data = [nil,0] if dead? or restriction >= 4
         @animation_id = $1.to_i if item.note =~ /<F Hit Animation = (\d+)>/
         if f_execute_knockback?(user,item)
            f_execute_dmg_effect(user,item)
            @f_action[1] = nil
            f_action_clear
            f_clear_jump if f_mov_jumping?
            f_clear_air_dash if f_mov_air_dash?
            f_clear_double_jump if f_mov_double_jump?
            if item.note =~ /<F Knockback Stun>/
               @f_knockback[3] = 90
               @f_damage[5] = 2
               @f_damage[6] = 5 + f_grv_speed               
               @f_knockback[3] = @f_damage[0] if @f_knockback[3] < @f_damage[0]
               $game_temp.f_actor_cursor_d = 90 if self == BattleManager.active_actor
            end   
            @f_damage[3] = true if !@f_guard[1]
         end
      end
  end

  #--------------------------------------------------------------------------
  # ● F Execute DMG Dead Effect
  #--------------------------------------------------------------------------             
  def f_execute_dmg_dead_effect(user,item)
      BattleManager.p_target_near(user) if self == user.f_target
      BattleManager.next_actor_index(1) if self == BattleManager.active_actor
      @f_action[1] = nil
      f_action_clear
      f_clear_jump if f_mov_jumping?
      f_clear_air_dash if f_mov_air_dash?
      f_clear_double_jump if f_mov_double_jump?
      if self.is_a?(Game_Enemy)
         perform_collapse_effect
      else   
         Sound.play_actor_collapse
      end  
      if user.is_a?(Game_Actor)
         $game_party.battle_members.each do |bt|
         next if bt == user  
         BattleManager.p_target_near(bt) ; end
      else
         $game_troop.alive_members.each do |bt|
         next if bt == user  
         BattleManager.p_target_near(bt) ; end
      end
  end
 
  #--------------------------------------------------------------------------
  # ● F Execute Knockback
  #--------------------------------------------------------------------------             
  def f_execute_knockback?(user,item)
      return false if !f_move_usable?
      return false if !@f_knockback[0]
      return false if !item.damage.to_hp?
      return false if @result.hp_damage <= 0
      return false if f_super_guard?
      return false if f_casting?
      return false if item.note =~ /<F Disable Knockback>/
      return true
  end
  
  #--------------------------------------------------------------------------
  # ● F Update Fmbs Battler Inv Duration
  #--------------------------------------------------------------------------             
  def f_update_fmbs_battler_inv_duration
      @f_knockback[1] -= 1 if @f_knockback[1] > 0
      @f_knockback[2] -= 1 if @f_knockback[2] > 0
      if @f_knockback[3] > 0
         @f_knockback[3] -= 1 
         @f_knockback[2] = 5 if @f_knockback[3] == 0
         @f_ai_data[2] = 4 if @f_knockback[3] == 0
      end   
      update_knockback_guard if @f_knockback[4] > 0
  end
  
  #--------------------------------------------------------------------------
  # ● F Update Knockback Guard
  #--------------------------------------------------------------------------             
  def update_knockback_guard
      @f_knockback[4] -= 1 
      return false if !f_move_usable?
      d = @f_damage[4] == 0 ? 2 : -2
      d = 0 if @f_damage[4] == 0 and @screen_x < f_limit_x1 + 16
      d = 0 if @f_damage[4] == 1 and @screen_x > f_limit_x2 - 16
      f_move_screen_x(-d)
  end
  
  #--------------------------------------------------------------------------
  # ● F Execute Dmg Effect
  #--------------------------------------------------------------------------             
  def f_execute_dmg_effect(user,item)
  end   
   
  #--------------------------------------------------------------------------
  # ● Execute Target Animation
  #-------------------------------------------------------------------------- 
  def execute_target_animation(user, item)
      self.animation_id = @f_damage[9] if @f_damage[9] > 0
  end   
  
end

#==============================================================================
# ■ Game_Battler
#==============================================================================
class Game_Battler < Game_BattlerBase
  
  #--------------------------------------------------------------------------
  # ● F Update Fmbs Battler Effect
  #--------------------------------------------------------------------------             
  def f_update_fmbs_battler_effect
      @f_damage_effect[2] += 1

  end    
  
end

#==============================================================================
# ■ Game_Battler
#==============================================================================
class Game_Battler < Game_BattlerBase

  #--------------------------------------------------------------------------
  # ● F update Ai
  #--------------------------------------------------------------------------             
  def f_update_ai?
     # return false if self.is_a?(Game_Actor)
     # return false if self.is_a?(Game_Enemy)
      return false if @f_ai_data[2] > 0
      return false if self == BattleManager.active_actor
      return false if @f_target.nil?
      return false if !f_movable?
      return false if f_mov_acting?
      return false if $game_temp.battle_end
      return false if !$game_temp.f_in_action?
      return true
  end  

  #--------------------------------------------------------------------------
  # ● F Update AI
  #--------------------------------------------------------------------------             
  def f_update_ai
      f_update_ai_basic_data
      f_update_ai_guard
      f_update_ai_movement if f_update_ai_movement?
  end
  
  #--------------------------------------------------------------------------
  # ● F Update AI Basic Data
  #--------------------------------------------------------------------------             
  def f_update_ai_basic_data
      @f_ai_data[0] -= 1 if @f_ai_data[0] > 0
      @f_ai_data[1] -= 1 if @f_ai_data[1] > 0  
  end
      
end

#==============================================================================
# ■ Game_Battler
#==============================================================================
class Game_Battler < Game_BattlerBase

  #--------------------------------------------------------------------------
  # ● F Update Ai Guard
  #--------------------------------------------------------------------------             
  def f_update_ai_guard?
      return false if f_target.f_direction == f_direction
      return f_target.f_mov_acting?
  end
  
  #--------------------------------------------------------------------------
  # ● F Update Ai guard
  #--------------------------------------------------------------------------             
  def f_update_ai_guard
      @f_ai_guard[3] -= 1 if @f_ai_guard[3] > 0
      if f_update_ai_guard?
         f_set_guard
         if @f_ai_guard[0]
            f_face_to_target
            f_mov_guard
         end
       else  
         @f_ai_guard[0] = false ;  @f_ai_guard[2] = false
      end
  end
  
  #--------------------------------------------------------------------------
  # ● F Set Guard
  #--------------------------------------------------------------------------             
  def f_set_guard
      return if @f_ai_guard[2]
      @f_ai_guard[2] = true
      @f_ai_guard[0] = rand(100) <= @f_ai_guard[1] ? true : false
      @f_ai_guard[0] = false if f_ai_guard_exception?
  end
  
  #--------------------------------------------------------------------------
  # ● F Ai Guarc Exception?
  #--------------------------------------------------------------------------             
  def f_ai_guard_exception?
      return true if @f_ai_guard[1] <= 0
      return true if !f_on_target_range?(f_distance_dash)
      return true if f_direction == f_target.f_direction
      return false
  end
      
end

#==============================================================================
# ■ Game_Battler
#==============================================================================
class Game_Battler < Game_BattlerBase

  #--------------------------------------------------------------------------
  # ● F Update AI
  #--------------------------------------------------------------------------             
  def f_update_ai_movement      
      if !f_flying_type? and f_mov_jumping? and @screen_y.between?(f_target.screen_y - f_target.f_body_height, f_target.screen_y)
         type = f_ground? ? 0 : 1 
         skill_id = f_set_action_id(type)
         f_execute_skill_b(skill_id) if !skill_id.nil?        
      end
      f_ai_update_action
      case @f_ai_data[3][0]
        when 0 ; f_ai_move_random
        when 1 ; f_ai_move_to_target
      end
  end
 
  #--------------------------------------------------------------------------
  # ● F Update AI Movement?
  #--------------------------------------------------------------------------             
  def f_update_ai_movement?
      return false if @f_ai_data[0] > 0
      return false if f_mov_guarding?
      return true      
  end  
  
  #--------------------------------------------------------------------------
  # ● F Face To Target
  #--------------------------------------------------------------------------             
  def f_face_to_target
      return if !f_move_usable?
      @sprite_data[3] = @f_target.screen_x > @screen_x ? 1 : 0
  end  
  
  #--------------------------------------------------------------------------
  # ● F On Target Range
  #--------------------------------------------------------------------------             
  def f_on_target_range?(range)
      range += 32 if @f_target.f_body_width <= 32
      return false if f_distance_x > range
      return true 
  end
  
  #--------------------------------------------------------------------------
  # ● F Distance Dash
  #--------------------------------------------------------------------------             
  def f_distance_dash
      240
  end
  
  #--------------------------------------------------------------------------
  # ● F Distance X
  #--------------------------------------------------------------------------             
  def f_distance_x
      (@f_target.screen_x - @screen_x).abs
  end
    
  #--------------------------------------------------------------------------
  # ● F Distance Y
  #--------------------------------------------------------------------------             
  def f_distance_y
      (@f_target.screen_y - @screen_y).abs
  end    
    
end

#==============================================================================
# ■ Game_Battler
#==============================================================================
class Game_Battler < Game_BattlerBase  

  #--------------------------------------------------------------------------
  # ● F A.I Move To Target
  #--------------------------------------------------------------------------             
  def f_ai_move_to_target
      f_face_to_target      
      if f_move_to_target?
         f_mov_dash if !f_on_target_range?(f_distance_dash)
         f_mov_side(@sprite_data[3])
      else
         @f_ai_data[3][0] = 0
         @f_ai_data[3][1] = 0
         @f_ai_data[3][2] = 2
      end  
  end  
  
  #--------------------------------------------------------------------------
  # ● F Move To Target?
  #--------------------------------------------------------------------------             
  def f_move_to_target?
      return true if !f_on_target_range?(@f_target.f_body_width2 + 16)
      return false
  end
    
end

#==============================================================================
# ■ Game_Battler
#==============================================================================
class Game_Battler < Game_BattlerBase
  
  #--------------------------------------------------------------------------
  # ● F Update AI Random
  #--------------------------------------------------------------------------             
  def f_ai_move_random
      @f_ai_data[3][1] += 1
      @f_ai_data[3][1] = 0 if @f_ai_data[3][1] > @f_action_freq[0]
      f_ai_set_random_move if @f_ai_data[3][1] == 0
      f_ai_forward_random
  end
      
  #--------------------------------------------------------------------------
  # ● F AI Set Random Move
  #--------------------------------------------------------------------------             
  def f_ai_set_random_move
      f_face_to_target
      @f_ai_data[3][2] = rand(4)
      @f_ai_data[3][3] += 1
      if @f_ai_data[3][3] > @f_action_freq[1]
         @f_ai_data[3][3] = 0 
         @f_ai_data[3][0] = 1
         BattleManager.p_target_near(self)
         f_face_to_target
      end
  end  

  #--------------------------------------------------------------------------
  # ● F Ai Forward Random
  #--------------------------------------------------------------------------             
  def f_ai_forward_random
      unless @f_ai_data[3][2] >= 2
        f_mov_dash if !f_on_target_range?(f_distance_dash)
        f_mov_side(@f_ai_data[3][2])
      end  
      if (@screen_x <= f_limit_x1 or @screen_x >= f_limit_x2)
          f_face_to_target
          @f_ai_data[3][1] = @f_action_freq[0]
      end    
  end
  
end

#==============================================================================
# ■ Game_Battler
#==============================================================================
class Game_Battler < Game_BattlerBase
  
  #--------------------------------------------------------------------------
  # ● F Ai Update Action
  #--------------------------------------------------------------------------             
  def f_ai_update_action
      @f_action_freq[4] += 1
      return if @f_action_freq[4] < @f_action_freq[5]
      @f_action_freq[4] = 0
      f_ai_prepare_action
  end
  
  #--------------------------------------------------------------------------
  # ● F AI Prepare Action
  #--------------------------------------------------------------------------             
  def f_ai_prepare_action
      f_face_to_target
      if !f_flying_type? and f_jump_usable? and @f_target.screen_y < (f_ground - @f_target.f_body_height)
         lskill = f_set_skill_type
         unless (lskill == @revive_list or lskill == @recover_list)
           f_mov_jump
           return
         end
      end
      type = f_ground? ? 0 : 1
      if f_on_target_range?(@f_target.f_body_width + 16)
         skill_id = f_set_action_id(type)
         if skill_id.nil?
            if f_jump_usable?
               f_mov_jump if @f_target.screen_y < (f_ground - (@f_target.f_body_height + 24))
            else
               return if @f_target.screen_y < (f_ground - (@f_target.f_body_height + 24))
            end             
            f_execute_skill_b(attack_skill_id)
         else  
            f_atk = rand(100)
            skid = f_atk < 70 ? skill_id : attack_skill_id
            f_execute_skill_b(skid)
         end
      else    
         skill_id = f_set_action_id(type)
         f_execute_skill_b(skill_id) if !skill_id.nil?           
      end
  end

  #--------------------------------------------------------------------------
  # ● F Set Action ID
  #--------------------------------------------------------------------------             
  def f_set_action_id(type)
      action_list = f_set_skill_type
      return nil if action_list.empty?
      r_list = []
      action_list.each do |s| r_list.push(s) if f_usable_action?(s,type) end
      return nil if r_list.empty?
      if self.is_a?(Game_Enemy)
         action_list = enemy.actions.select {|a| action_valid?(a)}
         new_r_list = []
         action_list.sort! {|a,b| b.rating - a.rating }
         action_list.each do |s|
               skill = $data_skills[s.skill_id]
               if r_list.include?(skill)
                  new_r_list.push(skill)
                  return skill.id if rand(10) < s.rating
               end   
         end
         r_list = new_r_list
      end
      return nil if r_list.empty?
      sk = rand(r_list.size)
      return r_list[sk].id
  end       
  
end

#==============================================================================
# ■ Game_Battler
#==============================================================================
class Game_Battler < Game_BattlerBase

  #--------------------------------------------------------------------------
  # ● F Make Skill List
  #--------------------------------------------------------------------------             
  def f_make_skill_list
      @skill_list = []
      if self.is_a?(Game_Enemy)
         enemy.actions.each do |e|
            next if e.nil? 
            next if e.skill_id == 0           
            @skill_list.push($data_skills[e.skill_id]) 
         end
      else   
         @f_equipped_skill.each do |e|
            next if e.nil? 
            next if e == 0
            @skill_list.push($data_skills[e]) 
         end
         @skill_list.push($data_skills[attack_skill_id])
      end     
      f_make_type_list
  end
  
  #--------------------------------------------------------------------------
  # ● F Make Type List
  #--------------------------------------------------------------------------             
  def f_make_type_list
      @normal_list = []
      @recover_list = []
      @revive_list = [] 
      @skill_list.each do |s|
         rev = false
         s.effects.each do |e|            
             if (e.code == 22 and e.data_id == death_state_id)          
                @revive_list.push(s)
                rev = true
              end  
          end
          next if rev
          if s.damage.type == 3
             @recover_list.push(s)                
          else
             @normal_list.push(s)
          end              
      end
  end
  
  #--------------------------------------------------------------------------
  # ● F Make Type List
  #--------------------------------------------------------------------------             
  def f_set_skill_type
      n_recover = false ; n_revive = false
      if self.is_a?(Game_Actor)
         allies_targets = $game_party.battle_members 
      else
         allies_targets = $game_troop.alive_members
      end        
      allies_targets.each do |b|
          n_revive = true if b.dead?
          n_recover = true if !b.dead? and b.hp <= b.mhp * 40 / 100          
      end
      return @revive_list if !@revive_list.empty? and n_revive 
      return @recover_list if !@recover_list.empty? and n_recover
      return @normal_list
  end
    
end

#==============================================================================
# ■ Game_Battler
#==============================================================================
class Game_Battler < Game_BattlerBase
  
  #--------------------------------------------------------------------------
  # ● F Usable Action?
  #--------------------------------------------------------------------------             
  def f_usable_action?(skill,type)
      return false if skill.nil?
      return false if !skill_cost_payable?(skill)
      return true if skill.note =~ /<F Auto Target Area>/
      return true if skill.note =~ /<F Auto Target>/
      unless (skill.id == attack_skill_id or skill.id <= 0)
          return false if skill.note =~ /<F Skill Type = Aerial>/ and type == 0
          return false if skill.note =~ /<F Skill Type = Ground>/ and type == 1
      end
      return false if !f_target_in_range?(skill,type)
      return true
  end
  
  #--------------------------------------------------------------------------
  # ● F Skill Range
  #--------------------------------------------------------------------------             
  def f_skill_range(item)
      sp = [0,0] ; sr = [@screen_x,@screen_y,0,0] ; d = 60
      if item.note =~ /<F Duration = (\d+)>/
         d = $1.to_i ; d = 999 if d > 999
      end
      d -= 5 ; d = 1 if d < 1
       if item.note =~ /<F Move Speed = x\s*(\-*\d+)\s* y\s*(\-*\d+)\s*>/         
         dx = @sprite_data[3] == 0 ? -$1.to_i : $1.to_i
         dy = $2.to_i
         pr = [d * dx,d * dy]
         sr[0] += pr[0]
         sr[1] += pr[1]
         sr[2] = $1.to_i.abs
         sr[3] = $2.to_i.abs
      elsif item.note =~ /<F User Move = x\s*(\-*\d+)\s* y\s*(\-*\d+)\s*>/
         dx = @sprite_data[3] == 0 ? -$1.to_i : $1.to_i
         dy = $2.to_i
         pr = [d * dx,d * dy]
         sr[0] += pr[0]
         sr[1] += -pr[1]
         sr[2] = $1.to_i.abs
         sr[3] = $2.to_i.abs        
      end   
      return sr    
  end  
  
  #--------------------------------------------------------------------------
  # ● Target In Range
  #--------------------------------------------------------------------------             
  def f_target_in_range?(skill,type)
      return false if !skill_cost_payable?(skill)
      item = skill
      item = self.equips[0] if item_weapon?(skill) and !self.equips[0].nil?
      # Around --------------------------------------------------------------
      if (@screen_x.between?(f_target.screen_x - f_target.f_body_width,f_target.screen_x + f_target.f_body_width) and
         @screen_y.between?(f_target.screen_y - f_target.f_body_height,f_target.screen_y + f_target.f_body_height2))
         return true
      end  
      # ---------------------------------------------------------------------
      br = f_skill_range(item) ; sr = [0,0,0,0] ; f_range = [0,0,0,0]
      if br[1].between?(@screen_y - 64,@screen_y)
      if br[0] >= @screen_x and f_target.screen_x.between?(@screen_x, br[0]) and
         f_target.screen_y.between?(@screen_y - f_body_height,@screen_y)
         return true
      elsif br[0] < @screen_x and f_target.screen_x.between?(br[0],@screen_x) and
         f_target.screen_y.between?(@screen_y - f_body_height,@screen_y)
         return true
      end     
     end
      if br[0].between?(@screen_x - f_body_width,@screen_x + f_body_width)
      if br[1] >= @screen_y and f_target.screen_y.between?(@screen_y + 16, br[1] + f_target.f_body_height) and
         f_target.screen_x.between?(@screen_x - f_body_width2, @screen_x + f_body_width2)
         return true
      elsif br[1] < @screen_y and f_target.screen_y.between?(br[1] + 16, @screen_y + f_target.f_body_height) and
         f_target.screen_x.between?(@screen_x - f_body_width2, @screen_x + f_body_width2)
         return true
      end   
      end
      if item.note =~ /<F Area = \s*(\-*\d+)\s* - \s*(\-*\d+)\s* - \s*(\-*\d+)\s* - \s*(\-*\d+)\s*>/
         f_range = [$1.to_i.abs,$2.to_i.abs,$3.to_i.abs,$4.to_i.abs]  
      end   
      
      if @sprite_data[3] == 0
         sr[0] = f_target.screen_x - (f_target.f_body_width2 + f_range[1])
         sr[1] = f_target.screen_x + (f_target.f_body_width2 + f_range[0])
      else
         sr[0] = f_target.screen_x - (f_target.f_body_width2 + f_range[0])
         sr[1] = f_target.screen_x + (f_target.f_body_width2 + f_range[1])
      end  
      sr[2] = f_target.screen_y + f_range[2] 
      sr[3] = f_target.screen_y - (f_target.f_body_height + f_range[3])
      
      # B Start & End ---------------------------------------------
      index_range = 0
      5.times do 
        index_range += 1
        xr = br[0] / index_range
        yr = br[1] / index_range
        return true if xr.between?(sr[0],sr[1]) and yr.between?(sr[3] - 16,sr[2])
      end  
      return false
      # -----------------------------------------------------------
  
      # B Real ---------------------------------------------------
      return false if !br[0].between?(sr[0],sr[1])
      unless (f_flying_type? and item.is_a?(RPG::Skill) and item.id == attack_skill_id)
         return false if !br[1].between?(sr[3] - 32,sr[2] + 32)
      end     
      return true
      # -----------------------------------------------------------
  end      
  
end

#==============================================================================
# ■ Game Enemy
#==============================================================================
class Game_Enemy < Game_Battler
  
  #--------------------------------------------------------------------------
  # ● Initialize
  #--------------------------------------------------------------------------             
  alias mog_fmbs_initialize initialize
  def initialize(index, enemy_id)
      mog_fmbs_initialize(index, enemy_id)
      set_fmbs_initial_parameters(enemy)
  end
  
end

#==============================================================================
# ■ Game Actor
#==============================================================================
class Game_Actor < Game_Battler
  
  attr_accessor :screen_x
  attr_accessor :screen_y
  
  #--------------------------------------------------------------------------
  # ● Setup
  #--------------------------------------------------------------------------             
  alias mog_fmbs_setup setup
  def setup(actor_id)
      mog_fmbs_setup(actor_id)
      @screen_x = 0 ; @screen_y = 0 
      set_fmbs_initial_parameters(actor)
  end
  
  #--------------------------------------------------------------------------
  # ● Use Sprite?
  #--------------------------------------------------------------------------             
  def use_sprite?
      return true
  end
  
  #--------------------------------------------------------------------------
  # ● Screen Z
  #--------------------------------------------------------------------------             
  def screen_z
      return 110
  end  
    
  #--------------------------------------------------------------------------
  # ● Perform Collapse Effect
  #--------------------------------------------------------------------------             
  def perform_collapse_effect
      if $game_party.in_battle
         Sound.play_actor_collapse
      end
  end  
  
end

#==============================================================================
# ■ Scene Battle
#==============================================================================
class Scene_Battle < Scene_Base
  
  #--------------------------------------------------------------------------
  # ● Battle Start
  #--------------------------------------------------------------------------             
  alias mog_fmbs_battle_start battle_start
  def battle_start
      if $game_system.fmbs_data[0] ; setup_fmbs_initial ; return ; end
      mog_fmbs_battle_start
  end
  
  #--------------------------------------------------------------------------
  # ● Battle Start
  #--------------------------------------------------------------------------             
  def setup_fmbs_initial
      @f_turn_phase = [0,MOG_LMBS::TURN_DURATION]
      if $game_party.members.empty?
         if $BTEST
            BattleManager.process_abort
            return
         end   
         $game_party.on_battle_end
         $game_troop.on_battle_end
         BattleManager.replay_bgm_and_bgs         
         SceneManager.return
         return
      end
      $game_temp.f_actor_cursor_d = 120
      $game_temp.battle_end = false
      $game_party.on_battle_start
      $game_troop.on_battle_start    
      $game_system.f_turn_data = [0,MOG_LMBS::STATES_TURN_DURATION,0]
      BattleManager.next_actor_index(0)
      $game_temp.f_fmbs_clear 
      $game_temp.fmb_phase_end = 0
      @spriteset.battler_sprites.each do |battler|
           next if battler.battler.nil?
           battler.battler.set_initial_f_data
           battler.battler.set_equip_data
           battler.battler.sprite_data[3] = 1 if battler.battler.is_a?(Game_Actor)
           battler.battler.screen_y = battler.battler.f_ground if battler.battler.f_mov_unconscious?
           battler.battler.f_sprite_fade = [false,0]
           battler.battler.f_make_skill_list
           battler.battler.f_target = $game_troop.alive_members[0] if battler.battler.is_a?(Game_Actor)
           battler.battler.f_target = BattleManager.active_actor if battler.battler.is_a?(Game_Enemy)
      end
      process_event
      BattleManager.judge_win_loss
  end
  
  #--------------------------------------------------------------------------
  # ● Terminate
  #--------------------------------------------------------------------------             
  alias mog_fmbs_scenebattle_terminate terminate
  def terminate 
      mog_fmbs_scenebattle_terminate
      $game_party.battle_members.each do |battler| battler.set_initial_f_data end
      $game_temp.fmb_phase_end = 0
  end  
  
  #--------------------------------------------------------------------------
  # ● Actor
  #--------------------------------------------------------------------------             
  def actor
      return BattleManager.active_actor
  end
  
  #--------------------------------------------------------------------------
  # ● Update Basic
  #--------------------------------------------------------------------------             
  alias mog_fmbs_update update
  def update
      update_fmbs_turn if update_fmbs_turn?
      if $game_system.fmbs_data[0] ; update_basic ; return ; end
      mog_fmbs_update
  end
  
  #--------------------------------------------------------------------------
  # ● Update Basic
  #--------------------------------------------------------------------------             
  alias mog_fmbs_update_basic update_basic
  def update_basic
      update_fmbs_update if $game_system.fmbs_data[0] 
      mog_fmbs_update_basic
  end
  
  #--------------------------------------------------------------------------
  # ● Update FMBS Update
  #--------------------------------------------------------------------------             
  def update_fmbs_update
      if $game_temp.fmb_menu_phase[0]
         update_fmbs_menu_phase
      else
         update_fmbs_commands if update_fmbs_basic_commands?
         update_fmbs_system
      end
  end
  
  #--------------------------------------------------------------------------
  # ● Update FMBS Basic Commands?
  #--------------------------------------------------------------------------             
  def update_fmbs_basic_commands?
      return false if !$game_temp.f_in_action?
      return false if actor.nil?
      return false if actor.restriction != 0
      return false if $game_temp.fmb_phase_data[1] > 0
      return false if $game_temp.fmb_phase_data[0] != 0
      return true
  end
  
  #--------------------------------------------------------------------------
  # ● Update FMBS Commands
  #--------------------------------------------------------------------------             
  def update_fmbs_commands
      if Input.trigger?(MOG_LMBS::MENU_BUTTON)
         f_active_menu if f_active_menu?
      else
         update_fmbs_com_dash
         update_fmbs_com_guard
         update_fmbs_com_attack
         update_fmbs_com_skills
         update_fmbs_com_movement
      end
  end
  
  #--------------------------------------------------------------------------
  # ● Update FMBS Com Attack
  #--------------------------------------------------------------------------             
  def update_fmbs_com_attack
      actor.f_execute_attack_skill if Input.trigger?(MOG_LMBS::ATTACK_BUTTON)  
  end
  
  #--------------------------------------------------------------------------
  # ● Update FMBS Com Skills
  #--------------------------------------------------------------------------             
  def update_fmbs_com_skills
      actor.f_execute_skill_command if Input.trigger?(MOG_LMBS::SKILL_BUTTON)  
  end
  
  #--------------------------------------------------------------------------
  # ● Update FMBS Com Guard
  #--------------------------------------------------------------------------             
  def update_fmbs_com_guard
      actor.f_mov_guard if Input.press?(MOG_LMBS::GUARD_BUTTON)    
  end
  
  #--------------------------------------------------------------------------
  # ● Update Fmbs Com Dash
  #--------------------------------------------------------------------------             
  def update_fmbs_com_dash
       actor.f_mov_air_dash if Input.trigger?(MOG_LMBS::DASH_BUTTON)
       actor.f_mov_dash if Input.press?(MOG_LMBS::DASH_BUTTON)
  end
  
  #--------------------------------------------------------------------------
  # ● Update FMBS System
  #--------------------------------------------------------------------------             
  def update_fmbs_system
      return if $game_temp.battle_end
      $game_temp.f_escape_phase[1] -= 1 if $game_temp.f_escape_phase[1] > 0
      update_fmbs_phase_temp if $game_temp.fmb_phase_data[1] > 0
  end
  
  #--------------------------------------------------------------------------
  # ● Update FMBS Phase Temp
  #--------------------------------------------------------------------------             
  def update_fmbs_phase_temp
      $game_temp.fmb_phase_data[1] -= 1
      return if $game_temp.fmb_phase_data[1] > 0
      if $game_temp.fmb_phase_data[0] == 1
          BattleManager.f_targets.each do |sprite|
              next if sprite.battler.nil?
              next if sprite.battler.dead?
              sprite.battler.f_clear_poses
              sprite.battler.f_action_clear
          end          
         $game_temp.battle_end = true ; BattleManager.judge_win_loss
      end   
  end
  
  #--------------------------------------------------------------------------
  # ● Update FMBS Com Movement
  #--------------------------------------------------------------------------             
  def update_fmbs_com_movement
      update_fmbs_next_actor
      if Input.press?(:DOWN) 
         actor.f_move(0)
      else
         if Input.press?(:LEFT)
            actor.f_move(2)       
         elsif Input.press?(:RIGHT)
            actor.f_move(3)
         end
         actor.f_mov_double_jump if Input.trigger?(:UP) 
         actor.f_move(1) if Input.press?(:UP) 
      end  
  end
  
  #--------------------------------------------------------------------------
  # ● Update FMBS Next Actor
  #--------------------------------------------------------------------------             
  def update_fmbs_next_actor
      if Input.trigger?(:L)
         actr = BattleManager.active_actor 
         Sound.play_cursor
         BattleManager.next_actor_index(-1)
         next_actor_effect if actr != BattleManager.active_actor 
       elsif Input.trigger?(:R)
         actr = BattleManager.active_actor 
         Sound.play_cursor  
         BattleManager.next_actor_index(1)
         next_actor_effect if actr != BattleManager.active_actor 
      end  
  end  
  
  #--------------------------------------------------------------------------
  # ● Next Actor Effect
  #--------------------------------------------------------------------------             
  def next_actor_effect    
  end
  
end

#==============================================================================
# ■ Game Troop
#==============================================================================
class Game_Troop < Game_Unit

  #--------------------------------------------------------------------------
  # ● Execute Process Event?
  #--------------------------------------------------------------------------         
  def execute_process_event?
      return true if $game_temp.common_event_reserved?
      return false if @interpreter.running?      
      return false if @interpreter.setup_reserved_common_event
      troop.pages.each do |page|
         next unless conditions_met?(page)
         @current_page = page
         return true
      end    
      return false
    end  
    
end
  
#==============================================================================
# ■ Scene Battle
#==============================================================================
class Scene_Battle < Scene_Base

 #--------------------------------------------------------------------------
 # ● Update FMBS turn
 #--------------------------------------------------------------------------             
 def update_fmbs_turn
     @f_turn_phase[0] += 1
     return if @f_turn_phase[0] < @f_turn_phase[1]
     @f_turn_phase[0] = 0
     $game_troop.increase_turn
     return if !$game_troop.execute_process_event?
     @spriteset.battler_sprites.each do |battler|
           next if battler.battler.nil?
           battler.battler.f_action[1] = nil
           battler.battler.f_action_clear
           battler.fmbs_skills_clear
     end     
     process_event
 end
   
 #--------------------------------------------------------------------------
 # ● Update FMBS turn?
 #--------------------------------------------------------------------------             
 def update_fmbs_turn?
     return false if @f_turn_phase.nil?
     return false if actor.nil?
     return false if $game_temp.fmb_menu_phase[0]
     return false if !$game_temp.f_in_action?
     return false if $game_troop.interpreter.running?
     return true
 end
 
end

#==============================================================================
# ■ Scene Battle
#==============================================================================
class Scene_Battle < Scene_Base
  
  #--------------------------------------------------------------------------
  # ● Create All Window
  #--------------------------------------------------------------------------             
  alias mog_fmbs_create_all_windows create_all_windows
  def create_all_windows
      mog_fmbs_create_all_windows
      create_fmbs_window
      create_fmbs_actor_skill_window  
      create_fmbs_status_skill_window
  end
  
  #--------------------------------------------------------------------------
  # ● Create All Window
  #--------------------------------------------------------------------------             
  def create_fmbs_window
      @fmbs_window = Fmbs_Window.new
    # @fmbs_window.set_handler(:f_skill_window, method(:f_active_window_skill))
      @fmbs_window.set_handler(:f_item_window, method(:f_active_window_item))
      @fmbs_window.set_handler(:f_equip_skill, method(:f_equip_skill))
    # @fmbs_window.set_handler(:f_change_target, method(:f_change_target))
  end
 
  #--------------------------------------------------------------------------
  # ● Create FMBS Actor Skill
  #--------------------------------------------------------------------------             
  def create_fmbs_actor_skill_window
      @fmbs_actor_skill_window = F_Actor_Skill_Window.new(@help_window)
      wd = Graphics.width - @fmbs_actor_skill_window.width
      @fmbs_skill_list_window = F_ESkill_List_Window.new(@help_window,@fmbs_actor_skill_window.width,@fmbs_actor_skill_window.y,wd,@fmbs_actor_skill_window.height)
  end
  
  #--------------------------------------------------------------------------
  # * Create Status Window
  #--------------------------------------------------------------------------
  def create_fmbs_status_skill_window
      @f_status_window = Window_SkillStatus.new(0,0)
      @f_status_window.z = 300
      @f_status_window.y = Graphics.height - @f_status_window.height
      @f_status_window.width = Graphics.width
      @f_status_window.actor = BattleManager.active_actor
      @f_status_window.visible = false
  end    
  
  #--------------------------------------------------------------------------
  # ● F Active Menu?
  #--------------------------------------------------------------------------             
  def f_active_menu?
      return false if !actor.f_movable?
      return false if actor.f_casting?
      return true
  end
  
  #--------------------------------------------------------------------------
  # ● F Active Menu
  #--------------------------------------------------------------------------             
  def update_fmbs_menu_phase
      $game_temp.f_actor_cursor_d = 120
      case $game_temp.fmb_menu_phase[1]
         when 0 ; update_menu_selection
         when 1 ; update_skill_selection
         when 2 ; update_item_selection
         when 3 ; update_target_selection_skill
         when 4 ; update_target_selection_item
         when 5 ; update_equip_skill
         when 6 ; update_equip_skill_2
         when 7 ; update_change_target
      end
  end

  #--------------------------------------------------------------------------
  # ● Update Menu Selection
  #--------------------------------------------------------------------------             
  def update_menu_selection
      if Input.trigger?(:B)   
         $game_temp.fmb_menu_phase = [false,0,false]
         @fmbs_window.end
         @f_status_window.hide
      elsif Input.trigger?(:L)
         Sound.play_cursor
         BattleManager.next_actor_index(-1)
         @f_status_window.actor = BattleManager.active_actor
      elsif Input.trigger?(:R)
         Sound.play_cursor  
         BattleManager.next_actor_index(1)
         @f_status_window.actor = BattleManager.active_actor
      end
  end
  
  #--------------------------------------------------------------------------
  # ● CM Picture Visible?
  #--------------------------------------------------------------------------             
  if $imported[:actor_picture_cm]
  alias mog_fmbs_can_cm_picture_visible? can_cm_picture_visible?
  def can_cm_picture_visible?
      return false if $game_system.fmbs_data[0]
      mog_fmbs_can_cm_picture_visible?
  end
  end

  #--------------------------------------------------------------------------
  # ● F Change Target
  #--------------------------------------------------------------------------
  def f_change_target
      $game_temp.fmb_menu_phase[1] = 7
      BattleManager.cursor_next_target(0,0)
      @fmbs_window.end
  end
  
  #--------------------------------------------------------------------------
  # ● Update Change Target
  #--------------------------------------------------------------------------
  def update_change_target
      if Input.trigger?(:B)
         $game_temp.fmb_menu_phase = [true,0,false]
         @fmbs_window.start
         @fmbs_window.select(3)   
       elsif Input.trigger?(:C)
         BattleManager.active_actor.f_target = $game_temp.f_cursor_target
         BattleManager.f_clear_command_selection
       else   
         if Input.trigger?(:LEFT) or Input.trigger?(:UP)
            BattleManager.cursor_next_target(-1,0) 
         elsif Input.trigger?(:RIGHT) or Input.trigger?(:DOWN)
            BattleManager.cursor_next_target(1,0) 
         end           
         
      end   
  end
  
end

#==============================================================================
# ■ Window BattleSkill
#==============================================================================
class Window_BattleSkill < Window_SkillList
  
  #--------------------------------------------------------------------------
  # ● Include?
  #--------------------------------------------------------------------------             
  alias mog_fmbs_include? include?
  def include?(item)
      if $game_system.fmbs_data[0] and SceneManager.scene_is?(Scene_Battle)
         return false if item.nil?
         return true if item.note =~ /<F Skill Type = All>/
         return true if item.note =~ /<F Skill Type = Ground>/
         return true if item.note =~ /<F Skill Type = Aerial>/ 
         return false
      end
      mog_fmbs_include?(item)
  end
  
  #--------------------------------------------------------------------------
  # ● Enable?
  #--------------------------------------------------------------------------             
  alias mog_fmbs_enable? enable?
  def enable?(item)
      if $game_system.fmbs_data[0] and SceneManager.scene_is?(Scene_Battle)
         return false if @actor.nil?
         return false if !@actor.usable?(item)
         return false if @actor.f_casting?
         return false if !@actor.f_movable?
         return true if @actor.f_ground_skill_usable?(item)
         return true if @actor.f_aerial_skill_usable?(item)
         return false
      end
      mog_fmbs_enable?(item)
  end
  
end

#==============================================================================
# ■ Scene Battle
#==============================================================================
class Scene_Battle < Scene_Base
  
  
  #--------------------------------------------------------------------------
  # ● Update Skill Selection
  #--------------------------------------------------------------------------             
  def update_skill_selection
      if Input.trigger?(:B)
         $game_temp.fmb_menu_phase = [true,0,false]
         @fmbs_window.start
         @fmbs_window.select(0)
      end   
  end    
  
  #--------------------------------------------------------------------------
  # ● F Active Menu
  #--------------------------------------------------------------------------             
  def f_active_menu
      $game_temp.fmb_menu_phase = [true,0,false]
      @fmbs_window.start
      @f_status_window.actor = BattleManager.active_actor
      @f_status_window.refresh
      @f_status_window.show
      Sound.play_ok
  end
  
  #--------------------------------------------------------------------------
  # ● On Skill Cancel
  #--------------------------------------------------------------------------             
  alias mog_fmbs_on_skill_cancel on_skill_cancel
  def on_skill_cancel
      if $game_system.fmbs_data[0]
         @skill_window.visible = false
         @skill_window.active = false
         @skill_window.help_window.hide
         @fmbs_window.start
         @fmbs_window.select(0)
         $game_temp.fmb_menu_phase = [true,0,false]         
         return
      end
      mog_fmbs_on_skill_cancel
  end
  
  #--------------------------------------------------------------------------
  # ● On Skill OK
  #--------------------------------------------------------------------------             
  alias mog_fmbs_on_skill_ok on_skill_ok
  def on_skill_ok
      if $game_system.fmbs_data[0]
         @skill_window.visible = false
         @skill_window.active = false
         @skill_window.help_window.hide
         item = @skill_window.item rescue nil
         return if item.nil?
         type = item.for_opponent? ? 0 : 1
         if BattleManager.active_actor.f_cast_action?(item,false)
            BattleManager.f_clear_command_selection
            return
         end
         if [2,3,4,5,6,8,10].include?(item.scope)
             $game_temp.f_cursor_data[1] = item
             BattleManager.f_execute_action(BattleManager.active_actor,item)
             BattleManager.f_clear_command_selection if !BattleManager.active_actor.f_force_action[0].nil?
         elsif (item.note =~ /<F Auto Target>/ or item.note =~ /<F Auto Target Area>/)
            $game_temp.fmb_menu_phase[1] = 3
            $game_temp.f_cursor_data[1] = @skill_window.item           
            type = item.for_opponent? ? 0 : 1
            BattleManager.cursor_next_target(0,type)     
         else
            type = item.is_a?(RPG::Skill) ? 0 : 1   
            BattleManager.active_actor.f_execute_skill(item.id,nil,type)
            BattleManager.f_clear_command_selection
         end   
         return
      end
      mog_fmbs_on_skill_ok
  end
  
  #--------------------------------------------------------------------------
  # ● Update Target Selection Skill
  #--------------------------------------------------------------------------             
  def update_target_selection_skill
      if Input.trigger?(:B)
         Sound.play_cancel
         if $game_temp.fmb_menu_phase[2]
            BattleManager.f_clear_command_selection
         else        
            @skill_window.visible = true
            @skill_window.active = true
            @skill_window.help_window.show
            $game_temp.fmb_menu_phase[1] = 1
            $game_temp.f_cursor_target = nil
            $game_temp.f_cursor_data = [nil,nil]
         end
       elsif Input.trigger?(:C)
          Sound.play_cursor
          BattleManager.f_execute_action(BattleManager.active_actor,$game_temp.f_cursor_data[1])
          BattleManager.f_clear_command_selection if !BattleManager.active_actor.f_force_action[0].nil?
      else
         if Input.trigger?(:LEFT) or Input.trigger?(:UP)
            item = $game_temp.f_cursor_data[1]
            type = item.for_opponent? ? 0 : 1
            BattleManager.cursor_next_target(-1,type) 
         elsif Input.trigger?(:RIGHT) or Input.trigger?(:DOWN)
            item = $game_temp.f_cursor_data[1]
            type = item.for_opponent? ? 0 : 1
            BattleManager.cursor_next_target(1,type) 
         end        
      end    
  end  
  
  #--------------------------------------------------------------------------
  # ● F Active Window Skill
  #--------------------------------------------------------------------------             
  def f_active_window_skill
      $game_temp.fmb_menu_phase[1] = 1
      @fmbs_window.end
      command_skill
  end 
  
end

#==============================================================================
# ■ Window BattleItem
#==============================================================================
class Window_BattleItem < Window_ItemList
  
  #--------------------------------------------------------------------------
  # ● Actor
  #--------------------------------------------------------------------------             
  def actor
      BattleManager.active_actor
  end
  
  #--------------------------------------------------------------------------
  # ● Enable?
  #--------------------------------------------------------------------------             
  alias mog_fmbs_item_enable? enable?
  def enable?(item)
      if $game_system.fmbs_data[0]
         return false if actor.nil?
         return false if !actor.usable?(item)
         return false if actor.f_casting?
         return false if !actor.f_movable?
         return true if actor.f_ground_skill_usable?(item)
         return true if actor.f_aerial_skill_usable?(item)
         return false
      end
      mog_fmbs_item_enable?
  end
  
end

#==============================================================================
# ■ Scene Battle
#==============================================================================
class Scene_Battle < Scene_Base
  
  #--------------------------------------------------------------------------
  # ● F Active Window Item
  #--------------------------------------------------------------------------             
  def f_active_window_item
      $game_temp.fmb_menu_phase[1] = 2
      @fmbs_window.end
      @f_status_window.hide
      command_item
  end  
 
  #--------------------------------------------------------------------------
  # ● Update Item Selection
  #--------------------------------------------------------------------------             
  def update_item_selection
      if Input.trigger?(:B)
         $game_temp.fmb_menu_phase = [true,0,false]
         @fmbs_window.start
         @f_status_window.show
         @fmbs_window.select(0)
      end   
  end  
  
  #--------------------------------------------------------------------------
  # ● On Item Cancel
  #--------------------------------------------------------------------------             
  alias mog_fmbs_on_item_cancel on_item_cancel
  def on_item_cancel
      if $game_system.fmbs_data[0]
         @item_window.visible = false
         @item_window.active = false
         @item_window.help_window.hide
         @fmbs_window.start
         @fmbs_window.select(0)
         @f_status_window.actor = BattleManager.active_actor
         @f_status_window.show
         $game_temp.fmb_menu_phase = [true,0,false]
         return
      end
      mog_fmbs_on_item_cancel
  end  
  
  #--------------------------------------------------------------------------
  # ● On Item OK
  #--------------------------------------------------------------------------             
  alias mog_fmbs_on_item_ok on_item_ok
  def on_item_ok
      if $game_system.fmbs_data[0]
         @item_window.visible = false
         @item_window.active = false
         @item_window.help_window.hide
         item = @item_window.item rescue nil
         return if item.nil?
         type = item.is_a?(RPG::Skill) ? 0 : 1
         if [2,3,4,5,6,8,10].include?(item.scope)
             $game_temp.f_cursor_data[1] = item
             BattleManager.f_execute_action(BattleManager.active_actor,item)
             BattleManager.f_clear_command_selection if !BattleManager.active_actor.f_force_action[0].nil?
         elsif (item.note =~ /<F Auto Target>/ or item.note =~ /<F Auto Target Area>/)
            $game_temp.fmb_menu_phase[1] = 4
            $game_temp.f_cursor_data[1] = @item_window.item
            trg = item.for_opponent? ? 0 : 1
            BattleManager.cursor_next_target(0,trg)
          else
            BattleManager.active_actor.f_execute_skill(item.id,nil,type)
            BattleManager.f_clear_command_selection                   
         end
         return
      end
      mog_fmbs_on_item_ok
  end  
  
  #--------------------------------------------------------------------------
  # ● Update Target Selection Item
  #--------------------------------------------------------------------------             
  def update_target_selection_item
      if Input.trigger?(:B)
         Sound.play_cancel
         if $game_temp.fmb_menu_phase[2]
            BattleManager.f_clear_command_selection
         else
            @item_window.visible = true
            @item_window.active = true  
            @item_window.refresh
            @item_window.help_window.show
            $game_temp.fmb_menu_phase[1] = 2
            $game_temp.f_cursor_target = nil
            $game_temp.f_cursor_data = [nil,nil]
         end   
       elsif Input.trigger?(:C)
            Sound.play_cursor
            BattleManager.f_execute_action(BattleManager.active_actor,$game_temp.f_cursor_data[1])
            BattleManager.f_clear_command_selection if !BattleManager.active_actor.f_force_action[0].nil?
       else   
         if Input.trigger?(:LEFT) or Input.trigger?(:UP)
            item = $game_temp.f_cursor_data[1]
            type = item.for_opponent? ? 0 : 1
            BattleManager.cursor_next_target(-1,type) 
         elsif Input.trigger?(:RIGHT) or Input.trigger?(:DOWN)
            item = $game_temp.f_cursor_data[1]
            type = item.for_opponent? ? 0 : 1
            BattleManager.cursor_next_target(1,type) 
         end   
      end    
  end    
  
end

#==============================================================================
# ■ Scene Battle
#==============================================================================
class Scene_Battle < Scene_Base
  
  #--------------------------------------------------------------------------
  # ● F Equip Skill
  #--------------------------------------------------------------------------             
  def f_equip_skill
      $game_temp.fmb_menu_phase[1] = 5
      f_equip_start
      @fmbs_window.end
  end

  #--------------------------------------------------------------------------
  # ● F Equip Start
  #--------------------------------------------------------------------------             
  def f_equip_start
      @fmbs_skill_list_window.actor = BattleManager.active_actor
      @fmbs_actor_skill_window.actor = BattleManager.active_actor
      @f_status_window.actor = BattleManager.active_actor
      @fmbs_skill_list_window.refresh
      @fmbs_actor_skill_window.update_help
      @f_status_window.refresh
      @f_status_window.visible = true
      @fmbs_skill_list_window.active = false  
  end    
  
  #--------------------------------------------------------------------------
  # ● F Update Equip Skill
  #--------------------------------------------------------------------------             
  def update_equip_skill
      skill_type = @fmbs_actor_skill_window.index < 3 ? 0 : 1
      update_fmbs_next_actor
      f_equip_start if @fmbs_actor_skill_window.actor != BattleManager.active_actor
      if skill_type != @fmbs_skill_list_window.stype_id
         @fmbs_skill_list_window.stype_id = skill_type
         @fmbs_skill_list_window.index = 0
         @fmbs_skill_list_window.refresh
      end
      if Input.trigger?(:B)
         $game_temp.fmb_menu_phase = [true,0,false]
         @fmbs_window.start
         @fmbs_window.select(1)
         @fmbs_actor_skill_window.hide
         @fmbs_skill_list_window.hide
         Sound.play_cancel
      elsif Input.trigger?(:C)   
         @fmbs_actor_skill_window.active = false
         @fmbs_skill_list_window.active = true
         $game_temp.fmb_menu_phase[1] = 6
         Sound.play_ok
      end      
  end
  
  #--------------------------------------------------------------------------
  # ● F Update Equip Skill 2
  #--------------------------------------------------------------------------             
  def update_equip_skill_2
      if Input.trigger?(:B)
         @fmbs_actor_skill_window.active = true
         @fmbs_skill_list_window.active = false
         $game_temp.fmb_menu_phase[1] = 5
         Sound.play_cancel
       elsif Input.trigger?(:C)  
         skill_id =  @fmbs_skill_list_window.item.id rescue nil
         if !skill_id.nil?
            BattleManager.active_actor.f_equipped_skill[@fmbs_actor_skill_window.index] = skill_id 
            BattleManager.active_actor.f_make_skill_list
            @fmbs_actor_skill_window.refresh
         end   
         Sound.play_equip
         @fmbs_actor_skill_window.active = true
         @fmbs_skill_list_window.active = false
         $game_temp.fmb_menu_phase[1] = 5         
      end
  end
    
end

#==============================================================================
# ■ F_ESkill_List_Window
#==============================================================================
class F_ESkill_List_Window < Window_Selectable
  
    attr_accessor :stype_id
  #--------------------------------------------------------------------------
  # * Object Initialization
  #--------------------------------------------------------------------------
  def initialize(help_window,x, y, width, height)
    super(x, y, width, height)
    @actor = nil
    @stype_id = 0
    @data = []
    @help_window = help_window
    self.z = 300
    self.visible = false
    self.active = false
    refresh
  end
  #--------------------------------------------------------------------------
  # * Set Actor
  #--------------------------------------------------------------------------
  def actor=(actor)
      @actor = actor
      show
  end  
  
  #--------------------------------------------------------------------------
  # * Set Skill Type ID
  #--------------------------------------------------------------------------
  def stype_id=(stype_id)
    return if @stype_id == stype_id
    @stype_id = stype_id
    refresh
    self.oy = 0
  end
  #--------------------------------------------------------------------------
  # * Get Digit Count
  #--------------------------------------------------------------------------
  def col_max
    return 1
  end
  #--------------------------------------------------------------------------
  # * Get Number of Items
  #--------------------------------------------------------------------------
  def item_max
    @data ? @data.size : 1
  end
  #--------------------------------------------------------------------------
  # * Get Skill
  #--------------------------------------------------------------------------
  def item
    @data && index >= 0 ? @data[index] : nil
  end
  #--------------------------------------------------------------------------
  # * Get Activation State of Selection Item
  #--------------------------------------------------------------------------
  def current_item_enabled?
    enable?(@data[index])
  end
  #--------------------------------------------------------------------------
  # * Include in Skill List? 
  #--------------------------------------------------------------------------
  def include?(item)
      return false if item.nil?
      return false if @stype_id == 0 and !@actor.nil? and @actor.f_flying_type?
      return true if item.note =~ /<F Skill Type = All>/
      return true if item.note =~ /<F Skill Type = Ground>/ and @stype_id == 0
      return true if item.note =~ /<F Skill Type = Aerial>/ and @stype_id == 1
      return false
  end
  #--------------------------------------------------------------------------
  # * Display Skill in Active State?
  #--------------------------------------------------------------------------
  def enable?(item)
      return false if @actor.nil?
      return false if !@actor.skill_cost_payable?(item)
      return true
  end
 
  #--------------------------------------------------------------------------
  # * Create Skill List
  #--------------------------------------------------------------------------
  def make_item_list
    @data = @actor ? @actor.skills.select {|skill| include?(skill) } : []
  end
  #--------------------------------------------------------------------------
  # * Restore Previous Selection Position
  #--------------------------------------------------------------------------
  def select_last
    select(@data.index(@actor.last_skill.object) || 0)
  end
  #--------------------------------------------------------------------------
  # * Draw Item
  #--------------------------------------------------------------------------
  def draw_item(index)  
      skill = @data[index]
      if skill
        rect = item_rect(index)
        rect.width -= 4
        draw_item_name(skill, rect.x, rect.y, enable?(skill))
        draw_skill_cost(rect, skill)
      end
  end
  #--------------------------------------------------------------------------
  # * Draw Skill Use Cost
  #--------------------------------------------------------------------------
  def draw_skill_cost(rect, skill)
      if @actor.skill_tp_cost(skill) > 0
        change_color(tp_cost_color, enable?(skill))
        draw_text(rect, @actor.skill_tp_cost(skill), 2)
      elsif @actor.skill_mp_cost(skill) > 0
        change_color(mp_cost_color, enable?(skill))
        draw_text(rect, @actor.skill_mp_cost(skill), 2)
      end
  end
  #--------------------------------------------------------------------------
  # * Update Help Text
  #--------------------------------------------------------------------------
  def update_help
    @help_window.set_item(item)
  end
  #--------------------------------------------------------------------------
  # * Refresh
  #--------------------------------------------------------------------------
  def refresh
      create_contents
      make_item_list
      self.contents.font.size = 20
      self.contents.font.bold = true        
      draw_all_items
    end
    
  #--------------------------------------------------------------------------
  # ● Refresh
  #--------------------------------------------------------------------------
  def show
      return if @actor.nil?
      @help_window.show
      self.active = true
      self.visible = true
      self.index = 0
      @stype_id = 0
      refresh
  end
  
  #--------------------------------------------------------------------------
  # ● Hide
  #--------------------------------------------------------------------------
  def hide
      @help_window.hide
      self.active = false
      self.visible = false
      self.index = -1
  end  

end

#==============================================================================
# ■ F Actor Skill Window
#==============================================================================
class F_Actor_Skill_Window < Window_Selectable
  include MOG_LMBS
  attr_accessor :actor
  
  #--------------------------------------------------------------------------
  # ● Object Initialization
  #--------------------------------------------------------------------------
  def initialize(help_window)
      y = help_window.height
      super(0,y,296,200)
      @help_window = help_window
      @actor = nil
      @data = []  
      self.z = 300
      self.visible = false
      self.active = false   
      $game_party.on_battle_start
  end
  
  #--------------------------------------------------------------------------
  # ● Set Actor
  #--------------------------------------------------------------------------
  def actor=(actor)
      @actor = actor
      show 
  end  
  
  #--------------------------------------------------------------------------
  # ● Get Digit Count
  #--------------------------------------------------------------------------
  def col_max
    return 1
  end
 
  #--------------------------------------------------------------------------
  # ● Item Max
  #--------------------------------------------------------------------------
  def item_max
      return 7
  end
  
  #--------------------------------------------------------------------------
  # ● Update Help Text
  #--------------------------------------------------------------------------
  def update_help
    @help_window.set_item(item)
  end
  
  #--------------------------------------------------------------------------
  # ● Include in Skill List? 
  #--------------------------------------------------------------------------
  def include?(item)
      return false if item.nil?
  end
  
  def item
      skill(e_skill(self.index))
  end
  
  #--------------------------------------------------------------------------
  # ● Skill
  #--------------------------------------------------------------------------
  def skill(i)
      $data_skills[i] rescue nil
  end
  
  #--------------------------------------------------------------------------
  # ● E Skill
  #--------------------------------------------------------------------------
  def e_skill(i)
      @actor.f_equipped_skill[i] rescue nil
  end
    
  
  #--------------------------------------------------------------------------
  # ● Enable?
  #--------------------------------------------------------------------------             
  def enable?(item)
      $fmbs_index_e_temp = 0 if $fmbs_index_e_temp.nil?
      return false if @actor.nil?
      return false if !@actor.skill_cost_payable?(item)
      return false if $fmbs_index_e_temp < 3 and @actor.f_flying_type?
      return true if item.note =~ /<F Skill Type = Ground>/ and $fmbs_index_e_temp < 3
      return true if item.note =~ /<F Skill Type = Aerial>/ and $fmbs_index_e_temp >= 3
      return true if item.note =~ /<F Skill Type = All>/
      return false
  end    

  #--------------------------------------------------------------------------
  # ● Draw F Icon
  #--------------------------------------------------------------------------
  def draw_f_icon(icon_index, x, y, enabled = true)
      y += 3
      bitmap = Cache.system("F_Iconset")
      rect = Rect.new(icon_index % 16 * 24, icon_index / 16 * 24, 24, 24)
      contents.blt(x, y, bitmap, rect, enabled ? 255 : translucent_alpha)
  end  
  
  #--------------------------------------------------------------------------
  # ● Draw Actor Equiped Skill
  #--------------------------------------------------------------------------
  def draw_actor_equiped_skill
      self.contents.font.size = 20
      self.contents.font.bold = true
      $fmbs_index_e_temp = 0
      @actor.f_equipped_skill.each_with_index do |skill_id,i|
          x = 0 
          y = 24 * i          
          draw_f_icon(0, x + 13, 0) if i == 0
          draw_f_icon(1, x, 24) if i == 1
          draw_f_icon(2, x + 26, 24) if i == 1
          draw_f_icon(3, x + 13, 24 * 2) if i == 2
          draw_f_icon(5, x + 13, 24 * 3) if i == 3
          draw_f_icon(6, x, 24 * 4) if i == 4
          draw_f_icon(7, x + 26, 24 * 4) if i == 4
          draw_f_icon(8, x + 13, 24 * 5) if i == 5
          draw_f_icon(9, x + 13, 24 * 6) if i == 6
          draw_f_icon(10, x + 13, 24 * 7) if i == 7
          unless (i < 3 and @actor.f_flying_type?)
          if !e_skill(i).nil? and !skill(e_skill(i)).nil?
              change_color(normal_color, enable?(skill(e_skill(i))))
              draw_text(x + 52,y, 170,32, skill(e_skill(i)).name, 0)
             if @actor.skill_tp_cost(skill(e_skill(i))) > 0
               change_color(tp_cost_color, enable?(skill(e_skill(i))))
               draw_text(x + 200,y,64,32 , @actor.skill_tp_cost(skill(e_skill(i))), 2)
             elsif @actor.skill_mp_cost(skill(e_skill(i))) > 0
               change_color(mp_cost_color, enable?(skill(e_skill(i))))
               draw_text(x + 200,y,64,32 , @actor.skill_mp_cost(skill(e_skill(i))), 2)
             end              
          end
          end
          $fmbs_index_e_temp += 1 
      end
  end
  
  #--------------------------------------------------------------------------
  # ● Refresh
  #--------------------------------------------------------------------------
  def show
      return if @actor.nil?
      @help_window.show
      self.active = true
      self.visible = true
      self.index = 0
      refresh
  end
  
  #--------------------------------------------------------------------------
  # ● Hide
  #--------------------------------------------------------------------------
  def hide
      @help_window.hide
      self.active = false
      self.visible = false
      self.index = -1
  end
    
  #--------------------------------------------------------------------------
  # ● Refresh
  #--------------------------------------------------------------------------
  def refresh
      create_contents
      draw_actor_equiped_skill
  end
  
end

#==============================================================================
# ■ Window SkillList
#==============================================================================
class Window_SkillList < Window_Selectable  
 
  #--------------------------------------------------------------------------
  # ● Include?
  #--------------------------------------------------------------------------
  alias mog_fmbs_sl_include? include?
  def include?(item)
      return true if $game_system.fmbs_data[0] and SceneManager.scene_is?(Scene_Battle)
      mog_fmbs_sl_include?(item)
  end
  
end

#==============================================================================
# ■ Fmbs Window
#==============================================================================
class Fmbs_Window < Window_Command
  
  #--------------------------------------------------------------------------
  # ● Initialize
  #--------------------------------------------------------------------------
  def initialize
      super(0, 0)
      self.openness = 0
      self.z = 300
      self.x = (Graphics.width / 2) - (window_width / 2) + MOG_LMBS::COMMAND_WINDOW_POSITION[0]
      self.y = (Graphics.height / 2) - (window_height / 2) + MOG_LMBS::COMMAND_WINDOW_POSITION[1]
      deactivate
  end
  
  #--------------------------------------------------------------------------
  # ● Window Width
  #--------------------------------------------------------------------------
  def window_width
    return 192
  end

  #--------------------------------------------------------------------------
  # ● Window Height
  #--------------------------------------------------------------------------
  def window_height
      return 84
  end

  #--------------------------------------------------------------------------
  # ● Make Command List
  #--------------------------------------------------------------------------
  def make_command_list
     # add_command(MOG_LMBS::COMMAND_WINDOW_LIST_NAME[0], :f_skill_window)
      add_command(MOG_LMBS::COMMAND_WINDOW_LIST_NAME[0], :f_item_window)
      add_command(MOG_LMBS::COMMAND_WINDOW_LIST_NAME[1], :f_equip_skill)
    #  add_command(MOG_LMBS::COMMAND_WINDOW_LIST_NAME[3], :f_change_target)
  end
  
  #--------------------------------------------------------------------------
  # ● Setup
  #--------------------------------------------------------------------------
  def start
      select(0)
      open      
      self.active = true
      self.visible = true      
  end
  
  #--------------------------------------------------------------------------
  # ● End
  #--------------------------------------------------------------------------
  def end
      close
      self.active = false
      self.visible = false
  end
    
end

#==============================================================================
# ■ Window Menu Command
#==============================================================================
class Window_MenuCommand < Window_Command  
  
  #--------------------------------------------------------------------------
  # ● Add Main Commands
  #--------------------------------------------------------------------------
  alias mog_fmbs_skill_add_main_commands add_main_commands
  def add_main_commands
      mog_fmbs_skill_add_main_commands
      add_command(MOG_LMBS::SCENE_EQUIP_SKILL_NAME, :f_skill, main_commands_enabled)
  end
    
end   

#==============================================================================
# ■ Scene Menu
#==============================================================================
class Scene_Menu < Scene_MenuBase
  
  #--------------------------------------------------------------------------
  # ● Create Command Window
  #--------------------------------------------------------------------------
  alias mog_fmbs_menu_create_command_window create_command_window
  def create_command_window
      mog_fmbs_menu_create_command_window
      @command_window.set_handler(:f_skill,     method(:command_personal))
  end
  
  #--------------------------------------------------------------------------
  # ● On Personal OK
  #--------------------------------------------------------------------------
  alias mog_fmbs_menu_on_personal_ok on_personal_ok
  def on_personal_ok
    case @command_window.current_symbol
       when :f_skill ; SceneManager.call(Scene_F_Skill)
    end
     mog_fmbs_menu_on_personal_ok
  end
  
end

#==============================================================================
# ■ Scene Skill
#==============================================================================
class Scene_F_Skill < Scene_MenuBase
  
  #--------------------------------------------------------------------------
  # ● Start
  #--------------------------------------------------------------------------
  def start
      super
      @help_window = Window_Help.new
      @help_window.visible = false
      @fmbs_actor_skill_window = F_Actor_Skill_Window.new(@help_window)
      @fmbs_actor_skill_window.y = @help_window.height
      @fmbs_actor_skill_window.set_handler(:pagedown, method(:next_actor))
      @fmbs_actor_skill_window.set_handler(:pageup,   method(:prev_actor))      
      wd = Graphics.width - @fmbs_actor_skill_window.width
      @fmbs_skill_list_window = F_ESkill_List_Window.new(@help_window,@fmbs_actor_skill_window.width,@fmbs_actor_skill_window.y,wd,@fmbs_actor_skill_window.height)
      $game_temp.fmb_menu_phase = [true,5,false]
      @fmbs_actor_skill_window.actor = @actor      
      @fmbs_skill_list_window.actor = @actor
      @fmbs_skill_list_window.active = false
      @fmbs_skill_list_window.refresh
      @fmbs_actor_skill_window.update_help
      create_status_window
    end
    
  #--------------------------------------------------------------------------
  # ● Create Status Window
  #--------------------------------------------------------------------------
  def create_status_window
      @status_window = Window_SkillStatus.new(0,0)
      @status_window.z = 300
      @status_window.y = Graphics.height - @status_window.height
      @status_window.width = Graphics.width
      @status_window.actor = @actor
  end    
    
  #--------------------------------------------------------------------------
  # ● Terminate
  #--------------------------------------------------------------------------
  def terminate
      super
      @fmbs_actor_skill_window.dispose
      @fmbs_skill_list_window.dispose
      @help_window.dispose
      @status_window.dispose
      $game_temp.fmb_menu_phase = [false,0,false]
      $game_party.on_battle_end
  end
  
  #--------------------------------------------------------------------------
  # ● Om Actor Change
  #--------------------------------------------------------------------------
  def on_actor_change
      @fmbs_actor_skill_window.actor = @actor
      @fmbs_actor_skill_window.index = 0
      @fmbs_actor_skill_window.active = true
      @fmbs_skill_list_window.actor = @actor
      @fmbs_skill_list_window.index = 0
      @fmbs_skill_list_window.active = false
      @fmbs_skill_list_window.refresh
      @fmbs_actor_skill_window.update_help      
      @status_window.actor = @actor
  end
  
  #--------------------------------------------------------------------------
  # ● F Update Equip Skill
  #--------------------------------------------------------------------------             
  def update_equip_skill
      return if @actor.nil?
      skill_type = @fmbs_actor_skill_window.index < 3 ? 0 : 1
      if skill_type != @fmbs_skill_list_window.stype_id
         @fmbs_skill_list_window.stype_id = skill_type
         @fmbs_skill_list_window.index = 0
         @fmbs_skill_list_window.refresh
      end
      if Input.trigger?(:B)
         SceneManager.return
         $game_temp.fmb_menu_phase = [false,0,false]
         Sound.play_cancel
      elsif Input.trigger?(:C)   
         @fmbs_actor_skill_window.active = false
         @fmbs_skill_list_window.active = true
         $game_temp.fmb_menu_phase[1] = 6
         Sound.play_ok
      end      
  end
  
  #--------------------------------------------------------------------------
  # ● F Update Equip Skill 2
  #--------------------------------------------------------------------------             
  def update_equip_skill_2
      if Input.trigger?(:B)
         @fmbs_actor_skill_window.active = true
         @fmbs_skill_list_window.active = false
         $game_temp.fmb_menu_phase[1] = 5
         Sound.play_cancel
       elsif Input.trigger?(:C)  
         skill_id =  @fmbs_skill_list_window.item.id rescue nil
         if !skill_id.nil?
            @actor.f_equipped_skill[@fmbs_actor_skill_window.index] = skill_id 
            @fmbs_actor_skill_window.refresh
         end   
         Sound.play_equip
         @fmbs_actor_skill_window.active = true
         @fmbs_skill_list_window.active = false
         $game_temp.fmb_menu_phase[1] = 5         
      end
  end
  
  #--------------------------------------------------------------------------
  # ● Update
  #--------------------------------------------------------------------------             
  def update
      super      
      case $game_temp.fmb_menu_phase[1]
         when 5 ; update_equip_skill
         when 6 ; update_equip_skill_2
      end
  end
    
end

#==============================================================================
# ■ Sprite Base
#==============================================================================
class Sprite_Base < Sprite
  
  #--------------------------------------------------------------------------
  # ● Update Animation
  #--------------------------------------------------------------------------             
  alias mog_fmbs_update_animation update_animation
  def update_animation
      return if $game_system.fmbs_data[0] and $game_temp.fmb_menu_phase[0]
      mog_fmbs_update_animation
    end

  #--------------------------------------------------------------------------
  # ● Animation Set Sprite
  #--------------------------------------------------------------------------      
  alias mog_fmbs_ani_animation_set_sprites animation_set_sprites
  def animation_set_sprites(frame)
      f_update_animation_set_sprites(frame) if SceneManager.scene_is?(Scene_Battle) and $game_system.fmbs_data[0]
      mog_fmbs_ani_animation_set_sprites(frame)
  end        
    
  #--------------------------------------------------------------------------
  # ● F update Animation Set Sprites
  #--------------------------------------------------------------------------      
  def f_update_animation_set_sprites(frame)
      return if @battler.nil?
      @ani_ox = self.x ; @ani_oy = self.y - @battler.f_body_height2
      if @animation.position == 0
         @ani_oy -= @battler.f_body_height2
      elsif @animation.position == 2
         @ani_oy += @battler.f_body_height2
      end  
  end
      
end
  
#==============================================================================
# ■ Sprite Battler
#==============================================================================
class Sprite_Battler < Sprite_Base
  
  #--------------------------------------------------------------------------
  # ● Initialize
  #--------------------------------------------------------------------------             
  alias mog_fmbs_sb_initialize initialize
  def initialize(viewport, battler = nil)
      @sprite_index = -1 ; @skill_sprites = []
      mog_fmbs_sb_initialize(viewport,battler)
  end
  
  #--------------------------------------------------------------------------
  # ● Update
  #--------------------------------------------------------------------------             
  alias mog_fmbs_sb_update update
  def update
      return if $game_temp.fmb_phase_end == 4
      mog_fmbs_sb_update
  end
  
  #--------------------------------------------------------------------------
  # ● Dispose
  #--------------------------------------------------------------------------             
  alias mog_fmbs_sb_dispose dispose
  def dispose
      mog_fmbs_sb_dispose
      @skill_sprites.each do |sprite| sprite.dispose end
      dispose_f_shadow
      $game_temp.f_fmbs_clear
  end
  
  #--------------------------------------------------------------------------
  # ● Update Bitmap
  #--------------------------------------------------------------------------             
  alias mog_fmbs_sb_update_bitmap update_bitmap
  def update_bitmap   
      if $game_system.fmbs_data[0] ; update_fmbs_bitmap ; return ; end
      mog_fmbs_sb_update_bitmap
  end
  
  #--------------------------------------------------------------------------
  # ● Update Battler Motion
  #--------------------------------------------------------------------------             
  if $imported[:mog_battler_motion]
  alias mog_fmbs_can_update_battler_motion? can_update_battler_motion?
  def can_update_battler_motion?
      return false if $game_system.fmbs_data[0]
      mog_fmbs_can_update_battler_motion?
  end  
  end

  #--------------------------------------------------------------------------
  # ● Update Actor Sprite Damage Effect
  #--------------------------------------------------------------------------             
  if $imported[:mog_battler_motion]
  alias mog_fmbs_update_actor_sprite_damage_effect update_actor_sprite_damage_effect
  def update_actor_sprite_damage_effect
      return if $game_system.fmbs_data[0]
      mog_fmbs_update_actor_sprite_damage_effect
  end
  end

  #--------------------------------------------------------------------------
  # ● Update Fmbs Bitmap
  #--------------------------------------------------------------------------             
  def update_fmbs_bitmap
      return if $game_temp.fmb_menu_phase[0]      
      pre_cache_sprites if @sprites_p.nil?
      refresh_fmbs_bitmap if refresh_fmbs_bitmap?
      refresh_fmbs_character_bitmap if self.bitmap.nil?      
      if !self.bitmap.nil?
         refresh_sprite_size if @battler.sprite_data[12][0] == 0
         update_fmbs_rect if update_fmbs_rect?
         update_fmbs_character_sprite if @battler.f_char_data[0]
         update_fmbs_movement
         update_fmbs_skills
         update_fmbs_battler
         update_fmbs_opacity  
      end   
  end
  
  #--------------------------------------------------------------------------
  # ● Update Fmbs Opacity
  #--------------------------------------------------------------------------             
  def update_fmbs_opacity
      if update_fmbs_collapse?
         update_fmbs_collapse
      else
         if @battler.f_sprite_fade[0] 
            update_fmbs_fade_effect
         else   
            self.opacity += 20
         end  
      end   
  end
    
  #--------------------------------------------------------------------------
  # ● Update Fmbs Escape Effect
  #--------------------------------------------------------------------------             
  def update_fmbs_fade_effect
      return true if @battler.is_a?(Game_Enemy) and @battler.dead?
      return if @battler.is_a?(Game_Enemy) and @battler.f_sprite_fade[1] == 0
      return if @battler.is_a?(Game_Actor) and @battler.f_sprite_fade[1] == 1
      self.opacity -= 20 
  end
  
  #--------------------------------------------------------------------------
  # ● Update Fmbs Collpase
  #--------------------------------------------------------------------------             
  def update_fmbs_collapse?
      return false if !@battler.f_ground?
      return false if @battler.is_a?(Game_Actor)
#      return false if !@sprites_p[9].nil?
      return @battler.dead?
  end
  
  #--------------------------------------------------------------------------
  # ● Update Fmbs Collpase
  #--------------------------------------------------------------------------             
  def update_fmbs_collapse
      return if @effect_duration > 2
      self.opacity -= 5
  end
  
  #--------------------------------------------------------------------------
  # ● Update Fmbs Bitmap
  #--------------------------------------------------------------------------             
  def update_fmbs_battler
      @battler.f_update_fmbs_battler_damage if @battler.f_damage[0] > 0
      @battler.f_update_fmbs_battler_inv_duration
      @battler.f_update_fmbs_battler_effect if @battler.f_damage_effect[0] != 0
      @battler.f_update_base_pose
      @battler.f_update_ai if @battler.f_update_ai?
  end    

  #--------------------------------------------------------------------------
  # ● Update Fmbs Rect?
  #--------------------------------------------------------------------------             
  def update_fmbs_rect?
      return false if @sprites_p.nil?
      return false if @battler.f_char_data[0]
      return false if @sprites_p[@battler.sprite_data[0]].nil?
      return false if @sprites_p[@battler.sprite_data[0]].size == 0
      return false if @sprites_p[@battler.sprite_data[0]][2].nil?
      return false if $game_temp.fmb_phase_end == 4
      return true
  end
  
  #--------------------------------------------------------------------------
  # ● Refresh FMBS Bitmap?
  #--------------------------------------------------------------------------             
  def refresh_fmbs_bitmap?
      return false if @sprites_p.empty?
      return false if $game_temp.battle_end and @sprite_index == 9
      return false if $game_temp.fmb_phase_end == 4
      return true if @battler.sprite_data[0] != @sprite_index
      return false
  end
  
  #--------------------------------------------------------------------------
  # ● Pre Cache Sprites
  #--------------------------------------------------------------------------             
  def pre_cache_sprites
      @sprites_p = [] ; b_name = @battler.battler_name
      original_sprite = Cache.battler(@battler.battler_name.to_s, 0) rescue nil
      return if original_sprite.nil?
      sprites_names = []
      return if b_name == ""
      Dir.glob("Graphics/Battlers/" + b_name + "*.png").each do |file|
      sprites_names.push(File.basename(file)) ; end
      sprites_names.each do |file|
         ns = file =~ /\[F(\d+)]/ ? $1.to_s : 1
         sp = file =~ /\[S(\d+)]/ ? $1.to_s : MOG_LMBS::DEFAULT_SPRITE_ANIMATION_SPEED
         eh = file =~ /\[H(\d+)]/ ? $1.to_s : 0
         @sprites_p[0] = [Cache.battler(file, @battler.battler_hue) ,ns.to_i,sp.to_i,eh.to_i] if file =~ /\[Idle]/
         @sprites_p[1] = [Cache.battler(file, @battler.battler_hue) ,ns.to_i,sp.to_i,eh.to_i] if file =~ /\[Walk]/
         @sprites_p[2] = [Cache.battler(file, @battler.battler_hue) ,ns.to_i,sp.to_i,eh.to_i] if file =~ /\[Jump]/
         @sprites_p[3] = [Cache.battler(file, @battler.battler_hue) ,ns.to_i,sp.to_i,eh.to_i] if file =~ /\[Fall]/
         @sprites_p[3] = [Cache.battler(file, @battler.battler_hue) ,ns.to_i,sp.to_i,eh.to_i] if @sprites_p[3].nil? and file =~ /\[Jump]/
         @sprites_p[4] = [Cache.battler(file, @battler.battler_hue) ,ns.to_i,sp.to_i,eh.to_i] if file =~ /\[Crouch]/
         @sprites_p[5] = [Cache.battler(file, @battler.battler_hue) ,ns.to_i,sp.to_i,eh.to_i] if file =~ /\[Dash]/
         @sprites_p[5] = [Cache.battler(file, @battler.battler_hue) ,ns.to_i,sp.to_i,eh.to_i] if @sprites_p[5].nil? and file =~ /\[Walk]/
         @sprites_p[6] = [Cache.battler(file, @battler.battler_hue) ,ns.to_i,sp.to_i,eh.to_i] if file =~ /\[Guard]/
         @sprites_p[7] = [Cache.battler(file, @battler.battler_hue) ,ns.to_i,sp.to_i,eh.to_i] if file =~ /\[Guard2]/
         @sprites_p[7] = [Cache.battler(file, @battler.battler_hue) ,ns.to_i,sp.to_i,eh.to_i] if @sprites_p[7].nil? and file =~ /\[Guard]/
         @sprites_p[8] = [Cache.battler(file, @battler.battler_hue) ,ns.to_i,sp.to_i,eh.to_i] if file =~ /\[Damage]/
         @sprites_p[9] = [Cache.battler(file, @battler.battler_hue) ,ns.to_i,sp.to_i,eh.to_i] if file =~ /\[Dead]/
         @sprites_p[9] = [Cache.battler(file, @battler.battler_hue) ,ns.to_i,sp.to_i,eh.to_i] if @sprites_p[9].nil? and file =~ /\[Damage]/
         @sprites_p[10] = [Cache.battler(file, @battler.battler_hue) ,ns.to_i,sp.to_i,eh.to_i] if file =~ /\[Cast]/
         @sprites_p[11] = [Cache.battler(file, @battler.battler_hue) ,ns.to_i,sp.to_i,eh.to_i] if file =~ /\[Victory]/
         @sprites_p[$1.to_i + 1000] = [Cache.battler(file, @battler.battler_hue) ,ns.to_i,sp.to_i,eh.to_i] if file =~ /\[Skill_(\d+)]/
         @sprites_p[$1.to_i + 2000] = [Cache.battler(file, @battler.battler_hue) ,ns.to_i,sp.to_i,eh.to_i] if file =~ /\[Item_(\d+)]/
      end
      @battler.f_crouch[0] = true if !@sprites_p[4].nil?
  end  

  #--------------------------------------------------------------------------
  # ● Set Sprite Index
  #--------------------------------------------------------------------------             
  def set_sprite_index
      s_data = nil
      if @sprites_p[@battler.sprite_data[0]].nil? or @sprites_p[@battler.sprite_data[0]][0].nil?
         if @battler.f_mov_acting? 
            if !@sprites_p[1001].nil? and @battler.f_action[4] == 0
                s_data = @sprites_p[1001]
                @sprites_p[@battler.sprite_data[0]] = s_data   
            else !@sprites_p[2001].nil? and @battler.f_action[4] == 1
                s_data = @sprites_p[2001]
                @sprites_p[@battler.sprite_data[0]] = s_data                   
            end  
         else  
            return nil if @sprites_p[0].nil? or @sprites_p[0][0].nil?
            s_data = @sprites_p[0]
            @sprites_p[@battler.sprite_data[0]] = s_data
         end
      else    
         s_data = @sprites_p[@battler.sprite_data[0]]
      end     
      return s_data
  end
  
  #--------------------------------------------------------------------------
  # ● Refresh FMBS Initial Position
  #--------------------------------------------------------------------------             
  def refresh_fmbs_initial_position
      return if !@f_ini_p.nil?
      return if bitmap.nil?
      @f_ini_p = true ; lm_x = 0
      lm_x = ((Graphics.width / 2) * camera_range / 100) if $imported[:mog_battle_camera]
      if @battler.is_a?(Game_Actor)         
         space = 200 / $game_party.battle_members.size 
         @battler.screen_x = -lm_x + 64 + (space * @battler.index)
         @battler.sprite_data[3] = 1
      else 
         if @battler.is_a?(Game_Enemy) and $game_system.f_adjust_position_auto
            space = ((Graphics.width / 2) - 64 + lm_x) / $game_troop.members.size
            @battler.screen_x = (Graphics.width - 64) - (space * @battler.index) + lm_x
         end
      end  
      @battler.screen_y = @battler.f_ground
      @battler.screen_y = @battler.f_flying_height if @battler.f_flying_type?
      self.x = @battler.screen_x ; self.y = @battler.screen_y 
 end    
  
  #--------------------------------------------------------------------------
  # ● Refresh FMBS Bitmap
  #--------------------------------------------------------------------------             
  def refresh_fmbs_bitmap
      return if @sprites_p[0].nil?      
      @sprite_index = @battler.sprite_data[0]
      s_data = set_sprite_index
      self.bitmap = Bitmap.new(16,16) if bitmap.nil? and @sprites_p[0][0].nil?
      return if s_data.nil?
      @b_image = s_data[0]
      @fm = s_data[1]
      @cw = @b_image.width / @fm
      @ch = @b_image.height
      self.bitmap = Bitmap.new(@cw,@ch)
      @battler.sprite_data[1] = 0
      @battler.sprite_data[2] = s_data[2]
      @sprites_p[@battler.sprite_data[0]][2] = s_data[2] if @sprites_p[@battler.sprite_data[0]][2].nil?
      update_fmbs_rect
      @battler.sprite_data[14] = @sprites_p[@battler.sprite_data[0]][3]
  end
  
  #--------------------------------------------------------------------------
  # ● Update FMBS Rect
  #--------------------------------------------------------------------------             
  def update_fmbs_rect
      return if @battler.sprite_data[0].nil? 
      return if @cw.nil?
      @battler.sprite_data[2] += 1 
      return if @battler.sprite_data[2] < @sprites_p[@battler.sprite_data[0]][2]
      @battler.sprite_data[2] = 0
      self.bitmap.clear
      f_rect = Rect.new(@cw * @battler.sprite_data[1],0,@cw,@ch)
      self.bitmap.blt(0,0,@b_image,f_rect)
      @battler.sprite_data[1] += 1 unless @battler.f_mov_air_dash?
      if @battler.sprite_data[1] >= @fm
         @battler.sprite_data[1] = 0
         @battler.sprite_data[1] = @fm - 1 if @battler.f_noloop_animation?
      end
  end
  
  #--------------------------------------------------------------------------
  # ● Update FMBS Movement
  #--------------------------------------------------------------------------             
  def update_fmbs_movement
      @battler.f_fix_direction[0] = false
      @battler.f_air_ground[0] = false
      @battler.f_air_ground[1] = 0 if @battler.screen_y >= @battler.f_ground
      @battler.f_fix_direction[1] -= 1 if @battler.f_fix_direction[1] > 0
      @battler.f_update_animation_mirror
      @battler.f_update_jump if @battler.f_mov_jumping?
      @battler.f_update_double_jump if @battler.f_mov_double_jump?
      @battler.f_update_air_dash if @battler.f_mov_air_dash?
      @battler.f_update_gravity
      @battler.f_update_action if !@battler.f_action[1].nil?
      @battler.f_update_cast if @battler.f_update_cast?
      @battler.f_update_turn
      update_f_force_action if !@battler.f_force_action[0].nil?
      update_f_battler_direction if update_f_battler_direction?
      @battler.f_update_force_move if @battler.f_force_movement?
      update_f_sprite_effects
  end
  
  #--------------------------------------------------------------------------
  # ● Update F Force Action
  #--------------------------------------------------------------------------             
  def update_f_force_action
      item = @battler.f_force_action[0]
      i_type = item.is_a?(RPG::Skill) ? 0 : 1
      @battler.f_force_action[1].each_with_index do |trg,i|
          @battler.f_execute_skill(item.id,trg,i_type)
          @battler.f_action[3] = trg
          lt = 1 * (i + 1)
          make_sprite_skill(lt)
      end         
      @battler.f_force_action = [nil,[]]
  end
  
  #--------------------------------------------------------------------------
  # ● Update F Battler Direction
  #--------------------------------------------------------------------------             
  def update_f_battler_direction?
      return false if @battler.f_target.nil? 
    #  return false if !@battler.f_movable?
      return true
  end
    
  #--------------------------------------------------------------------------
  # ● Update F Battler Direction
  #--------------------------------------------------------------------------             
  def update_f_battler_direction
      self.mirror = @battler.sprite_data[3] == 1 ? true : false
  end
  
  #--------------------------------------------------------------------------
  # ● Set New Animation
  #--------------------------------------------------------------------------
  alias mog_fmbs_setup_new_animation setup_new_animation
  def setup_new_animation
      if @battler.animation_id > 0
         animation = $data_animations[@battler.animation_id]
         mirror = @battler.f_damage[4] == 0 ? false : true
         start_animation(animation, mirror)
         @battler.animation_id = 0
      end
      mog_fmbs_setup_new_animation
  end  
 
  #--------------------------------------------------------------------------
  # ● Update F Sprite Effects
  #--------------------------------------------------------------------------
  def update_f_sprite_effects
      @battler.f_update_fying_effect if @battler.f_flying_type? and ! @battler.f_char_data[0]
      update_f_zoom_effect
  end
 
  #--------------------------------------------------------------------------
  # ● Update f Zoom Effect
  #--------------------------------------------------------------------------
  def update_f_zoom_effect
      if @battler.f_breath_effect?
         @battler.f_update_breath_effect
         self.zoom_y = 1.01 + @battler.f_breath_effect[1]
      end   
      
  end
  
end

#==============================================================================
# ■ Sprite Battler
#==============================================================================
class Sprite_Battler < Sprite_Base
  
  #--------------------------------------------------------------------------
  # ● Update FMBS Character Sprite
  #--------------------------------------------------------------------------             
  def update_fmbs_character_sprite
      update_fmbs_character_rect
      refresh_fmbs_character_pose if @battler.f_char_data[3]
  end
  
  #--------------------------------------------------------------------------
  # ● Refresh FMBS Character Pose
  #--------------------------------------------------------------------------             
  def refresh_fmbs_character_pose
      @battler.f_char_data[3] = false
      self.angle = @battler.dead? ? 270 : 0 if @battler.f_direction == 0 
      self.angle = @battler.dead? ? 90 : 0 if @battler.f_direction == 1
  end
  
  #--------------------------------------------------------------------------
  # ● Refresh Fmbs Force Bitmap
  #--------------------------------------------------------------------------             
  def refresh_fmbs_character_bitmap
      self.bitmap = Cache.battler(@battler.battler_name, 0) rescue nil if @battler.battler_name != ""
      refresh_fmbs_bitmap_character if self.bitmap.nil? and @battler.is_a?(Game_Actor)
      self.bitmap = Bitmap.new(48,96) if self.bitmap.nil?
  end
  
  #--------------------------------------------------------------------------
  # ● Refresh Fmbs Bitmap Character
  #--------------------------------------------------------------------------             
  def refresh_fmbs_bitmap_character
      @battler.f_char_data = [true,10,0,true]
      self.bitmap = Cache.character(@battler.character_name)
      sign = @battler.character_name[/^[\!\$]./]
      if sign && sign.include?('$')
         @cw = bitmap.width / 3
         @ch = bitmap.height / 4
      else
         @cw = bitmap.width / 12
         @ch = bitmap.height / 8
      end
      self.ox = @cw / 2
      self.oy = @ch
      self.zoom_x = 1.5
      self.zoom_y = self.zoom_x
      refresh_fmbs_character_pose
      update_fmbs_character_rect      
  end
  
  #--------------------------------------------------------------------------
  # ● Set Sprite Size
  #--------------------------------------------------------------------------
  def refresh_sprite_size
      if @battler.f_char_data[0]
         zoom = 1.5
         x1 = (@cw * zoom) / 1.00
         x2 = ((@cw / 2) * zoom) / 1.00
         y1 = (@ch * zoom) / 1.00
         y2 = ((@ch / 2) * zoom) / 1.00
         @battler.sprite_data[12] = [x1,y1,x2,y2]
      else   
         @battler.set_sprite_size
      end  
  end
      
  #--------------------------------------------------------------------------
  # ● Update Fmbs Character Rect
  #--------------------------------------------------------------------------
  def update_fmbs_character_rect
      @battler.f_char_data[1] += 1  
      return if @battler.f_char_data[1] < 4
      @battler.f_char_data[1] = 0
      index = @battler.character_index
      sx = (index % 4 * 3 + @battler.f_char_data[2]) * @cw
      sy = (index / 4 * 4 + 1) * @ch
      self.src_rect.set(sx, sy, @cw, @ch)
      @battler.f_char_data[2] += 1 if f_anime_char_sprite?
      if @battler.f_char_data[2] > 2 or @battler.f_mov_damage? or @battler.f_mov_unconscious?
         @battler.f_char_data[2] = 0
      end
  end
  
  #--------------------------------------------------------------------------
  # ● F Anime Char Sprite
  #--------------------------------------------------------------------------
  def f_anime_char_sprite?
      return true if @battler.f_walking?
      return true if @battler.f_mov_dashing? and @battler.f_ground?
      return true if @battler.f_mov_acting?
      return false 
  end
  
  #--------------------------------------------------------------------------
  # ● Update Origin
  #--------------------------------------------------------------------------
  alias mog_fmbs_update_origin update_origin
  def update_origin
      mog_fmbs_update_origin
      if bitmap and @battler.f_char_data[0]
         self.ox = @cw / 2 ;  self.oy = @ch
      end      
  end
    
end

#==============================================================================
# ■ Sprite Battler
#==============================================================================
class Sprite_Battler < Sprite_Base
  
  #--------------------------------------------------------------------------
  # ● Can create Battler Shadow
  #--------------------------------------------------------------------------  
  if $imported[:mog_battler_shadow]
  alias mog_fmbs_can_create_battler_shadow? can_create_battler_shadow?
  def can_create_battler_shadow?
      return false if $game_system.fmbs_data[0]
      mog_fmbs_can_create_battler_shadow?
  end
  end  
  
  #--------------------------------------------------------------------------
  # ● Refresh Fms Shadow
  #--------------------------------------------------------------------------             
  def refresh_fmbs_shadow
      return if !$game_system.fmbs_data[0]
      return if !@shadow_sprite.nil?
      return if !MOG_LMBS::SHADOW_ENABLE
      return if @battler.f_body_width == 0
      @shadow_sprite = Sprite.new
      @shadow_image = Cache.system("F_Shadow")
      @shadow_sprite.bitmap = Bitmap.new(@battler.f_body_width,@shadow_image.height)
      @shadow_sprite.bitmap.stretch_blt(@shadow_sprite.bitmap.rect, @shadow_image, @shadow_image.rect) 
      @shadow_sprite.ox = @shadow_sprite.bitmap.width / 2
      @shadow_sprite.oy = @shadow_sprite.bitmap.height / 2
      @shadow_sprite.viewport = self.viewport
      @shadow_pos = MOG_LMBS::SHADOW_POSITION
  end
  
  #--------------------------------------------------------------------------
  # ● Dispose F Shadow
  #--------------------------------------------------------------------------             
  def dispose_f_shadow
      return if @shadow_sprite.nil?
      @shadow_sprite.bitmap.dispose
      @shadow_sprite.dispose
  end
  
  #--------------------------------------------------------------------------
  # ● Update Fmbs Shadow
  #--------------------------------------------------------------------------             
  def update_fmbs_shadow
      refresh_fmbs_shadow if @shadow_sprite.nil?
      return if @shadow_sprite.nil?
      @shadow_sprite.x = self.x + @shadow_pos[0]
      @shadow_sprite.y = @battler.f_ground + @shadow_pos[1]
      @shadow_sprite.z = self.z - 10
      @shadow_sprite.opacity = self.opacity
      @shadow_sprite.visible = self.visible
      @shadow_sprite.mirror = self.mirror
  end  
  
  #--------------------------------------------------------------------------
  # ● Update Position
  #--------------------------------------------------------------------------      
  alias mog_fmbs_update_position update_position
  def update_position
      return if $game_temp.fmb_menu_phase[0]
      update_fmbs_shadow
      return if $game_temp.fmb_phase_end == 4
      refresh_fmbs_initial_position if @f_ini_p.nil?
      mog_fmbs_update_position
      update_fmbs_eh      
      update_fmbs_flying_type
      update_fmbs_z
  end  
  
  #--------------------------------------------------------------------------
  # ● Update Fmbs Z
  #--------------------------------------------------------------------------      
  def update_fmbs_z
      return if @battler.nil?
      return if BattleManager.active_actor.nil?
      self.z += 10 if @battler == BattleManager.active_actor
  end
      
  #--------------------------------------------------------------------------
  # ● Update Fmbs EH
  #--------------------------------------------------------------------------      
  def update_fmbs_eh
      return if @sprites_p[@battler.sprite_data[0]].nil?
      self.y += @battler.sprite_data[14]
  end
      
  #--------------------------------------------------------------------------
  # ● Update Fmbs Flying Type
  #--------------------------------------------------------------------------      
  def update_fmbs_flying_type 
      return if !$game_system.fmbs_data[0]
      self.y += @battler.f_flying_type[2]
  end
  
end

#==============================================================================
# ■ Sprite Battler
#==============================================================================
class Sprite_Battler < Sprite_Base
  
  #--------------------------------------------------------------------------
  # ● Update FMBS Skills
  #--------------------------------------------------------------------------             
  def update_fmbs_skills
      return if @skill_sprites.nil?
      make_sprite_skill if need_make_sprite_skill?
      @skill_sprites.each do |sprite|
            sprite.update
            sprite.update_skill
            if sprite.duration == 0 or sprite.bitmap.disposed?
               sprite.dispose
               @skill_sprites.delete(sprite)
               @skill_sprites.compact!
            end
      end
  end
    
  #--------------------------------------------------------------------------
  # ● Need Make Sprite Skill
  #--------------------------------------------------------------------------             
  def need_make_sprite_skill?
      return true if @battler.f_action[0]
      return false
  end
  
  #--------------------------------------------------------------------------
  # ● Make Sprite Skill
  #--------------------------------------------------------------------------             
  def make_sprite_skill(lt = nil)     
      @battler.f_action[0] = false
      @skill_sprites.push(Sprite_Skills.new(self.viewport,self,lt))
  end
  
  #--------------------------------------------------------------------------
  # ● Fmbs Skills Clear
  #--------------------------------------------------------------------------             
  def fmbs_skills_clear
      @skill_sprites.each do |sprite|
           sprite.duration = 0
           sprite.dispose
           @skill_sprites.delete(sprite)
           @skill_sprites.compact!
      end
  end
  
end

#==============================================================================
# ■ Sprite Skills
#==============================================================================
class Sprite_Skills < Sprite_Base
  
  attr_accessor :duration
  attr_accessor :piercing
  
  #--------------------------------------------------------------------------
  # ● Initialize
  #--------------------------------------------------------------------------             
  def initialize(viewport,user,lt = nil)
      super(viewport)
      @sprite = user
      @user = user.battler
      @user_collision = user.battler
      @direction = @user.f_direction
      @user_synchronize = lt.nil? ? true : false
      @skill = @user.f_action[1]
      @item = @skill
      @item = @user.equips[0] if @user.item_weapon?(@skill) and !@user.equips[0].nil?     
      @skill_type = @user.f_action[1].is_a?(RPG::Skill) ? 0 : 1
      @move_speed = [0,0]
      @duration = @user.f_action[7] != 0 ? @user.f_action[7] : 60
      @range = [0,0,0,0]
      @piercing = [true,false]
      @targets_done = []
      @multi_hit = false
      @ignore_knockback = false
      @ignore_guard = false
      @ignore_reflect = false
      @on_target = false
      @auto_target = lt.nil? ? false : true
      @collision_wait_duration = !lt.nil? ? lt : 5
      @pr_target = @user.f_action[3]
      @hit_animation_id = 0
      @ignore_p_target = false
      if @skill.nil?
         self.bitmap = Bitmap.new(16,16)
         self.ox = self.bitmap.width / 2
         self.mirror = @sprite.mirror
         self.oy = self.bitmap.height / 2
         self.x = @user.screen_x - self.ox
         self.y = @user.screen_y - @user.f_body_height2 - 1
         self.z = @sprite.z + 1
         @user_synchronize = false
         animation = $data_animations[@user.f_action[2]]
         mirror = @user.animation_mirror
         start_animation(animation, mirror)
      else
          name = $1.to_s if @item.note =~ /<F Sprite = (\S+)>/
          if !name.nil?
             ns = $1.to_i if name =~ /\[F(\d+)]/
             sp = name =~ /\[S(\d+)]/ ? $1.to_s : MOG_LMBS::DEFAULT_SPRITE_ANIMATION_SPEED
             if ns.nil?
                self.bitmap = Cache.projectile(name).dup
             else   
                @anime_data = [Cache.projectile(name),ns.to_i,sp.to_i,ns.to_i,0]
                @cw = @anime_data[0].width / @anime_data[1]
                @ch = @anime_data[0].height
                self.bitmap = Bitmap.new(@cw,@ch)
                update_bitmap_rect
             end  
          else
             self.bitmap = Bitmap.new(16,16)
          end   
          self.ox = self.bitmap.width / 2
          self.mirror = @sprite.mirror
          self.oy = self.bitmap.height / 2
          self.x = @user.screen_x - self.ox
          self.y = @user.screen_y - @user.f_body_height2
          self.z = @sprite.z + 1
          self.blend_type = $1.to_i if @item.note =~ /<F Blend Type = (\S+)>/
          set_skill_data
      end
      @cw = self.bitmap.width ; @ch = self.bitmap.height
      @duration = 1 if @duration < 1
      @collision_wait_duration = 1 if @collision_wait_duration < 1
      set_animation if !@skill.nil? and @user.f_action[2] == 0
      update_movement
      check_collision if !@pr_target.nil?
      execute_animation if !@ani_id.nil?  
      self.z = @user.screen_z + 20
      if !@item.nil? and @item.note =~ /<F Auto Target Area>/
         @auto_target = false ; @ignore_p_target = true
      end          
  end

  #--------------------------------------------------------------------------
  # ● Execute Animation
  #--------------------------------------------------------------------------             
  def execute_animation
      animation = $data_animations[@ani_id]
      mirror = @user.animation_mirror
      start_animation(animation, self.mirror)   
  end  
  
  #--------------------------------------------------------------------------
  # ● Set Animation
  #--------------------------------------------------------------------------             
  def set_animation
      @hit_animation_id = $1.to_i.abs if @item.note =~ /<F Hit Animation = (\d+)>/
      anime_id = nil
      if @skill.is_a?(RPG::Skill) and @skill.id == @user.attack_skill_id
         if @user.is_a?(Game_Actor) and !@user.equips[0].nil?
            @hit_animation_id = @user.equips[0].animation_id
           else
            @hit_animation_id = 1 if @user.is_a?(Game_Enemy)
         end
      else   
         anime_id = @item.animation_id.abs
      end     
      @ani_id = anime_id
      if !@ani_id.nil? and @ani_id > 0
          anime = $data_animations[anime_id] rescue nil
          if !anime.nil?
              ani_duration = (anime.frame_max * 4) + 1
              @duration = ani_duration if @duration < ani_duration
          end    
       end   
  end
      
  #--------------------------------------------------------------------------
  # ● Update Bitmap Rect
  #--------------------------------------------------------------------------             
  def update_bitmap_rect
      @anime_data[3] += 1
      return if @anime_data[3] < @anime_data[2]
      @anime_data[3] = 0
      self.bitmap.clear
      s_rect = Rect.new(@cw * @anime_data[4],0,@cw,@ch)
      self.bitmap.blt(0,0,@anime_data[0],s_rect)
      @anime_data[4] += 1
      @anime_data[4] = 0 if @anime_data[4] >= @anime_data[1]
  end
  
  #--------------------------------------------------------------------------
  # ● Set Skill Data
  #--------------------------------------------------------------------------             
  def set_skill_data
      #Range
      @range = [(self.ox / 3),-24,(self.oy / 4),(self.oy / 2)]
      if @item.note =~ /<F Area = \s*(\-*\d+)\s* - \s*(\-*\d+)\s* - \s*(\-*\d+)\s* - \s*(\-*\d+)\s*>/
         @range = [$1.to_i.abs,$2.to_i.abs,$3.to_i.abs,$4.to_i.abs]  
      end   
      #Piercing
      @piercing = [false,false] if @item.note =~ /F Disable Piercing>/
      #Move Speed 
      if @item.note =~ /<F Move Speed = x\s*(\-*\d+)\s* y\s*(\-*\d+)\s*>/
         dx = @user.f_direction == 0 ? -$1.to_i : $1.to_i
         @np = [dx,$2.to_i] 
         if @user.item_weapon?(@item)
            @np[1] = 5 if @np[1] == 0
         end
         @user_synchronize = false
         self.x += self.ox
      end   
      @multi_hit = true if @item.note =~ /<F Multi Hit>/
      @ignore_knockback = true if @item.note =~ /<F Ignore Knockback>/
      @ignore_knockback = true if @multi_hit
      @ignore_guard = true if @item.note =~ /<F Ignore Guard>/
      @ignore_reflect = true if @item.note =~ /<F Ignore Reflect>/
      @on_target = true if @item.note =~ /<F On Target>/
      @collision_wait_duration = $1.to_i.abs if @item.note =~ /<F Wait Collision = (\d+)>/
      @collision_wait_duration = 1 if !@np.nil? and @collision_wait_duration == 5
      @oxy = [0,@sprite.bitmap.height / 2]
      @user.animation_id = $1.to_i if @item.note =~ /<F User Animation = (\d+)>/
  end

 #--------------------------------------------------------------------------
  # ● Dispose
  #--------------------------------------------------------------------------             
  def dispose
      super
      self.bitmap.dispose rescue nil
  end

  #--------------------------------------------------------------------------
  # ● Update
  #--------------------------------------------------------------------------             
  def update_skill
      return if @duration == 0
      return if self.bitmap.disposed?
      if !@skill.nil?
         update_wait_collision if @collision_wait_duration > 0
         update_movement unless @ignore_p_target
         check_collision if !BattleManager.f_targets.nil?
         update_bitmap_rect if !@anime_data.nil?
      end   
      update_skill_duration rescue nil    
  end
  
  #--------------------------------------------------------------------------
  # ● Update Wait Collision
  #--------------------------------------------------------------------------      
  def update_wait_collision
      @collision_wait_duration -= 1
  end  
    
  #--------------------------------------------------------------------------
  # ● Animation Set Sprite
  #--------------------------------------------------------------------------      
  def animation_set_sprites(frame)    
      @ani_ox = self.x ; @ani_oy = self.y
      if @animation.position == 0
         @ani_oy -= @user.f_body_height2
      elsif @animation.position == 2
         @ani_oy += @user.f_body_height2
      end
      super
      @ani_sprites.each_with_index do |sprite, i| sprite.z = self.z + 1  end
  end    
  
  #--------------------------------------------------------------------------
  # ● Update Skill Duration
  #--------------------------------------------------------------------------      
  def update_skill_duration
      @duration -= 1 if @duration >= 0
      self.opacity -= 25 if @piercing[1] or @user.dead?
      self.opacity -= 50 if !@piercing[1] and @duration < 5
      @piercing[1] = true if out_of_screen?
      if dispose_skill?
         @duration = 0 
         self.opacity = 0
         self.visible = false
         self.bitmap.dispose rescue nil
      end
  end    
  
  #--------------------------------------------------------------------------
  # ● Dispose Skill?
  #--------------------------------------------------------------------------      
  def dispose_skill?
      return true if @user_synchronize and !@user.f_mov_acting?
      return true if @duration <= 0
      return true if self.opacity == 0
      return true if out_of_screen?
      return false
  end
 
  #--------------------------------------------------------------------------
  # ● Out of Screen
  #--------------------------------------------------------------------------      
  def out_of_screen?
      return true if !self.x.between?((@user.f_limit_x1 - @cw),(@user.f_limit_x2 + @cw))
      return true if !self.y.between?((@user.f_limit_y1 - @ch),(@user.f_ground + (@ch / 2)))
      return false
  end
    
end

#==============================================================================
# ■ Sprite Skills
#==============================================================================
class Sprite_Skills < Sprite_Base
  
  #--------------------------------------------------------------------------
  # ● Check Collision
  #--------------------------------------------------------------------------             
  def check_collision
      return if @piercing[1]
      targets = [] ; dmg = false
      BattleManager.f_targets.each do |sprite|
           next if !execute_effect?(sprite.battler)
           targets.push(sprite.battler) if targets_in_range?(sprite)
      end
      targets.each do |battler| 
         dmg = true
         @skill.repeats.times { execute_effect(battler, @skill)}
      end   
      @piercing[1] = true if !@piercing[0] and dmg
  end
 
  #--------------------------------------------------------------------------
  # ● Targets In Range
  #--------------------------------------------------------------------------             
  def targets_in_range?(sprite)
      return true if @auto_target
      br = [self.x, self.y] ; sr = [0,0,0,0]
      if @direction == 0
         sr[0] = sprite.x - (sprite.battler.f_body_width2 + @range[1])
         sr[1] = sprite.x + (sprite.battler.f_body_width2 + @range[0])
      else
         sr[0] = sprite.x - (sprite.battler.f_body_width2 + @range[0])
         sr[1] = sprite.x + (sprite.battler.f_body_width2 + @range[1])
      end  
      sr[2] = sprite.y + @range[2] 
      sr[3] = sprite.y - (sprite.battler.f_body_height + @range[3])
      return false if !br[0].between?(sr[0],sr[1])
      return false if !br[1].between?(sr[3],sr[2])
      return true
  end  

  #--------------------------------------------------------------------------
  # ● Check Collision
  #--------------------------------------------------------------------------             
  def execute_effect?(target)
      return false if $game_temp.battle_end
      return false if $game_temp.fmb_phase_data[1] > 0 
      return false if target.nil? 
      return false if @skill.nil? 
      return false if @user.dead?
      # Base -------------------------------------------------------------------
      return false if !@multi_hit and @targets_done.include?(target) 
      return false if !@ignore_p_target and !@pr_target.nil? and @pr_target != target    
      # Scope ------------------------------------------------------------------
      return false if @skill.scope == 0
      return false if [11].include?(@skill.scope) and target != @user
      return false if [1,2,3,4,5,6].include?(@skill.scope) and target.dead?
      return false if [9,10].include?(@skill.scope) and !target.dead?
      return true if @skill.scope == 11 and target == @user_collision
      if @user_collision.is_a?(Game_Actor)
         return false if [1,2,3,4,5,6].include?(@skill.scope) and target.is_a?(Game_Actor)
         return false if [7,8,9,10].include?(@skill.scope) and target.is_a?(Game_Enemy)
      else  
         return false if [1,2,3,4,5,6].include?(@skill.scope) and target.is_a?(Game_Enemy)
         return false if [7,8,9,10].include?(@skill.scope) and target.is_a?(Game_Actor)
      end        
      return true if [9,10].include?(@skill.scope) and target.dead?
      # Knockback --------------------------------------------------------------
      return false if @collision_wait_duration > 0
      return true if @auto_target
      return false if target.f_damage[2] > 0
      return false if target.f_knockback[1] > 0
      unless @ignore_knockback
          return false if target.f_knockback[2] > 0
          return false if target.f_knockback[3] > 0
      end
      # ------------------------------------------------------------------------
      return true 
  end 
  
end

#==============================================================================
# ■ Sprite Skills
#==============================================================================
class Sprite_Skills < Sprite_Base
  
  #--------------------------------------------------------------------------
  # ● Update Movement
  #--------------------------------------------------------------------------             
  def update_movement
      if !@pr_target.nil?
         self.x = @pr_target.screen_x
         self.y = @pr_target.screen_y - @pr_target.f_body_height2 - 12        
      elsif @on_target and !@user_collision.f_target.nil?
         self.x = @user_collision.f_target.screen_x
         self.y = @user_collision.f_target.screen_y - @user_collision.f_target.f_body_height2 - 12          
      elsif @np.nil?
         self.x = @user.screen_x
         self.y = @user.screen_y - @user.f_body_height2 - 12       
      else
        unless @piercing[1]
           self.x += @np[0] 
           self.y += @np[1]
        end
      end
  end
    
end

#==============================================================================
# ■ Sprite Skills
#==============================================================================
class Sprite_Skills < Sprite_Base
  
  #--------------------------------------------------------------------------
  # ● Execute Effect
  #-------------------------------------------------------------------------- 
  def execute_effect(target, item)
      target.f_damage = [20,item,5,false,@direction,1,target.f_grv_speed + 2,20,10,@hit_animation_id]
      target.f_knockback[1] = 22
      target.f_guard[1] = false
      @targets_done.push(target) if !@multi_hit and !@targets_done.include?(target)
      if apply_reflect_effect?(target, item)
         apply_reflect_effect(target, item)
      elsif apply_guard_effect?(target, item)
         if target.f_guard[0] == 1
            apply_guard_effect(target, item)
         else
            target.f_guard[1] = true
            apply_item_effects_f(target, item)
         end   
      else  
         apply_item_effects_f(target, item)
      end   
      effects_after_damage(target, item)
   end
  
  #--------------------------------------------------------------------------
  # ● Apply Reflect Effect
  #-------------------------------------------------------------------------- 
  def apply_reflect_effect(target, item)
      @user_collision = target
      @collision_wait_duration = 5
      self.mirror = @direction == 0 ? true : false
      @direction = @direction == 0 ? 1 : 0
      @np[0] = -@np[0]
      @np[1] = -@np[1]
      target.damage.push(["Reflect","String"]) if $imported[:mog_damage_popup]
  end
      
  #--------------------------------------------------------------------------
  # ● Apply Reflect Effect?
  #-------------------------------------------------------------------------- 
  def apply_reflect_effect?(target, item)
      return false if @np.nil?
      return false if @user_synchronize
      return false if @ignore_reflect
      return false if @skill_type == 1
      return false if target.f_direction == @direction
      return target.f_reflect?
  end  
    
  #--------------------------------------------------------------------------
  # ● Apply Guard Effect?
  #-------------------------------------------------------------------------- 
  def apply_guard_effect?(target, item)
      return false if !target.f_mov_guarding?
      return false if @ignore_guard
     # return false if @ignore_knockback
      return false if @direction == target.f_direction
      #return false if @skill_type == 1
      return true
  end
  
  #--------------------------------------------------------------------------
  # ● Apply Guard Effect?
  #-------------------------------------------------------------------------- 
  def apply_guard_effect(target, item)
      target.f_knockback[4] = 20 
      target.execute_target_animation(@user, item)
      target.damage.push(["Guard","String"]) if $imported[:mog_damage_popup]
  end
 
  #--------------------------------------------------------------------------
  # ● Effects After Damage
  #-------------------------------------------------------------------------- 
   def effects_after_damage(target, item)
       @user.last_target_index = target.index
       effect_for_dead(target, item) if target.dead?
   end    
       
  #--------------------------------------------------------------------------
  # ● Effects For Dead
  #-------------------------------------------------------------------------- 
   def effect_for_dead(target, item)
       target.f_clear_poses
       target.f_action_clear
       BattleManager.next_actor_index(1) if target == @user
       if $game_party.all_dead? or $game_troop.all_dead?
          $game_temp.fmb_phase_data = [1,90]
          RPG::BGM.fade(2000)
       end
   end    
   
  #--------------------------------------------------------------------------
  # ● Apply Skill/Item Effect
  #--------------------------------------------------------------------------
  def apply_item_effects_f(target, item)
      target.item_apply(@user, item)
  end  

end

#==============================================================================
# ■ Spriteset Battle
#==============================================================================
class Spriteset_Battle
  
  #--------------------------------------------------------------------------
  # ● Initialize
  #--------------------------------------------------------------------------             
  alias mog_fmbs_initialize initialize
  def initialize
       mog_fmbs_initialize
       BattleManager.set_f_targets(battler_sprites)
       create_f_cursor
       create_f_cursor_actor
       create_f_escape       
  end
  
  #--------------------------------------------------------------------------
  # ● Dispose
  #--------------------------------------------------------------------------             
  alias mog_fmbs_dispose dispose
  def dispose
      mog_fmbs_dispose
      BattleManager.set_f_targets(nil)
      dispose_f_cursor
      dispose_f_cursor_actor
      dispose_f_escape
  end
  
  #--------------------------------------------------------------------------
  # ● Update
  #--------------------------------------------------------------------------             
  alias mog_fmbs_spriteset_update update
  def update
      update_f_cursor
      update_f_cursor_actor
      update_f_escape
      mog_fmbs_spriteset_update
  end

  #--------------------------------------------------------------------------
  # ● Create f Cursor Actor
  #--------------------------------------------------------------------------             
  def create_f_cursor_actor
      return if !$game_system.fmbs_data[0]
      return if $game_party.members.empty?    
      @f_cursor_actor = Sprite.new
      @f_cursor_actor.bitmap = Cache.system("Battle_Cursor_Actor")    
      @f_cursor_actor.z = 150 ; @f_cursor_actor.opacity = 0
      @f_capos = [-(@f_cursor_actor.bitmap.width / 2) + MOG_LMBS::CURSOR_ACTOR_POSITION[0],
      -@f_cursor_actor.bitmap.height + MOG_LMBS::CURSOR_ACTOR_POSITION[1]
      ]
  end
  
  #--------------------------------------------------------------------------
  # ● Dispose f Cursor Actor
  #--------------------------------------------------------------------------             
  def dispose_f_cursor_actor
      return if @f_cursor_actor.nil?
      @f_cursor_actor.bitmap.dispose
      @f_cursor_actor.dispose
  end
  
  #--------------------------------------------------------------------------
  # ● Update f Cursor Actor
  #--------------------------------------------------------------------------             
  def update_f_cursor_actor
      return if @f_cursor_actor.nil?
      $game_temp.f_actor_cursor_d -= 1 if $game_temp.f_actor_cursor_d > 0
      if f_cursor_actor_visible?
        @f_cursor_actor.opacity += 25
      else
        @f_cursor_actor.opacity -= 10
      end
      if !BattleManager.active_actor.nil?
         fxc = BattleManager.active_actor.screen_x + @f_capos[0]
         fxy = BattleManager.active_actor.screen_y - BattleManager.active_actor.f_body_height + @f_capos[1]
         @f_cursor_actor.x = fxc
         @f_cursor_actor.y = fxy
      end  
      if $imported[:mog_battle_camera]
         @f_cursor_actor.ox = $game_temp.viewport_oxy[0]
         @f_cursor_actor.oy = $game_temp.viewport_oxy[1]
      end
  end
  
  #--------------------------------------------------------------------------
  # ● F Cursor Actor Visible?
  #--------------------------------------------------------------------------             
  def f_cursor_actor_visible?
      return false if BattleManager.active_actor.nil?
      return false if $game_temp.battle_end
      unless !MOG_LMBS::CURSOR_ACTOR_FADE_EFFECT
        return false if $game_temp.f_actor_cursor_d == 0
      end
      return true
  end
  
  #--------------------------------------------------------------------------
  # ● Create Battle Cursor
  #--------------------------------------------------------------------------             
  def create_f_cursor
      return if !$game_system.fmbs_data[0]
      return if $game_party.members.empty?
      @f_cursor_battler = nil
      @f_cursor = Sprite.new
      @f_cursor.bitmap = Cache.system("Battle_Cursor")
      @f_oxy = [@f_cursor.bitmap.width / 2,@f_cursor.bitmap.height / 2]
      @f_cursor.z = 150
      @f_cursor.visible = false
      @f_cursor_pos = MOG_LMBS::CURSOR_POSITION
      @f_cursor_name = Sprite.new
      @f_cursor_name.bitmap = Bitmap.new(120,32)
      @f_cursor_name.z = @f_cursor.z + 1
      @f_cursor_name.visible = false
      @f_cursor_name_pos = MOG_LMBS::CURSOR_NAME_POSITION
  end
  
  #--------------------------------------------------------------------------
  # ● F Refresh Cursor Name
  #--------------------------------------------------------------------------             
  def f_refresh_cursor_name
      @f_cursor_battler = $game_temp.f_cursor_target
      @f_cursor_name.bitmap.clear
      @f_cursor_name.bitmap.draw_text(0,0,120,32,$game_temp.f_cursor_target.name,1)
  end
  
  #--------------------------------------------------------------------------
  # ● Dispose F Cursor
  #--------------------------------------------------------------------------             
  def dispose_f_cursor
      return if @f_cursor.nil?
      @f_cursor.bitmap.dispose
      @f_cursor.dispose
      @f_cursor_name.bitmap.dispose
      @f_cursor_name.dispose
  end
  
  #--------------------------------------------------------------------------
  # ● Update f Cursor
  #--------------------------------------------------------------------------             
  def update_f_cursor
      return if @f_cursor.nil?
      @f_cursor.visible = f_cursor_visible?
      @f_cursor_name.visible = @f_cursor.visible
      return if !@f_cursor.visible
      if !$game_temp.f_cursor_target.nil?
          f_sprite_move(@f_cursor,0,@f_cursor.x,$game_temp.f_cursor_target.screen_x + @f_cursor_pos[0])
          f_sprite_move(@f_cursor,1,@f_cursor.y,$game_temp.f_cursor_target.screen_y + @f_cursor_pos[1])
          @f_cursor_name.x = @f_cursor.x + @f_cursor_name_pos[0] - 60
          @f_cursor_name.y = @f_cursor.y + @f_cursor_name_pos[1]
          f_refresh_cursor_name if @f_cursor_battler != $game_temp.f_cursor_target
      end  
      update_f_cursor_oxy if $imported[:mog_battle_camera]
      $game_temp.f_cursor_target = BattleManager.active_actor if $game_temp.f_cursor_target.nil?
  end
  
  #--------------------------------------------------------------------------
  # ●  F Sprite Move
  #--------------------------------------------------------------------------      
  def f_sprite_move(sprite,type,cp,np)
      sp = 5 + ((cp - np).abs / 10)
      if cp > np ;    cp -= sp ; cp = np if cp < np
      elsif cp < np ; cp += sp ; cp = np if cp > np
      end     
      sprite.x = cp if type == 0 ; sprite.y = cp if type == 1
  end    
  
  #--------------------------------------------------------------------------
  # ● F Cursor Visible?
  #--------------------------------------------------------------------------             
  def f_cursor_visible?
      return false if $game_temp.f_cursor_target.nil?
      return false if ![3,4,7].include?($game_temp.fmb_menu_phase[1])
      return true
  end
  
  #--------------------------------------------------------------------------
  # ● Update f Cursor OXY
  #--------------------------------------------------------------------------             
  def update_f_cursor_oxy
      @f_cursor.ox = $game_temp.viewport_oxy[0] + @f_oxy[0]
      @f_cursor.oy = $game_temp.viewport_oxy[1] + @f_oxy[1]
      @f_cursor_name.ox = $game_temp.viewport_oxy[0]
      @f_cursor_name.oy = $game_temp.viewport_oxy[1]
  end
 
  #--------------------------------------------------------------------------
  # ● Create F Escape
  #--------------------------------------------------------------------------             
  def create_f_escape
      return if $game_party.members.empty?
      @f_escape_meter = Cache.system("F_Escape_B")
      @f_escape_cw = @f_escape_meter.width
      @f_escape_ch = @f_escape_meter.height
      @f_escape_a = Sprite.new
      @f_escape_a.bitmap = Cache.system("F_Escape_A")
      @f_escape_a.z = 151
      @f_escape_a.x = MOG_LMBS::ESCAPE_SPRITE_POSITION[0]
      @f_escape_a.y = MOG_LMBS::ESCAPE_SPRITE_POSITION[1]
      @f_escape_a.ox = @f_escape_a.bitmap.width / 2
      @f_escape_a.opacity = 0
      @f_escape_b = Sprite.new
      @f_escape_b.bitmap = Bitmap.new(@f_escape_cw,@f_escape_ch)
      @f_escape_b.z = 152
      @f_escape_b.x = @f_escape_a.x + MOG_LMBS::ESCAPE_SPRITE_METER_POSITION[0]
      @f_escape_b.y = @f_escape_a.y + MOG_LMBS::ESCAPE_SPRITE_METER_POSITION[1]
      @f_escape_b.ox = @f_escape_b.bitmap.width / 2
      @f_escape_b.opacity = 0
      update_f_escape_rect
  end
  
  #--------------------------------------------------------------------------
  # ● Dispose F Escape
  #--------------------------------------------------------------------------             
  def dispose_f_escape
      return if @f_escape_a.nil?
      @f_escape_a.bitmap.dispose
      @f_escape_a.dispose
      @f_escape_b.bitmap.dispose
      @f_escape_b.dispose      
  end
  
  #--------------------------------------------------------------------------
  # ● Update F Escape
  #--------------------------------------------------------------------------             
  def update_f_escape
      return if @f_escape_a.nil?      
      update_f_escape_visible
      return if BattleManager.active_actor.nil?
      return if @f_escape_a.opacity == 0
      update_f_escape_rect
  end

  #--------------------------------------------------------------------------
  # ● Update F Escape Visible
  #--------------------------------------------------------------------------             
  def update_f_escape_visible
      return if @f_escape_a.nil?
      if $game_temp.f_escape_phase[2] > 0
         $game_temp.f_escape_phase[2] -= 1
         $game_temp.f_escape_phase[1] = 0 if $game_temp.f_escape_phase[2] == 0
      end   
      if f_escape_visible?
         @f_escape_a.opacity += 15
         @f_escape_a.visible = true
      else   
         @f_escape_a.opacity -= 10
         @f_escape_a.visible = false if @f_escape_a.opacity == 0
      end
      @f_escape_b.opacity = @f_escape_a.opacity
      @f_escape_b.visible = @f_escape_a.visible
  end
  
  #--------------------------------------------------------------------------
  # ● F Escape Visible?
  #--------------------------------------------------------------------------             
  def f_escape_visible?
      return false if $game_temp.battle_end
      return false if $game_temp.f_escape_phase[1] == 0
      return false if $game_temp.f_escape_phase[2] == 0
      return false if BattleManager.active_actor.nil?
      return false if BattleManager.active_actor.dead?
      return true
  end
  
  #--------------------------------------------------------------------------
  # ● Update f Escape Rect
  #--------------------------------------------------------------------------             
  def update_f_escape_rect
      @f_escape_b.bitmap.clear
      w = @f_escape_b.width * $game_temp.f_escape_phase[1] / BattleManager.active_actor.f_espace_duration
      e_rect = Rect.new(0,0,w,@f_escape_ch)
      @f_escape_b.bitmap.blt(0,0,@f_escape_meter,e_rect)
  end
  
end

if $imported[:mog_battle_camera]
#==============================================================================
# ■ Spriteset Battle
#==============================================================================
class Spriteset_Battle 

 #--------------------------------------------------------------------------
 # ● BCamera Center
 #-------------------------------------------------------------------------- 
 alias mog_fmbs_bcamera_center? bcamera_center?
 def bcamera_center?
     return false if $game_system.fmbs_data[0]
     mog_fmbs_bcamera_center?
 end
 
 #--------------------------------------------------------------------------
 # ● BC Move To
 #-------------------------------------------------------------------------- 
 alias mog_fmbs_bc_move_to bc_move_to
 def bc_move_to(type,cp,np)
     return if [2,4].include?($game_temp.fmb_phase_end)
     mog_fmbs_bc_move_to(type,cp,np)
 end
 
end

#==============================================================================
# ■ Sprite Battler
#==============================================================================
class Sprite_Battler < Sprite_Base
  
  #--------------------------------------------------------------------------
  # ● Camera Range
  #--------------------------------------------------------------------------  
  def camera_range
      return [[$game_system.battle_camera_range.abs, 100].min, 0].max
  end    
  
  #--------------------------------------------------------------------------
  # ● Force Target Dmg Temp
  #--------------------------------------------------------------------------  
  alias mog_fmbs_force_target_dmg_temp? force_target_dmg_temp?
  def force_target_dmg_temp?
      return false if $game_system.fmbs_data[0]
      mog_fmbs_force_target_dmg_temp?
  end    
    
  #--------------------------------------------------------------------------
  # ● Update BC Cursor
  #--------------------------------------------------------------------------  
  alias mog_fmbs_update_bc_cursor update_bc_cursor
  def update_bc_cursor
      if $game_system.fmbs_data[0] and !BattleManager.active_actor.nil?
         if !$game_temp.f_cursor_target.nil? and [3,4,7].include?($game_temp.fmb_menu_phase[1])
             $game_temp.bc_data[2] = $game_temp.f_cursor_target.screen_x 
             $game_temp.bc_data[3] = $game_temp.f_cursor_target.screen_y - $game_temp.f_cursor_target.f_ground / 2
             return
        else
           if BattleManager.active_actor == @battler
              $game_temp.bc_data[2] = self.x 
              $game_temp.bc_data[3] = self.y - @battler.f_ground / 2
              return
            end
        end
      end    
      mog_fmbs_update_bc_cursor
  end
end     
  
end


if $imported[:mog_atb_skill_name]
#==============================================================================
# ■ Game_Battler
#==============================================================================
class Game_Battler < Game_BattlerBase
  
  #--------------------------------------------------------------------------
  # ● F Set Action Data
  #--------------------------------------------------------------------------             
  alias mog_fmbs_f_set_action_data f_set_action_data
  def f_set_action_data(skill,pr_target,type)
      mog_fmbs_f_set_action_data(skill,pr_target,type)
      f_set_skill_name(skill) if f_set_skill_name?(skill)
  end
    
  #--------------------------------------------------------------------------
  # ● F Set Skill Name
  #--------------------------------------------------------------------------             
  def f_set_skill_name?(item)
      return false if item.nil?
      return false if self != BattleManager.active_actor
      if item.is_a?(RPG::Skill)
         return false if MOG_ATB_SKILL_NAME::DISABLE_SKILL_NAME.include?(item.id)
         return false if item.id == attack_skill_id
      elsif item.is_a?(RPG::Item)
         return false if MOG_ATB_SKILL_NAME::DISABLE_ITEM_NAME.include?(item.id)
      end
      return true
  end
  
  #--------------------------------------------------------------------------
  # ● F Set Skill Name
  #--------------------------------------------------------------------------             
  def f_set_skill_name(item)
      $game_temp.skill_name_bh = [item,true]
  end

end  
  
#==============================================================================
# ■ Spriteset Battle
#==============================================================================
class Spriteset_Battle

  #--------------------------------------------------------------------------
  # ● F Set Skill Name
  #--------------------------------------------------------------------------             
  alias mog_fmbs_refresh_skill_name refresh_skill_name
  def refresh_skill_name
      mog_fmbs_refresh_skill_name
      if BattleManager.active_actor.sprite_data[11][1] > 0
      @skill_text[1] = BattleManager.active_actor.sprite_data[11][1] + 20 if !BattleManager.active_actor.nil?
      end
  end
  
end

end


# -----------------------------------------------------------------------------
if $imported[:mog_battle_cry] 
#==============================================================================
# ■ Game_Battler
#==============================================================================
class Game_Battler < Game_BattlerBase  
  
  #--------------------------------------------------------------------------
  # ● F Set Action Data
  #--------------------------------------------------------------------------             
  alias mog_battle_cry_f_set_action_data f_set_action_data
  def f_set_action_data(skill,pr_target,type)
      mog_battle_cry_f_set_action_data(skill,pr_target,type)
      if self.is_a?(Game_Actor) and skill.is_a?(RPG::Item)
          execute_battle_cry(5, skill.id, self)
      else    
          execute_battle_cry(2, skill.id, self)
      end    
  end  

end  
  
#==============================================================================
# ■ Scene Battle
#==============================================================================
class Scene_Battle < Scene_Base
  
  #--------------------------------------------------------------------------
  # ● Next Actor Effect
  #--------------------------------------------------------------------------             
  alias mog_battle_cry_next_actor_effect next_actor_effect
  def next_actor_effect
      mog_battle_cry_next_actor_effect
      execute_battle_cry(7, nil, BattleManager.active_actor) unless BattleManager.active_actor.f_mov_acting?
  end
  
  #--------------------------------------------------------------------------
  # ● Update Basic
  #--------------------------------------------------------------------------             
  alias mog_battlecry_fmbs_update update
  def update
      execute_battle_cry_start
      mog_battlecry_fmbs_update
  end  
  
end
  
end

# -----------------------------------------------------------------------------
if $imported[:mog_ougi_animation]
  
#==============================================================================
# ■ Game_Battler
#==============================================================================
class Game_Battler < Game_BattlerBase  
  
  #--------------------------------------------------------------------------
  # ● F Set Action Data
  #--------------------------------------------------------------------------             
  alias mog_ougi_f_set_action_data f_set_action_data
  def f_set_action_data(skill,pr_target,type)
      mog_ougi_f_set_action_data(skill,pr_target,type)
      update_sp_animation if skill.note =~ /<Ougi Animation>/
  end  

  #--------------------------------------------------------------------------
  # ● Update SP Animation
  #--------------------------------------------------------------------------  
  def update_sp_animation
      special_animation = Ougi_Animation.new(self)
      loop do
          @ougi_ref = true
          special_animation.update ; Graphics.update
          break if special_animation.phase == 3
      end
      special_animation.dispose
  end  
  
end

end

#-------------------------------------------------------------------------------
if $imported[:mog_battler_result]
#==============================================================================
# ■ Battle Result
#==============================================================================
class Battle_Result
  
  #--------------------------------------------------------------------------
  # ● Initialize
  #--------------------------------------------------------------------------
  alias mog_fmbs_result_initialize initialize
  def initialize
      $game_temp.fmb_phase_end = 1
      mog_fmbs_result_initialize
  end
  
end

end