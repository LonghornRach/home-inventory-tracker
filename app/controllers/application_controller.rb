require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, Proc.new { File.join(root, "../views/") }
    enable :sessions
    set :session_secret, 'secret'
    # enable :method_override
  end

  get '/' do
    erb :index
  end

  helpers do
    def authorize!(user)
      if !logged_in?
        redirect '/'
        #flash you must log in or sign up
      else
        unless current_user == user
          redirect_home(user)
          #flash you are not authorized to view that page
        end
      end
    end

    def logged_in?
      !!session[:id]
    end

    def current_user
      User.find_by_id(session[:id])
    end

    def login!(user)
      session[:id] = user.id
    end

    def redirect_home(user)
      redirect "/users/#{user.slug}"
    end

    def logout!
      session.clear
      redirect '/'
      #flash successfully logged out
    end
  end

end