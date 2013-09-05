module 'Kindly'

Kindly.base_module = {
  initializeAttributes: (attributes) ->
    @initAttribute(k,v) for k,v of attributes

  setOrGet: (name, value) ->
    if value != undefined
      @[name] = value
      @
    else
      @[name]

  initAttribute: (attr, d) ->
    @.constructor::[attr] = (value) ->
      @setOrGet(name, value)

    name = "_#{attr}"
    if _.isObject(d) &&
    !_.isFunction(d) &&
    (d.constructor == Object.prototype.constructor || d.constructor == Array.prototype.constructor)
      @[name] = _.clone(d)
    else
      @[name] = d

  create_template: (selector) ->
    jq = jQuery(selector)
    @template = _.template(jq.html())

  create_template_for: (selector) ->
    jq = jQuery(selector)
    _.template(jq.html())
}