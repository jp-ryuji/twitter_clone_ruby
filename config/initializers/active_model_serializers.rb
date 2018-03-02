# NOTE: Specify :json_api to comply with its spec.
#   http://www.rubydoc.info/gems/active_model_serializers
#   According to the official document ...
#   By default ActiveModelSerializers will use the Attributes Adapter (no JSON root).
#   But we strongly advise you to use JsonApi Adapter
ActiveModelSerializers.config.adapter = :json_api
