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

    @return_msg={
      :text =>@user_msg
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
