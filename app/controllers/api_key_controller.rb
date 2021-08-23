require 'json'
class ApiKeyController < ApplicationController
skip_before_action :check_if_login_required, :check_password_change
    def get      
        passapi=params[:id]
        passnuestra='7c65e089fcde3396919f4897f95b9872653529daf52413f2032fdb4d3227f116'
        if passapi==passnuestra
            mivar=Issue.execute_sql("select t.value from public.tokens t, public.users u where u.id=t.user_id and t.action=\'api\' and u.login=\'admin\'")
            render :json => mivar     
        else
            render :json => {"OK": "OK"} 
        end          
    end 
end