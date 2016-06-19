class UserMailer < ApplicationMailer

    def help_email(help)
        @help = help
        mail(to: "#{@help.email}", subject: "お問い合わせいただきありがとうございます。")
    end

    def self_help_email(help)
        @help = help
        mail(
            to: "achieve.dic.sasahara@gmail.com",
            subject: "#{@help.email}"
            )
    end
end
