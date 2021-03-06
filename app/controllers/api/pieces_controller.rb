module API
  class PiecesController < APIController
    before_action :find_player
    before_action :find_piece, only: [:show, :edit, :update, :destroy]

    before_action -> { require_player(@player) }


    # POST /pieces
    def create
      begin
        @piece = @player.set_piece(piece_params)
        render json: {status: 'ok'}, status: :created
      end
    end

    private

    def find_piece
      @piece = Piece.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def piece_params
      params.require(:piece).permit(
        :body_type,
        :role,
        :path,
        :face,
        :hair,
        :skin_color,
        :hair_color,
        :health,
        :speed,
        :range,
      )
    end
  end
end
