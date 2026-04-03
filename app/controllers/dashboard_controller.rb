class DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :require_two_factor_verification

  def index
  end
end
