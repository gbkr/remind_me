class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, except: [:home, :unconfirmed]

  def index
    events = current_user.events
    render json: events
  end

  def show
  end

  def new
    event = current_user.events.new
    render json: event
  end

  def edit
  end

  def create
    event = current_user.events.create(event_params)
    date = Date.parse(event_params[:date])
    event.update_attribute(:date, date)
    render json: event
  end

  def update
    event = @event.update(event_params)
    @event.update_attribute(:date, Date.parse(event_params[:date]))
    render json: event
  end

  def destroy
    @event.destroy
    render json: { status: 200 }
  end

  private

  def set_event
    begin
      @event = current_user.events.find(params[:id])
    rescue
      render text: "Unauthorized"
    end
  end

  def event_params
    params.require(:event).permit([:name, :details, :date])
  end
end
