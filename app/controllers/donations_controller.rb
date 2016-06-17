class DonationsController < ApplicationController
  before_action :set_donation, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @donations = Donation.all
    respond_with(@donations)
  end

  def show
    respond_with(@donation)
  end

  def new
    @donation = Donation.new
    respond_with(@donation)
  end

  def edit
  end

  def create
    @donation = Donation.new(donation_params)
    @donation.save
    respond_with(@donation)
  end

  def update
    @donation.update(donation_params)
    respond_with(@donation)
  end

  def destroy
    @donation.destroy
    respond_with(@donation)
  end

  private
    def set_donation
      @donation = Donation.find(params[:id])
    end

    def donation_params
      params[:donation]
    end
end
