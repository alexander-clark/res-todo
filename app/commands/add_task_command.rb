class AddTaskCommand
  include ActiveModel::Model
  include ActiveModel::Validations

  validates :name, presence: true

  def initialize(task_id: nil, name: nil)
    @task_id = task_id
    @name = name
  end

  attr_reader :task_id, :name
  alias :aggregate_id :task_id
end
