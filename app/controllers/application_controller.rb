require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, Proc.new { File.join(root, "../views/") }
    enable :sessions
    set :session_secret, 'secret'
    use Rack::Flash
    # use Sinatra::Flash
    set :scss, {:style => :compressed, :debug_info => false}
    # enable :method_override
  end

  get '/' do
    erb :index
  end

  helpers do
    def authorize!(user)
      if !logged_in?
        redirect '/'
        flash[:alert] = "Please log in or sign up first."
      else
        unless current_user == user
          flash[:error] = "You are not authorized to view that page."
          redirect_home(user)
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
      flash[:alert] = "You have been logged out."
      redirect '/'
    end
  end

end