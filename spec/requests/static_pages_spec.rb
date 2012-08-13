require 'spec_helper'

describe "StaticPages" do
  describe "Home page" do
    before { visit root_path }
  	it "should have the content 'Sample App'" do
  		page.should have_content('Sample App')
  	end

  	it "should have the right title" do
		  page.should have_selector('title', :text => "Ruby on Rails Tutorial Sample App")
 	  end

    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:micropost, user: user, content: "Lorum ipsem")
        FactoryGirl.create(:micropost, user: user, content: "zoopreme")
        sign_in user
        visit root_path
      end

      it "should render the user's feed" do
        user.feed.each do |item|
          page.should have_selector("li##{item.id}", text: item.content)
        end
      end
    end

  end


  describe "Help page" do
  	it "should have the content 'Help'" do
  		visit help_path
  		page.should have_content('Help')
  	end

  	it "should have the right title" do
		visit help_path
		page.should have_selector('title', :text => "Ruby on Rails Tutorial Sample App | Help")
 	end
  end

  describe "About page" do
  	it "should have the content 'About'" do
  		visit about_path
  		page.should have_content('About')
  	end

  	it "should have the right title" do
		visit about_path
		page.should have_selector('title', :text => "Ruby on Rails Tutorial Sample App | About")
 	end
  end

  describe "Contact page" do
    it "should have the h1 'Contact'" do
      visit contact_path
      page.should have_selector('h1', text: 'Contact')
    end

    it "should have the title 'Contact'" do
      visit contact_path
      page.should have_selector('title', text: "Ruby on Rails Tutorial Sample App | Contact")
    end
  end
end
