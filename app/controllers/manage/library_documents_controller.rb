class Manage::LibraryDocumentsController < Manage::ManagementController
  load_and_authorize_resource

  before_action :get_posts, only: [:new, :edit]
  before_action :get_library_section, only: [:new]

  def show
  end

  def new
    @library_document = @library_section.library_documents.build
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

  def remove_attachment
    @library_document.update(attachment: nil)
    respond_with @library_document, location: edit_manage_library_document_path(@library_document)
  end

  protected

  def library_document_params
    params.require(:library_document).permit(:title, :order, :library_section_id, :post_id, :attachment)
  end

  def get_posts
    types = PostType.where(name: ['Resource Links', 'Handbooks'])
    @posts = Post.where(post_type: types)
  end

  def get_library_section
    @library_section = LibrarySection.find(params[:library_section_id])
  end
end
