module CommandHandler
  def initialize
    store = Rails.configuration.event_store
    @repository = AggregateRoot::InstrumentedRepository.new(
      AggregateRoot::Repository.new(store),
      ActiveSupport::Notifications
    )
  end

  def with_aggregate(aggregate, aggregate_id, &block)
    stream = stream_name(aggregate.class, aggregate_id)
    repository.with_aggregate(aggregate, stream, &block)
  end

  private

  attr_reader :repository

  def stream_name(aggregate_class, aggregate_id)
    "#{aggregate_class}$#{aggregate_id}"
  end
end
