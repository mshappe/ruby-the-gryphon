class LibrarySectionsController < ApplicationController
  load_and_authorize_resource

  def index
    @q = LibraryDocument.ransack(nil)
    @library_sections = LibrarySection.order(order: :asc)
  end
end