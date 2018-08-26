# frozen_string_literal: true

class ReignsController < ApplicationController
  skip_authorization_check only: %i[reign_images view_reign_image]

  downloads_files_for :reign, :reign_image

  def view_reign_image
    @reign = Reign.find(params[:id])
  end
end
