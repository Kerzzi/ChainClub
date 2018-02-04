class Admin::SectionsController < Admin::BaseController
  before_action :find_section, only: [:show, :edit, :update, :destroy]

  def index
    @sections = Section.all.recent
  end

  def show
  end

  def new
    @section = Section.new
  end

  def edit
  end

  def create
    @section = Section.new(params[:section].permit!)

    if @section.save
      redirect_to(admin_sections_path, notice: "Section was successfully created.")
    else
      render action: "new"
    end
  end

  def update
    if @section.update(params[:section].permit!)
      redirect_to(admin_sections_path, notice: "Section was successfully updated.")
    else
      render action: "edit"
    end
  end

  def destroy
    @section.destroy

    redirect_to(admin_sections_url)
  end

  private

  def find_section
    @section = Section.find(params[:id])
  end
end
