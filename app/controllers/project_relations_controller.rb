class ProjectRelationsController < ApplicationController
    respond_to :html, :js
    
    after_action :sending_pusher, only: [:create_invite]
    after_action :invited_pusher, only: [:create_invite]
    
    def create_invite
        @user = User.find(params[:project_relation][:invited_id])
        @project = Project.find(params[:id])
        @project.invite!(@user)
        @notification = @project.notifications.create(recipient_id: @user.id, sender_id: current_user.id)
        flash[:notice] = "#{@user.name}さんをこのプロジェクトに招待しました。"
        redirect_to invite_form_project_path(@project)
    end
    
    def destroy_invite
        @project = ProjectRelation.find(params[:id]).inviting
        @user = ProjectRelation.find(params[:id]).invited
        @project.uninvite!(@user)
        flash[:notice] = "#{@user.name}さんの招待を取り消しました。"
        redirect_to(:back)
    end
    
    def create_approve
        @project = Project.find(params[:project_relation][:approved_id])
        @user = User.find(params[:id])
        @user.approve!(@project)
        flash[:notice] = "プロジェクトに参加しました。"
        redirect_to project_path(@project)
    end
    
    def destroy_approve
    end
    
    def destroy_project_member
        @project = ProjectRelation.find(params[:id]).approved
        @user = ProjectRelation.find(params[:id]).approving
        @project.leave_member!(@user)
        flash[:notice] = "#{@user.name}さんをメンバーから削除しました。"
        redirect_to project_path(@project)
    end
    
    def destroy_join_project
        @project = ProjectRelation.find(params[:id]).approved
        @user = ProjectRelation.find(params[:id]).approving
        @user.leave_project!(@project)
        flash[:notice] = "プロジェクトから脱退しました。"
        redirect_to root_path
    end
    
    private
    
        def sending_pusher
            Notification.sending_pusher(@notification.recipient_id)
        end
        
        def invited_pusher
            @project = Project.find(params[:id])
            @user = User.find(params[:project_relation][:invited_id])
            Pusher['notifications_'+@user.id.to_s].trigger('invited_project', {
              messaging: "プロジェクト「#{@project.name}」に招待されました。"
            })
        end
    
end
