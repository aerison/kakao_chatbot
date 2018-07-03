class KakaoController < ApplicationController
  def keyboard
    @keyboard={
      :type => "buttons",						# 이렇게 작성해도
      buttons: ["menu", "lotto", "cat"]		 # 요렇게 작성해도 똑같습니다.
    }
    
    render json: @keyboard
  end
  
  def message
    @user_msg=params[:content]
    @text = "기본응답"
    if @user_msg == "menu"
      @text=["20층","multirestaurant","bab"].sample
    
    elsif @user_msg == "lotto"
      @text=(1..45).to_a.sample(6).sort.to_s
    
    elsif @user_msg =="cat"
      #@text=["cheese","mango","nabi"].sample
      @url="http://thecatapi.com/api/images/get?format=xml&type=jpg"
      @cat_xml =RestClient.get(@url)
      @cat_doc  = Nokogiri::XML(@cat_xml)
      @cat_url = @cat_doc.xpath("//url").text
      @text = @cat_url
    end

  #사진없이 글 해쉬만
    @return_msg={
      :text =>@text
    }
  #사진까지 있는 해쉬  
    @return_msg_photo={
        :text =>"나만고양이없어ㅇㅅㅇ",
        :photo =>{
          :url => @cat_url,
          :width => 720,
          :height => 640
          }
    }
    
    @return_keyboard={
      :type => "buttons",					
      buttons: ["menu", "lotto", "cat"]		
    }
    
    if @user_msg == "cat"
      @result = {
        :message=> @return_msg_photo,
        :keyboard=> @return_keyboard
      }
    else
      @result = {
      :message=> @return_msg,
      :keyboard=> @return_keyboard
      }
    end
    
    
    render json: @result #강제로 사용하기
  end
  
  def friend_add
    User.create(user_key:params[:user_key],chat_room:0) 
    #model에 있는 user_key에 파람즈로 받고, chat_room은 0으로 초기화
    render nothing: true   #render nothing
  
  end
  
  def friend_delete
    User.find_by(user_key:params[:user_key]).destroy
    render nothing: true
    #find는 id 값, find_by는 칼럼값
    
  end
  #add,delete만들고, console에 rails g model user user_key:string chat_room:integer 하고 
  #rake db:migrate
  
  def chat_room
    user=User.find_by(user_key:params[:user_key])
    user.plus
    user.save
    render nothing: true
  end
end
