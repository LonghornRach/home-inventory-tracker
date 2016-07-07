require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, Proc.new { File.join(root, "../views/") }
    enable :sessions
    set :session_secret, 'secret'
    use Rack::Flash, :sweep => true
    set :scss, {:style => :compressed, :debug_info => false}
    # enable :method_override
  end

  get '/' do
    erb :index
  end

  # get '/css/styles.css' do
  #   content_type :css
  #   scss :styles
  # end

  helpers do
    def authorize!(user)
      if !logged_in?
        redirect '/'
        flash[:message] = "Please log in or sign up first."
      else
        unless current_user == user
          redirect_home(user)
          flash[:message] = "You are not authorized to view that page."
        end
      end
    end

    # def css(*stylesheets)
    #   stylesheets.map do |stylesheet|
    #     "<link href=\"/#{stylesheet}.css\" media=\"screen, projection\" rel=\"stylesheet\" />"
    #   end.join
    # end

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
      flash[:message] = "Successfully logged out."
    end
  end

end