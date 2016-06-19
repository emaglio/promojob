Trailblazer::NotAuthorizedError.class_eval do # this will extend the existing class, aka "monkey-patching"
    
  attr_reader :query, :record, :policy

  def initialize(options = {})
    if options.is_a? String
      message = options
    else
      @query  = options[:query]
      @record = options[:record]
      @policy = options[:policy]

      message = options.fetch(:message) { "not allowed to #{query} this #{record.inspect}" }
    end
  
    super(message)
  end
end