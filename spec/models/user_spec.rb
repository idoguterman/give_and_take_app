require 'spec_helper'

describe User do
  before(:all) do
    
  end

  context "stress"do
    it "create_user" do
      require 'debugger';debugger
      @user = create(:user)
		  users = create_list(:user , 200)
      puts users.first.images.inspect
      users.first.images.count == 2
    end
  end
  pending "add some examples to (or delete) #{__FILE__}"
end
