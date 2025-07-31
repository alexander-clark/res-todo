module Write
  class Task
    include AggregateRoot

    def initialize(task_id: SecureRandom.uuid)
      @task_id = task_id
    end

    def add(task_id:, name:)
      apply TaskAdded.new(data: { task_id:, name: })
    end

    on TaskAdded do |event|
      @task_id = event.data.fetch(:task_id)
      @name = event.data.fetch(:name)
    end

  end
end
