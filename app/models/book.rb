class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)

  end

  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}

  def self.search_for(content, method)
    if method == 'parfect'
      Book.where(title: content)
    elsif method == 'forward'
      Book.where('title LIKE?', content + '%')
    elsif method == 'backward'
      Book.where('title LIKE?', '%' + content)
    else
      Book.where('title LIKE?', '%' + content + '%')
    end
  end
end
