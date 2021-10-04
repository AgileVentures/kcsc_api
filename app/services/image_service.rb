module ImageService
  def self.attach(object, type, params)
    params[:image].present? && DecodeService.attach_image(params[:image],
                                                                    Image.create("#{type}": object,
                                                                                 alt_text: params[:alt]))
  end

  def self.update(object, type, params)
    object.image ||= Image.create("#{type}": object, alt_text: params[:alt])
    DecodeService.attach_image(params[:image], object.image) unless params[:image].include? 'http'
    object.image.update(alt_text: params[:alt])
  end
end
