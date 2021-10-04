module ButtonsService
  def self.update(buttons)
    unless buttons.empty?
      buttons.each do |button|
        Cta.find(button[:id]).update(text: button[:text], link: button[:link])
      end
    end
  end
end
