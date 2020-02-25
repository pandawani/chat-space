require 'rails_helper'

describe User do
  describe '#create' do
    
    #メッセージを保存できる場合---------------------
    #メッセージがあれば保存できる
    it "is valid with a comment(no image)" do
      comment = build(:comment,image: nil)
      expect(comment).to be_valid
    end

    #画像があれば保存できる
    it "is valid with a image(no body)" do
      comment = build(:comment, body: nil)
      expect(comment).to be_valid
    end

    #メッセージと画像があれば保存できる
    it "is valid with a image and a body" do
      comment = build(:comment)
      expect(comment).to be_valid
    end

    #メッセージを保存できない場合---------------------
    #メッセージも画像も無いと保存できない
    it "is invalid without a comment and a image" do
      comment = build(:comment, body: nil, image: nil)
      comment.valid?
      expect(comment.errors[:body]).to include("を入力してください")
    end

    #group_idが無いと保存できない
    it "is invalid without a group_id" do
      comment = build(:comment, group_id: nil)
      comment.valid?
      expect(comment.errors[:group]).to include("を入力してください")
    end

    #user_idが無いと保存できない
    it "is invalid without a user_id" do
      comment = build(:comment, user_id: nil)
      comment.valid?
      expect(comment.errors[:user]).to include("を入力してください")
    end

  end
end