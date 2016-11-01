class API::PlayersController < ::API::APIController

  skip_before_action :require_session_token, only: [:auth_callback, :auth]

  before_action :find_player, except: [:index, :auth_callback]

  before_action -> { require_player(@player) }, except: [:index, :show, :auth_callback]

  before_action :pull_activity, only: [:show,
                                       :update,
                                       :claim_steps,
                                       :claim_active_minutes,
                                       :profile,
                                       :steps,
                                       :activities,
                                       :buy,
                                       :equip,
  ]

  # GET /players
  def index
    @players = Player.all
    render json: {
      status: 'ok',
      players: @players.as_json,
    }
  end

  # GET /players/1
  def show
    output = {
      status: 'ok',
      player: @player.as_json,
    }
    output[:devices] = @player.fitbit.get_devices if @player.authenticated?
    render json: output
  end

  # PATCH/PUT /players/1
  def update
    @player.update!(player_params)
    render :json => {
      status: 'ok',
      player: @player.as_json,
    }
  end

  def auth
    redirect_to @player.begin_auth # todo: test
  end

  # note: this does not require login auth since it's called via redirect from fitbit.com
  def auth_callback
    player = Player.find_by_anti_forgery_token(params[:state])
    player.finish_auth(params[:code]) # todo: test
    # redirect_to profile_player_path(player)
    redirect_to admin_players_path
  end

  def claim_steps
    @player.claim_steps!
    render_player
  end

  def claim_active_minutes
    @player.claim_active_minutes!
    render_player
  end


  def buy
    # require_player(@player) || return # todo: do this with a before_action

    if params['gear']
      @player.buy_gear!(params['gear']['name'])
    elsif params['ammo']
      @player.buy_ammo!(params['ammo']['name'])
    else
      raise "Must specify buying either gear or ammo"
    end
    render_player
  end

  def equip
    @player.equip_gear!(params['gear']['name'])
    render_player
  end

  # just for demo
  def steps
    puts "fetching user activities"
    # output['activity-types'] = @player.fitbit.get('/1/activities.json') # the whole list -- big
    output = {}
    a_while_ago = (Time.current - 3.month).strftime('%F')
    yesterday = (Time.current - 1.day).strftime('%F')
    output = @player.fitbit.get("/1/user/-/activities/steps/date/#{a_while_ago}/#{yesterday}.json")
    render json: output
  end

  # just for demo
  def activities
    puts "fetching user activities"
    # output['activity-types'] = @player.fitbit.get('/1/activities.json') # the whole list -- big
    render json: @player.fitbit.get_activities(Date.today.strftime('%F'))
  end

  # just for demo
  def profile
    puts "fetching user profile"
    render json: @player.fitbit_profile
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def player_params
    params.require(:player).permit(:name, :password, :team, :embodied)
  end
end
