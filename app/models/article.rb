class Article < ActiveRecord::Base
    belongs_to :user
    has_many :comments, dependent: :destroy
    validates :title, presence: true, length:{minimum:3, maximum:50}
    validates :user_id, presence: true
    validates :description, presence:true, length:{minimum:10,maximum:100}

end