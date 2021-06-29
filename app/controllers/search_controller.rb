class SearchController < ApplicationController
  def create
    ServicesIndex.import
    query = ServicesIndex.query(multi_match: {
                                  query: params[:q],
                                  fields: %i[name description email website telephone],
                                  fuzziness: 'AUTO'
                                })

    if query.any?
      render json: { services: serialize_collection(query.objects) }
    else
      render json: { message: 'Your search yielded no results' }, status: 404
    end
  end

  private

  def serialize_collection(objects)
    ActiveModel::SerializableResource.new(
      objects,
      each_serializer: Service::IndexSerializer,
      adapter: :attributes
    )
  end
end
