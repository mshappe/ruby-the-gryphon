class Manage::LibraryDocumentsController < Manage::ManagementController
  load_and_authorize_resource
  
  def show
  end

  def new
  end

  def edit
  end

  def create
    if @library_document.save
      flash[:notice] = 'New library document created'
    else
      flash[:error] = 'Library document could not be created'
    end
    respond_with @library_document, location: manage_path
  end
  
  def update
    @library_document.update_attributes(library_document_params)
    respond_with @library_document, location: manage_library_document_path(@library_document)
  end

  def destroy
    @library_document.destroy
    respond_with @library_document, location: manage_path
  end

  protected

  def library_document_params
    params.require(:library_document).permit(:title, :order, :library_section_id, :post_id, :attachment)
  end
end
