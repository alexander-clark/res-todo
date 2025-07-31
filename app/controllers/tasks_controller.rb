class TasksController < ApplicationController
  def index
    @tasks = Read::Task.all
    @command = AddTaskCommand.new
  end

  def show
    @task = Read::Task.find(params[:id])
  end

  def add
    command = AddTaskCommand.new(**task_params.merge(task_id: SecureRandom.uuid))
    if command.valid?
      Rails.configuration.command_bus.call(command)
      flash[:success] = 'Task added'
      redirect_to tasks_path
    else
      @command = command
      @tasks = Read::Task.all
      flash[:error] = 'Task could not be added'
      render :index, status: :unprocessable_entity
    end
  end

  private

  def task_params
    params.require(:task).permit(:name).to_h.symbolize_keys
  end
end
