class SearchController < ApplicationController
  before_action :authenticate_request

  def create
    ServicesIndex.import
    query = if !params.key?('category') || params['category'] == 'All'
              search(params['q'])
            else
              advanced_search(params['q'], params['category'])
            end

    if query.any?
      render json: { services: serialize_collection(query.objects) }
    else
      render json: { message: 'Your search yielded no results' }, status: 404
    end
  end

  private

  def serialize_collection(objects)
    ActiveModelSerializers::SerializableResource.new(
      objects,
      each_serializer: Service::IndexSerializer,
      adapter: :attributes
    )
  end

  def advanced_search(query, category)
    ServicesIndex.filter(multi_match: { query: category,
                                        fields: %i[category category_secondary] }).query(multi_match: {
                                                                                           query: query,
                                                                                           fields: %i[
                                                                                             name description email website telephone
                                                                                           ],
                                                                                           fuzziness: 'AUTO'
                                                                                         })
  end

  def search(query)
    ServicesIndex.query(multi_match: {
                          query: query,
                          fields: %i[
                            name description email website telephone
                          ],
                          fuzziness: 'AUTO'
                        })
  end
end
