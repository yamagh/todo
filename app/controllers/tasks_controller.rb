class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy, :toggle]
  before_action :authenticate_user!, only: [:index]

  # GET /tasks
  # GET /tasks.json
  def index
    @task = Task.new
    #@tasks = Task.all
    @tasks = Task.where("user_id = ?", current_user.id)
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_title)
    @task.done = false
    @task.done_at = nil
    @task.user_id = current_user.id

    respond_to do |format|
      if @task.save
        format.html { redirect_to tasks_path, notice: 'タスクを追加しました' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { redirect_to tasks_path, alert: 'タスクの追加に失敗しました' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def toggle
    @task.done = !@task.done
    @task.done_at = @task.done ? Time.now : nil
    @task.save
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:title, :done, :done_at)
    end

    def task_title
      params.require(:task).permit(:title)
    end
end
