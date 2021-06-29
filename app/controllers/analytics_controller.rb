class AnalyticsController < ApplicationController
  before_action :get_statistics

  def index
    render json: { statistics: @statistics }
  end

  private

  def get_statistics
    @statistics = {}
    visits_stats
  end

  def visits_stats
    @statistics[:visits] = {
      total: Ahoy::Visit.count
    }
  end
end
