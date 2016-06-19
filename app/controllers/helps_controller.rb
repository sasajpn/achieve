class HelpsController < ApplicationController

require 'mail'


    def new
        if params[:back]
            @help = Help.new(create_params)
        else
            @help = Help.new
        end
    end

    def confirm
        @help = Help.new(create_params)
        render 'new' if @help.invalid?
    end

    def create
        @help = Help.new(create_params)

        if params[:back]
            render 'new'
        elsif @help.save
            UserMailer.help_email(@help).deliver_later
            UserMailer.self_help_email(@help).deliver_later


            # Mail.first

            redirect_to action: :thanks
        else
            render 'new'
        end
    end

    def thanks
    end

    private

        def create_params
            params.require(:help).permit(:name, :email, :content)
        end
end
