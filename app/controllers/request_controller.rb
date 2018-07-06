class RequestController < ApplicationController
	
	def new
		@my_request = Request.create(
			:trap_id => params[:trap_id], 
			:method => request.method , 
			:remote_ip => request.remote_ip, 
			:scheme => request.scheme, 
			:params => request.parameters,
      :headers => Hash.new(request.headers),
      :cookies => cookies.to_a,
      :request_env => request.env);

		if @my_request.persisted? 
			 head :no_content
		else
			 head :internal_server_error
		end
 	end

# GET /:trap_id/requests
	def index
		@requests = Request.where(:trap_id=>params[:trap_id]).order('created_at DESC')
		if @requests.take.blank?
			redirect_to root_url, :status => :not_found
		else
			@trap_id = @requests.first.trap_id
		end
	end

# GET /:trap_id/request/:id
	def show
		@request = Request.where(:id => params[:id]).first
		if @request.blank?
			head :not_found
		end
	end
end
