class AddTaskCommandHandler
  include CommandHandler

  def call(command)
    with_aggregate(Write::Task.new, command.aggregate_id) do |task|
      task.add(task_id: command.aggregate_id, name: command.name)
    end
  end
end
