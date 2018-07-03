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
      @text=["cheese","mango","nabi"].sample
    end

    @return_msg={
      :text =>@text
    }
    
    @return_keyboard={
      :type => "buttons",					
      buttons: ["menu", "lotto", "cat"]		
    }

    @result = {
      :message=> @return_msg,
      :keyboard=> @return_keyboard
      
    }
    render json: @result #강제로 사용하기
  end
end
