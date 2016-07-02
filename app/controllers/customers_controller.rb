class CustomersController < ApplicationController
    before_action :set_project, only: [:new, :create]
    before_action :set_customer, only: [:edit, :update, :destroy]
    
    def new
        @customer = @project.customers.build
    end
    
    def create
        @customer = @project.customers.build(customer_params)
        if @customer.save
            flash[:notice] = "プロジェクトの顧客を設定しました。"
            redirect_to project_path(@project)
        else
            flash[:alert] = "設定に失敗しました。"
            redirect_to project_customer_path(@project)
        end
    end
    
    def edit
    end
    
    def update
        if @customer.update(customer_params)
            flash[:notice] = "顧客情報を変更しました。"
            redirect_to project_path(@project)
        end
    end
    
    def destroy
        @customer.destroy
        flash[:notice] = "顧客情報を削除しました。"
        redirect_to project_path(@project)
    end
    
    
    
    private
        
        def set_project
            @project = Project.find(params[:project_id])
        end
        
        def set_customer
            @project = Project.find(params[:project_id])
            @customer = @project.customers.find(params[:id])
        end
        
        def customer_params
            params.require(:customer).permit(:name)
        end
end
