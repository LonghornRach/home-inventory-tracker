require 'spec_helper'

describe ApplicationController do

  describe "index page" do
    it 'welcomes viewers' do
      visit '/'
      expect(page.text).to include("Welcome")
    end
    it 'links to signup page' do
      visit '/'
      expect(find_all(:link).first.text).to eq("Sign Up!")
    end
    it 'links to login page' do
      visit '/'
      expect(find_all(:link).last.text).to eq("Log In")
    end
  end

end