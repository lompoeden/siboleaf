class LabelsController < ApplicationController
  before_action :set_label, only: [:show, :edit, :update, :destroy]
    before_action :current_user
    before_action :check_user
  # GET /labels
  # GET /labels.json
  def index
    if logged_in? && current_user.admin?
    @labels = Label.all
  else
          redirect_to new_session_path
      end
  end

  # GET /labels/1
  # GET /labels/1.json
  def show
  end

  # GET /labels/new
  def new
    @label = Label.new
  end

  # GET /labels/1/edit
  def edit
  end

  # POST /labels
  # POST /labels.json
  def create
    @label = Label.new(label_params)
    #@label = current_user.labels.build(label_params)

    respond_to do |format|
      if @label.save
        redirect_to labels_path, notice: 'Label was successfully created.'
        else
            render :new
        end
    end

  # PATCH/PUT /labels/1
  # PATCH/PUT /labels/1.json
  def update
    respond_to do |format|
      if @label.update(label_params)
        format.html { redirect_to @label, notice: 'Label was successfully updated.' }
        format.json { render :show, status: :ok, location: @label }
      else
        format.html { render :edit }
        format.json { render json: @label.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /labels/1
  # DELETE /labels/1.json
  def destroy
    @label.destroy
    respond_to do |format|
      format.html { redirect_to labels_url, notice: 'Label was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_label
      @label = Label.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def label_params
      params.require(:label).permit(:name, :content, :user_id)
    end
  end

  def check_user
      unless current_user.admin?
        flash[:notice] = "reserved for admin only！"
        redirect_to new_session_path
      end
    end
end
