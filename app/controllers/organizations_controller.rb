class OrganizationsController < ApplicationController
  def index
    organizations = Organization.all
    render json: {organizations: organizations}
  end
end
