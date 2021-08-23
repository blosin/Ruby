require 'json'
class AverageResolutionController < ApplicationController
  skip_before_action :verify_authenticity_token

    def getIssuesStatuses
        if User.current.admin? || User.verificarCordinador!='[]'
                mivar=Issue.execute_sql("SELECT * FROM public.issues a, public.trackers b where a.tracker_id=b.id AND closed_on IS NOT NULL AND tracker_id=1")
                render :json => mivar
        else
                render :json => nil
        end
    end

    def getUsuarios #AGREGADO
        if User.current.admin? || User.verificarCordinador!='[]'
                if params[:id]==nil
                        render :status => 404
                else
                        mivar=Issue.execute_sql("SELECT users.id, users.firstname, users.lastname FROM MEMBERS members, USERS users WHERE members.user_id=users.id AND members.project_id=?", params[:id])
                        render :json => mivar
                end
        else
                render :json => nil
        end
    end

    def getUsuario #AGREGADO
      if User.current.admin? || User.verificarCordinador!='[]'
        if params[:id]==nil
                render :status => 404
        else
                mivar=Issue.execute_sql("SELECT users.id, users.firstname, users.lastname FROM USERS users WHERE users.id=?", params[:id])
                render :json => mivar
        end
      else
        render :json => nil
      end
    end

    def getProyectos
          if User.current.admin? || User.verificarCordinador!='[]'
              if params[:id]==nil
                mivar=Issue.execute_sql("SELECT * FROM public.projects ORDER BY id ASC ") 
                render :json => mivar
              else
                mivar=Issue.execute_sql("SELECT * FROM public.projects WHERE id= ?", params[:id]) 
                render :json => mivar
              end
          else
                render :json => nil
          end
    end

    def getCategorias #este*
        if User.current.admin? || User.verificarCordinador!='[]'
                mivar=Issue.execute_sql("SELECT id, project_id, name FROM public.trackers trackers, public.projects_trackers projects_trackers where  projects_trackers.tracker_id=trackers.id AND project_id= ?", params[:id])
                render :json => mivar
        else
                render :json => nil
        end
    end

    def getCategoriaInfo #este*
        if User.current.admin? || User.verificarCordinador!='[]'
                mivar=Issue.execute_sql("SELECT id, project_id, name FROM public.trackers trackers, public.projects_trackers projects_trackers where projects_trackers.tracker_id=trackers.id AND id= ?", params[:id])
                render :json => mivar
        else
                render :json => nil
        end
    end


    def getAverages1Proyecto  
        if User.current.admin? || User.verificarCordinador!='[]'
                if params[:id2]==nil
                        mivar=Issue.execute_sql("SELECT avg(closed_on-created_on) FROM public.issues a where closed_on IS NOT NULL AND project_id= ?", params[:id])
                        render :json => mivar
                else
                        mivar=Issue.execute_sql("SELECT avg(closed_on-created_on) FROM public.issues a where closed_on IS NOT NULL AND project_id= ? AND status_id= ?", params[:id], params[:id2])
                        render :json => mivar
                end
         else
                render :json => nil
         end
    end

    def getAverages1Proyecto1Categoria #este*
        if User.current.admin? || User.verificarCordinador!='[]'
                if params[:id2]==nil
                        mivar= Issue.execute_sql("SELECT avg(closed_on-created_on) FROM public.issues a, public.trackers b where a.tracker_id=b.id AND closed_on IS NOT NULL AND tracker_id= ?", params[:id])
                        render :json => mivar
              else
                        mivar= Issue.execute_sql("SELECT avg(closed_on-created_on) FROM public.issues a, public.trackers b where a.tracker_id=b.id AND closed_on IS NOT NULL AND tracker_id= ? AND status_id= ?", params[:id], params[:id2])
                        render :json => mivar
              end
         else
                render :json => nil
         end
    end

    def getAverages1ProyectoTodasCategorias #este*
      if User.current.admin? || User.verificarCordinador!='[]'
              if params[:id2]==nil
                        mivar= Issue.execute_sql("SELECT b.name, avg(closed_on-created_on) FROM public.issues a, public.trackers b where a.tracker_id=b.id AND closed_on IS NOT NULL AND a.project_id= ? group by b.name", params[:id])
                        render :json => mivar
              else
                        mivar= Issue.execute_sql("SELECT b.name, avg(closed_on-created_on) FROM public.issues a, public.trackers b where a.tracker_id=b.id AND closed_on IS NOT NULL AND a.project_id= ? AND status_id= ? group by b.name", params[:id], params[:id2])
                        render :json => mivar
              end
      else
                render :json => nil
      end
    end

    def getAveragesTodosProyectos0categoria
        if User.current.admin? || User.verificarCordinador!='[]'
              if params[:id2]==nil
                        mivar=Issue.execute_sql("SELECT project_id, avg(closed_on-created_on) FROM public.issues where closed_on IS NOT NULL group by project_id")
                        render :json => mivar
              else
                        mivar=Issue.execute_sql("SELECT project_id, avg(closed_on-created_on) FROM public.issues where closed_on IS NOT NULL AND status_id= ? group by project_id", params[:id2])
                        render :json => mivar
              end
       else
                render :json => nil
       end

    end

end