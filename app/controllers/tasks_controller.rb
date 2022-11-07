class TasksController < ApplicationController

  def index
    @tasks = current_user.tasks.order(created_at: :desc).page(params[:page])
    @tasks = current_user.tasks.order(expiry_date: :desc).page(params[:page]) if params[:sort_expired]
    @tasks = current_user.tasks.order(priority: :asc).page(params[:page]) if params[:sort_priority]
    @tasks = @tasks.joins(:labels).where(labels: { id: params[:label_id] }) if params[:label_id].present?
    if params[:task].present?
      name = params[:task][:name]
      status = params[:task][:status]
      label = params[:task][:label_id]
      if name.present? && status.present?
        @tasks = current_user.tasks.search_name_status(name,status).page(params[:page])
      elsif name.present? 
        @tasks = current_user.tasks.search_name(name).page(params[:page])
      elsif status.present?
        @tasks = current_user.tasks.search_status(status).page(params[:page])
      elsif label.present?
        task_id = Labelling.where(label_id: label).pluck(:task_id)
        @tasks = Task.page(params[:page]).where(id: task_id)
      end  
    end      
  end
  
  def show
    @task = current_user.tasks.find(params[:id])
  end

  def new
    @task = Task.new
    @label = Label.new
  end

  def create
    @task =  current_user.tasks.build(task_params)
    respond_to do |format|
      if @task.save
      format.html { redirect_to tasks_path(@task), notice: "Task was successfully created." }
      format.json { render :show, status: :created, location: @task }
      else
      format.html { render :new, status: :unprocessable_entity }
      format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end    
  end

  def edit
    @task = current_user.tasks.find(params[:id])
  end

  def update
    @task = current_user.tasks.find(params[:id])
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to task_url(@task), notice: "Task was successfully updated." }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def confirm
    @task =  current_user.tasks.build(task_params)
    render :new if @task.invalid?
  end  
  
  def destroy
    @task = current_user.tasks.find(params[:id])
    @task.destroy
    redirect_to tasks_path, notice:"タスクを削除しました!"
  end  

  private

  def task_params
    params.require(:task).permit(:id, :name, :description, :expiry_date, 
                                :created_at, :sort_expired, :search, :status, :priority, :page, { label_ids: [] } ).
                                merge(priority: params[:task][:priority])
  end
end
