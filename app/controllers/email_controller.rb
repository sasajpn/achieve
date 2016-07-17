class EmailController < ApplicationController
    require "mail"

    def recieve_email
        Mail.defaults do
            retriever_method :pop3, {
                :address => "pop.gmail.com",
                :port => 995,
                :user_name => "recent:#{ENV['GMAIL_ADDRESS']}",
                :password => ENV['GMAIL_PASSWORD'],
                :enable_ssl => true
                }
        end
        @mails = Mail.find(count: 5, order: :desc, what: :last)
    end

end
