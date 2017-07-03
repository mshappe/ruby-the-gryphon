class ReignsController < ApplicationController
  skip_authorization_check only: [:reign_images]

  downloads_files_for :reign, :reign_image
end
