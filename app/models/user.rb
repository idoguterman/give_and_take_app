class User < ActiveRecord::Base

  has_many :authentications
	has_many :images
	has_many :activities
	has_one :current_location

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :images, :password_confirmation, :remember_me, :picture , :age, :first_name, :middle_name, :last_name

  def self.search(query)
    where do
      email =~ "%#{query}%"
    end
  end

  def male=(str)
    self.gender = str.in?["true", true, 1,"1","male"]
	end

	def male?
    self.gender
  end

	def female=(str)
    self.gender = !str.in?["true",true,1,"1","female"]
	end

	def female?
    !self.gender
  end

	def full_name
    self.middle_name.present? ? [self.first_name,self.middle_name,self.last_name].join(" ") : [self.first_name, self.last_name].join(" ")
	end

	def graph
				@graph
	end
  def profile_photo(type="large")
    self.picture.split("picture")[0] << "picture?type=#{type}"
  end

  def apply_omniauth(omniauth)

	  self.email = omniauth['info']['email'] if email.blank? && omniauth['info'].present?
		require 'debugger';debugger
    self.picture = omniauth['info']['image'] if picture.blank? && omniauth['info']['image'].present?
		self.first_name = omniauth['info']['first_name']
		self.last_name = omniauth['info']['last_name']
		self.gender = omniauth.extra.raw_info.gender if omniauth.extra.present?
		token = omniauth['credentials'].token
    add_images(token) if self.images.count == 0 	
		  
		#require 'debugger';debugger
		authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])

  end

  def password_required?
	  (authentications.empty? || !password.blank?) && super
  end

	private

	def add_images(token)

    if token.present? && self.images.count == 0 then
      @graph = Koala::Facebook::API.new(token)
      images = @graph.fql_query('select pid,src,src_small,src_big from photo where aid in(select aid from album where owner=me() and type="profile") limit 5')
			images.each do |img|
        image = Image.create!(
        :avatar_file_name => URI.parse(img['src_big']),
        :crop_x=> 0,
        :crop_y=> 0,
        :crop_w=> 300,
        :crop_h=> 300)

        image.update_attributes(:remote_image_url => img['src_big'], :crop_x => 0)
        require 'debugger';debugger
        self.images.build(image)
			end
		end
	end
end
