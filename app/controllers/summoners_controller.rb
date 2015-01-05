class SummonersController < ApplicationController
  before_action :authenticate_user!

  def index
    render locals: {
      summoners: Summoner.all
    }
  end

  def show
    render locals: {
      summoner: find_summoner
    }
  end

  def create
    render :new
  end

  def destroy
    find_summoner.destroy

    redirect_to summoners_path, success: t('summoners.flash.deleted_success')
  end

  private

  def find_summoner
    Summoner.find(params[:id])
  end

end
