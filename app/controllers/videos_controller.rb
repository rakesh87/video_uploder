class VideosController < ApplicationController
  def index
    @videos = Video.order('created_at DESC')
  end
 
  def new
    @video = Video.new
  end
 
	def create
	  @video = Video.new(video_params)
	  upload_file_path = params[:video][:file].tempfile.to_path
	  if @video.valid?
		  begin
		  	uploader = YoutubeUploader.new(YT_CREDENTIAL['yt_token'], upload_file_path)
		  	uploader.upload!
		  rescue Yt::Errors::Unauthorized => e
		  	flash[:error] = "Can't upload video : #{e.message.split(':').try(:first).strip}"
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
