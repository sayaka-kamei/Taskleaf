class TasksController < ApplicationController

  def index
    @tasks = current_user.tasks.order(created_at: :desc).page(params[:page])
    @tasks = current_user.tasks.order(expiry_date: :desc).page(params[:page]) if params[:sort_expired]
    @tasks = current_user.tasks.order(priority: :asc).page(params[:page]) if params[:sort_priority]
    if params[:task].present?
      name = params[:task][:name]
      status = params[:task][:status]
      if name.present? && status.present?
        @tasks = current_user.tasks.search_name_status(name,status).page(params[:page])
      elsif name.present? 
        @tasks = current_user.tasks.search_name(name).page(params[:page])
      elsif status.present?
        @tasks = current_user.tasks.search_status(status).page(params[:page])
      end  
    end      
  end
  
  def show
    @task = current_user.tasks.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task =  current_user.tasks.build(task_params)
    if params[:back]
      render :new
    else  
      if @task.save
        redirect_to tasks_path, notice: "新しいタスクを作成しました!"
      else
        render :new
      end
    end    
  end

  def edit
    @task = current_user.tasks.find(params[:id])
  end

  def update
    @task = current_user.tasks.find(params[:id])
    if @task.update(task_params)
      redirect_to tasks_path, notice: "タスクを編集しました!"
    else
      render :edit
    end    
  end

  def confirm
    @task =  current_user.tasks.build(task_params)
  end  
  
  def destroy
    @task = current_user.tasks.find(params[:id])
    @task.destroy
    redirect_to tasks_path, notice:"タスクを削除しました!"
  end  

  private

  def task_params
    params.require(:task).permit(:id, :name, :description, :expiry_date, 
                                :created_at, :sort_expired, :search, :status, :priority, :page ).
                                merge(priority: params[:task][:priority])
  end
end
