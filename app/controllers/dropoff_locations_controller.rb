class DropoffLocationsController < ApplicationController
  before_action :set_dropoff_location, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @dropoff_locations = DropoffLocation.all
    respond_with(@dropoff_locations)
  end

  def show
    respond_with(@dropoff_location)
  end

  def new
    @dropoff_location = DropoffLocation.new
    respond_with(@dropoff_location)
  end

  def edit
  end

  def create
    @dropoff_location = DropoffLocation.new(dropoff_location_params)
    @dropoff_location.save
    respond_with(@dropoff_location)
  end

  def update
    @dropoff_location.update(dropoff_location_params)
    respond_with(@dropoff_location)
  end

  def destroy
    @dropoff_location.destroy
    respond_with(@dropoff_location)
  end

  private
    def set_dropoff_location
      @dropoff_location = DropoffLocation.find(params[:id])
    end

    def dropoff_location_params
      params[:dropoff_location]
    end
end
