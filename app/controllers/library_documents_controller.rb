class LibraryDocumentsController < ApplicationController
  load_and_authorize_resource

  def show; end

  def search
    @q = LibraryDocument.ransack(params[:q])
    @library_documents = @q.result.order(order: :asc)
    respond_with @library_documents
  end 
end