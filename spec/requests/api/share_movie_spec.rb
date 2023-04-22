require 'rails_helper'
RSpec.describe "Share movie", type: :request do
  context 'Create new movie' do
    before {
      application = create(:application)
      user = create(:user, :email => 'movie@email.com')
      token = create(:access_token, application: application, resource_owner_id: user.id)
      url = 'https://www.youtube.com/watch?v=mLmPajA_3Gg&ab_channel=KhoaiLangThang'
      post "/api/movies", params: {video_url: url}, headers: {
        'Authorization': 'Bearer ' + token.token,
        'Accept': 'application/json'}
    }
    it 'succeeds' do
      expect(response).to be_successful
    end

    it 'created successfully' do
      title = 'Đi chợ phiên, nấu một nồi món lạ đãi bà con, kéo điện nhà Khánh |Ký sự Bản Phùng Hà Giang #4'
      body_movie = JSON.parse(response.body)
      expect(body_movie['result']['title']).to eq(title)
    end
  end
end