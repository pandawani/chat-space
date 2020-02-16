class Group < ApplicationRecord
  has_many :group_users
  has_many :users, through: :group_users
  has_many :comments
  validates :name, presence: true, uniqueness: true

  def show_last_comment
    if(last_comment = comments.last).present?
      if last_comment.body?
        last_comment.body
      else
        '画像が投稿されています'
      end
    else
      'まだメッセージはありません。'
    end
  end

end
