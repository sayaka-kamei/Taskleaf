class TasksController < ApplicationController

  def index
    @tasks = Task.all.order(created_at: :desc)
    @tasks = Task.all.order(expiry_date: :desc) if params[:sort_expired]
    if params[:task].present?
      name = params[:task][:name]
      status = params[:task][:status]
      if name.present? && status.present?
        @tasks = Task.search_name_status(name,status)
      elsif name.present? 
        @tasks = Task.search_name(name)
      elsif status.present?
        @tasks = Task.search_status(status)
      end  
    end      
  end
  
  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task =  Task.new(task_params)
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
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to tasks_path, notice: "タスクを編集しました!"
    else
      render :edit
    end    
  end

  def confirm
    @task = Task.new(task_params)
    render :new if @task.invalid?
  end  
  
  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_path, notice:"タスクを削除しました!"
  end  

  private

  def task_params
    params.require(:task).permit(:name, :description, :expiry_date, :created_at, :sort_expired, :search, :status)
  end
end
