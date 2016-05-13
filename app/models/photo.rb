
class Photo < ActiveRecord::Base
    mount_uploader :image, ImageUploader
    def doge_array
      doge = Dogeify.new
      doge.process(self.caption).split('.')
    end
end
