module UsersHelper
    
    def current_user?(user)
        user == current_user
    end
    
    def profile_img(user)
       
    end
    
    def profile_img(user)
        if user.provider == 'facebook'
            img_url = "https://graph.facebook.com/#{user.uid}/picture?width=320&height=320"
        elsif user.provider == 'twitter'
            img_url = "http://twiticon.herokuapp.com/#{user.name}"
        else
            gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
            img_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
        end
        image_tag(img_url, alt: user.name, class: "avatar")
    end
        
    
    
end
