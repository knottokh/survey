class PagesController < ApplicationController
  def index
       @newusertext = "ลงทะเบียนผู้ใช้ใหม่"
       @tosurveytext = "กรอกข้อมูลต่อ"
       session[:user_id] = nil
       if session[:user_id] != nil
         redirect_to dashboard_path
       end
  end
  def show

    @NEW_USER_HASH = Hash.new
    @NEW_USER_HASH[ "prefix" ] = { "label" => "Prefix", "type" => "text_field" }
    @NEW_USER_HASH[ "first" ] = { "label" => "First Name", "type" => "text_field" }
  end
end
