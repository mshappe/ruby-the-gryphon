class Manage::LibrarySectionsController < Manage::ManagementController
  load_and_authorize_resource

  def show; end

  def new
    @next_order_default = LibrarySection.count + 1
  end

  def create
    if @library_section.save
      flash[:notice] = 'New library section created'
    else
      flash[:error] = 'Library section could not be created'
    end
    respond_with @library_section, location: manage_path
  end

  def update
    @library_section.update_attributes(library_section_params)
    respond_with @library_section, location: manage_library_section_path(@library_section)
  end

  def destroy
    @library_section.destroy
    respond_with @library_section, location: manage_path
  end
  
  protected

  def library_section_params
    params.require(:library_section).permit(:name, :order)
  end
end
