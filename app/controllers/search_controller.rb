class SearchController < ApplicationController
  def create
    ServicesIndex.import
    query = ServicesIndex.query(multi_match: {
                                       query: params[:q],
                                       fields: %i[name description email website telephone email],
                                       fuzziness: 'AUTO'
                                     })
    if query.any?
      render json: { services: query.objects } # , each_serializer: Organization::IndexSerializer
    else
      render json: { message: 'Your search yielded no results' }, status: 404
    end
  end
end
