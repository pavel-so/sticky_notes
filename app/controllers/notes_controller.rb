class NotesController<ApplicationController
  layout nil
  respond_to :js,:html

  def index
    @notes= Note.all(:order=>'created_at')
    respond_with(@notes)
  end

  def show
    @note = Note.find(params[:id])
    respond_with(@note)
  end

  def new
    @note= Note.new
    respond_with(@note)
  end

  def create
    @note= Note.new(params[:note])
    if @note.save
      render :action=>'show'
    else
      render :action=>'error'
    end
  end

  def edit
    @note = Note.find(params[:id])
    respond_with(@note)
  end

  def update
    @note = Note.find(params[:id])
    if @note.update_attributes(params[:note])
      respond_with(@note)
    else
      render :action=>'error'
    end
  end

  def destroy
    @note=Note.find(params[:id])
    @note.destroy
  end
end

