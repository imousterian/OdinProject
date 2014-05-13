This is a Micro-Reddit project for The Odin Project Curriculum @http://www.theodinproject.com/ruby-on-rails/building-with-active-record. The goal is to practice building the data structures necessary to support link submissions and commenting.

Steps:
1. rails new micro-reddit
2. rails generate model User username:string email:string password:string
3. rake db:migrate
4. in User.rb, add: 
    validates :username, presence: true, length: {maximum: 20}
    validates :email, presence: true

Posts:
1. rails generate model Post content:string user_id:integer (user_id is a foreign key) 
2. rake db:migrate
3. add validations: validates :user_id, presence: true
3. add associations to User model: has_many :posts; and to Post model: belongs_to :user

Comments:
1. rails generate model Comment content:string user_id:integer
2. rails generate migration AddPostIdToComments post_id:integer:index (adding a post_id as an index, since I forgot to do it in the first step)
3. associations in User has_many :comments; in Comment: belongs_to :post belongs_to :user; in Post: has_many :comments
4. validations in Comment: validates :user_id, presence: true
    validates :post_id, presence:true

rails generate migration RemovePasswordFromUsers password:string # decided to get rid of this field
rake db:migrate