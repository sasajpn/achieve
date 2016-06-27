class ProjectRelationsController < ApplicationController
    respond_to :html, :js
    
    def create_invite
        @user = User.find(params[:project_relation][:invited_id])
        @project = Project.find(params[:id])
        @project.invite!(@user)
        redirect_to invite_form_project_path(@project)
    end
    
    def destroy_invite
        @project = ProjectRelation.find(params[:id]).inviting
        @user = ProjectRelation.find(params[:id]).invited
        @project.uninvite!(@user)
        redirect_to invite_form_project_path(@project)
    end
    
    def create_approve
        @project = Project.find(params[:project_relation][:approved_id])
        @user = User.find(params[:id])
        @user.approve!(@project)
        redirect_to user_path(@user)
    end
    
    def destroy_approve
    end
    
    
end
