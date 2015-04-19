class YoutubeUploader
	def initialize(user_token, upload_file_path)
		@user_token = user_token
		@upload_file_path = upload_file_path
	end

	def upload!
		youtube_account.upload_video upload_file_path
	end

	private

		attr_reader :user_token, :upload_file_path

		def youtube_account
			Yt::Account.new access_token: user_token
		rescue Yt::Errors::Unauthorized => e
			e.message
		end
end