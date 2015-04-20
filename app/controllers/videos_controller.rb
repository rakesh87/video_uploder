class VideosController < ApplicationController
  def new
    @video = Video.new
  end
 
	def create
	  @video = Video.new(video_params)
	  user = User.first
	  upload_file_path = params[:video][:file].tempfile.to_path
	  if @video.valid?
		  begin
		  	uploader = YoutubeUploader.new(YT_CREDENTIAL['yt_token'], upload_file_path)
		  	# uploader = YoutubeUploader.new(user.token, upload_file_path)
		  	uploader.upload!
		  rescue Yt::Errors::Unauthorized => e
		  	flash[:error] = "Can't upload video : #{e.message.split(':').try(:first).strip}. Create new token by login again"
	    	return render :new
		  end
	    flash[:success] = 'Video uploaded!'
	    redirect_to root_url
	  else
	    render :new
	  end
	end
	 
	private
	 
		def video_params
		  params.require(:video).permit(:file)
		end
end
