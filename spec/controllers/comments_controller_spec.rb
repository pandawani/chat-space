require 'rails_helper'

describe CommentsController, type: :controller do
  let(:group) { create(:group) }
  let(:user) { create(:user) }
#--------------------------------------------------------------------------
  describe 'GET #new' do

  #認証済のユーザーとして-------------------
  context "as an authenticated user" do
    before do
      login user
      get :index, params: { group_id: group.id }
    end

    #アクション内で定義しているインスタンス変数があるか
    it 'assigns @group' do
      expect(assigns(:group)).to eq group
    end
    
    it 'assigns @comment' do
      expect(assigns(:comment)).to be_a_new(Comment)
    end

    it 'assigns @comments' do
      comments = create_list(:comment, 3, group: group)
      expect(assigns(:comments)).to match(comments)
    end

    #該当するビューが描画されているか
    it 'renders index' do
      expect(response).to render_template :index
    end
  end


  #ゲストとして---------------------------
  context "as a guest" do
    #意図したビューにリダイレクトできているか
    before do
      get :index, params: { group_id: group.id }
    end

    it 'redirects to new_user_session_path' do
      expect(response).to redirect_to(new_user_session_path)
    end
  end


  end

#--------------------------------------------------------------------
  describe 'POST #create' do
    let(:comment) { create(:comment) }

  #1. ログインしている
  context "as an authenticated user" do
    before do
      login user
    end

  #メッセージの保存はできたのか
    it 'can save a message' do
      expect{post :create, params:{group_id: group.id,user_id: user.id, comment: attributes_for(:comment)}}.to change(Comment, :count).by(1)
    end

  #意図した画面に遷移しているか
    it "redirects to index template(group_comment_path)" do
      # binding.pry
      post :create, params:{group_id: group.id, comment: attributes_for(:comment)}
      expect(response).to redirect_to(group_comments_path(group.id))
    end


  #ログインしているが、保存に失敗した場合
  
  #メッセージの保存は行われなかったか
    let(:invalid_params) { { group_id: group.id, user_id: user.id, comment: attributes_for(:comment, body: nil, image: nil) } }
    it "can not save a message" do
      expect{post :create, params:invalid_params}.not_to change(Comment, :count)
    end
  
  #意図したビューが描画されているか
    it "redirects to index template" do 
      post:create, params:invalid_params
      expect(response). to render_template :index
    end
  end
    


  #2.ログインしていない
  context "as a guest" do
  #意図した画面にリダイレクトできているか
    before do
      post :create, params: {group_id: group.id}
    end

    it 'redirects to new_user_session_path' do
      expect(response).to redirect_to(new_user_session_path)
    end



  end
  end

end