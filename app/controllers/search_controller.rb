class SearchController < ApplicationController
  def create
    OrganizationsIndex.import
    query = OrganizationsIndex.query(multi_match: {
                                       query: params[:q],
                                       fields: %i[name description email website telephone email],
                                       fuzziness: 'AUTO'
                                     })
    if query.any?
      render json: { organizations: query.objects } # , each_serializer: Organization::IndexSerializer
    else
      render json: { message: 'Your search yielded no results' }, status: 404
    end
  end
end
