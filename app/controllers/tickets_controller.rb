class TicketsController < ApplicationController
  before_action :set_ticket, only: [:edit, :show]
  # layout 'pdf', only: [:show]

  # GET /tickets
  def index
    @tickets = Ticket.all
  end

  # GET /tickets/new
  def new
    @ticket = Ticket.new
  end

  # POST /tickets
  def create
    @ticket = Ticket.new(ticket_params)

    if @ticket.save
      redirect_to root_path, notice: 'Ticket was successfully created.'
    else
      render :new
    end
  end

  def show
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: @ticket.number,
               locals: {ticket: @ticket}
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_ticket
    @ticket = Ticket.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def ticket_params
    params.require(:ticket).permit(:email, :price, :scene, :number)
  end
end
