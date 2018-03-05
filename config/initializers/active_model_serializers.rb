# NOTE: Specify :json_api to comply with its spec.
#   http://www.rubydoc.info/gems/active_model_serializers
#   According to the official document ...
#   By default ActiveModelSerializers will use the Attributes Adapter (no JSON root).
#   But we strongly advise you to use JsonApi Adapter
ActiveModelSerializers.config.adapter = :json_api
# NOTE: AMS converts underscores to hyphens automatically to comply with recommendation of JSON API.
#   See: http://jsonapi.org/recommendations/#naming
#   The following setting disables that.
#   It doesn't mean this is recommendation. fast_jsonapi doesn't do so, for instance.
ActiveModel::Serializer.config.key_transform = :unaltered
