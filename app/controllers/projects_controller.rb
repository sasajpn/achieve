class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :admin_user, only: [:invite_form, :inviting_user, :edit, :change_admin, :destroy]
  before_action :project_member, only: [:show]
  before_action :exist_project_member, only: [:destroy]

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @user = current_user
    @admin_user = User.find(@project.admin_id)
    @users = @project.project_member.reject{|admin_user| admin_user == @admin_user }
    @tasks = @project.tasks
    @customers = @project.customers
  end

  # GET /projects/new
  def new
    @project = current_user.projects.build
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = current_user.projects.build(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'プロジェクトを作成しました。' }
        format.json { render :show, status: :created, location: @project }
        @project.add_member!(current_user)
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
      @project.destroy
      flash[:notice] = "プロジェクトを削除しました。"
      redirect_to root_path
  end
  
  def invite_form
    @user = current_user
    @project = Project.find(params[:id])
    @project_members = @project.project_member
    @users = User.all.reject{ |user| user == current_user }
    
  end
  
  def inviting_user
    @project = Project.find(params[:id])
  end
  
  def project_member
    @project = Project.find(params[:id])
    @users = @project.project_member
    @admin_user = User.find(@project.admin_id)
  end
  
  def change_admin
    @project = Project.find(params[:id])
    @admin = User.find(@project.admin_id)
    @project_members = @project.project_member.reject{|admin| admin == @admin }
  end
  
  def change_admin_update
    @project = Project.find(params[:id])
    if @project.update(admin_params)
      flash[:notice] = "管理者を変更しました。"
      redirect_to project_path(@project)
    end
  end
    

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name, :information)
    end
    
    def admin_params
      params.require(:project).permit(:admin_id)
    end
    
    def admin_user
      @project = Project.find(params[:id])
      @admin_user = User.find(@project.admin_id)
      if @admin_user != current_user
        flash[:alert] = "あなたはこのプロジェクトの管理者ではありません。"
        redirect_to project_path(@project)
      end
    end
    
    def project_member
      @project = Project.find(params[:id])
      @project_members = @project.project_member
      unless @project_members.include?(current_user)
        flash[:alert] = "あなたはこのプロジェクトのメンバーではありません。"
        redirect_to root_path
      end
    end
    
    def exist_project_member
      @project = Project.find(params[:id])
      @admin = User.find(@project.admin_id)
      @project_members = @project.project_member.reject{|admin| admin == @admin }
      if @project_members.any?
        flash[:alert] = "プロジェクトにメンバーがいます。"
        redirect_to project_path(@project)
      end
    end
end
