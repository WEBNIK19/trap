class RequestController < ApplicationController
	
	def new
		headers = request.env.select{|k, v| k.in?(ActionDispatch::Http::Headers::CGI_VARIABLES) || k =~ ActionDispatch::Http::Headers::HTTP_HEADER}
		
		@my_request = Request.create(
			:trap_id => params[:trap_id], 
			:method => request.method , 
			:remote_ip => request.remote_ip, 
			:scheme => request.scheme, 
			:params => request.parameters,
      :headers => headers,
      :cookies => cookies.to_a);

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
