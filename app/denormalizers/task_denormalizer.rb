class TaskDenormalizer
  def call(event)
    case event
    when TaskAdded
      task = Read::Task.new
      task.id = event.data.fetch(:task_id)
      task.name = event.data.fetch(:name)
      task.save!
    end
  end
end
