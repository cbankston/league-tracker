class SummonerTrackerController < ApplicationController
  before_action :authenticate_user!

  def index
    render locals: {
      summoners: TrackedSummonerRepo.new.all(current_user).map(&:summoner)
    }
  end

  def show
    render locals: {
      summoner: find_summoner
    }
  end

  def new
    render locals: {
      form: SummonerTrackerForm.new(user: current_user)
    }
  end

  def create
    form = SummonerTrackerForm.new(create_params)
    if form.save
      redirect_to summoner_tracker_index_path, success: t('summoner_tracker.flash.added_success')
    else
      render :new, locals: {
        form: form
      }
    end
  end

  def destroy
    find_summoner.destroy

    redirect_to summoners_path, success: t('summoners.flash.deleted_success')
  end

  private

  def create_params
      params[:summoner_tracker_form].merge({
        user: current_user
      })
  end

  def find_summoner
    Summoner.find("#{params[:region]}-#{params[:id]}")
  end

end
