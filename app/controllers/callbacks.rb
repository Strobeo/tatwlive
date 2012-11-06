Tatwlive.controllers :callbacks do
  # get :index, :map => "/foo/bar" do
  #   session[:foo] = "bar"
  #   render 'index'
  # end

  # get :sample, :map => "/sample/url", :provides => [:any, :js] do
  #   case content_type
  #     when :js then ...
  #     else ...
  # end

  # get :foo, :with => :id do
  #   "Maps to url '/foo/#{params[:id]}'"
  # end

  # get "/example" do
  #   "Hello world!"
  # end

  get :ig do
    ap params
    
    params['hub.challenge']
  end

  get :subs do
    ap params    
    params['hub.challenge']
  end

  post :ig, provides: :json do
    ap JSON.parse(request.body.string)
    params['hub.challenge']
  end


end
