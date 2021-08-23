require 'json'
class CronApiController < ApplicationController
  skip_before_action :verify_authenticity_token

    def get
        if User.current.admin? || User.verificarCordinador!='[]'
                result = []

                var =`crontab -u redmine -l`


                var.each_line {|line| result << line.split(" ") }
                render :json => result.to_json
        else
                render :json => nil
        end

    end

    def getQuerys
        if User.current.admin? || User.verificarCordinador!='[]'
                mivar=Query.find_by_sql("SELECT * FROM public.queries")
                render :json => mivar
        else
                render :json => nil
        end
    end

    def postAllIssuesAllProjects
        if User.current.admin? || User.verificarCordinador!='[]'
                itemCopy = JSON.parse(request.body.read(), object_class: OpenStruct)
                `bash ./bash/cronUpdater.sh #{itemCopy.Minuto} #{itemCopy.Hora} #{itemCopy.Dia} #{itemCopy.Mes} #{itemCopy.DiaSemana} "allip#{itemCopy.NombreFormato}" `

                render :json => {"OK": "OK"}
       else
                render :json => nil
        end
    end
    def postOneProjectAllIssues
        if User.current.admin? || User.verificarCordinador!='[]'
              itemCopy = JSON.parse(request.body.read(), object_class: OpenStruct)
              `bash ./bash/cronUpdater.sh #{itemCopy.Minuto} #{itemCopy.Hora} #{itemCopy.Dia} #{itemCopy.Mes} #{itemCopy.DiaSemana} "prjct#{itemCopy.NombreFormato}#{itemCopy.IdProyecto}" `

              render :json => {"OK": "OK"}
       else
                render :json => nil
        end
    end
    def postQueryGeneral
        if User.current.admin? || User.verificarCordinador!='[]'
                itemCopy = JSON.parse(request.body.read(), object_class: OpenStruct)
                `bash ./bash/cronUpdater.sh #{itemCopy.Minuto} #{itemCopy.Hora} #{itemCopy.Dia} #{itemCopy.Mes} #{itemCopy.DiaSemana} "issue#{itemCopy.NombreFormato}#{itemCopy.IdQuery}" `

                render :json => {"OK": "OK"}
       else
                render :json => nil
        end
    end
    def postOneProjectOneIssue
        if User.current.admin? || User.verificarCordinador!='[]'
              itemCopy = JSON.parse(request.body.read(), object_class: OpenStruct)
              `bash ./bash/cronUpdater.sh #{itemCopy.Minuto} #{itemCopy.Hora} #{itemCopy.Dia} #{itemCopy.Mes} #{itemCopy.DiaSemana} "sngpr#{itemCopy.NombreFormato}#{itemCopy.IdProyecto}_#{itemCopy.IdQuery}" `

              render :json => {"OK": "OK"}
        else
                render :json => nil
        end

    end

    def delete
        if User.current.admin? || User.verificarCordinador!='[]'
              @id=params[:id]
              `bash ./bash/crontabCleaner.sh #{@id}`
              render :json => {"OK": @id}
        else
                render :json => nil
        end
    end

   def postBackup
        if User.current.admin?
              itemCopy = JSON.parse(request.body.read(), object_class: OpenStruct)
              `bash ./bash/cronUpdater.sh #{itemCopy.Minuto} #{itemCopy.Hora} #{itemCopy.Dia} #{itemCopy.Mes} #{itemCopy.DiaSemana} "bkrmf"`
              render :json => {"OK": "OK"}
        else
                render :json => nil
        end
  end

  def postReminder #MOD
        if User.current.admin? || User.verificarCordinador!='[]'
           itemCopy = JSON.parse(request.body.read(), object_class: OpenStruct)
            `bash ./bash/cronUpdater.sh #{itemCopy.Minuto} #{itemCopy.Hora} #{itemCopy.Dia} #{itemCopy.Mes} #{itemCopy.DiaSemana} "tmail#{itemCopy.DayRemainder}_#{itemCopy.IdCategoria}_#{itemCopy.IdProyecto}_#{itemCopy.Users}"`
             render :json => {"OK": "OK"}
        else
          render :json => nil
        end
  end

  def postBackupNow
        if User.current.admin?
            `bash ./bash/files_bkp.sh`
            render :json => {"OK": "OK"}
        else
                render :json => nil
        end
  end

end

