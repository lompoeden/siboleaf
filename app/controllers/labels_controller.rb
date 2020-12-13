class LabelsController < ApplicationController
    before_action :set_label, only: [:show, :edit, :update, :destroy]
    before_action :check_if_admin

    def index
        if logged_in? && current_user.admin?
            @labels = Label.all
        else
            redirect_to new_session_path
        end
    end

    def show
    end

    def new
        @label = Label.new
    end

    def edit
    end

    def create
        @label = Label.new(label_params)
        if @label.save
            redirect_to labels_path, notice: 'Label was successfully created.'
        else
            render :new
        end
    end

    def update
        if @label.update(label_params)
            redirect_to labels_path, notice: 'Label was successfully updated.'
        else
            render :edit
        end
    end

    def destroy
        if @label.destroy
            redirect_to labels_path, notice: 'Label was successfully destroyed.'
        else
            redirect_to labels_path, notice: 'can not delete the label'
        end
    end

    private
    def set_label
        @label = Label.find(params[:id])
    end

    def label_params
        params.require(:label).permit(:name, :content, :user_id)
    end

    def check_if_admin
        if !current_user.admin
            redirect_to new_session_path, notice: "you are not authorized to access this page"
        end
    end
  end
