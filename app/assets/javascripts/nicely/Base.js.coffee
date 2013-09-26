module 'Nicely'

window.map_styles = [
  {
    stylers: [
      {
        'hue': "#3498db"
      }
    ]
  },
  {
    "featureType": "labels",
    "stylers": [
      {
        "visibility": "on"
      }
    ]
  },
  {
    "featureType": "road",
    "stylers": [
      {
        "visibility": "on"
      },
      {}
    ]
  },
  {
    "featureType": "water",
    "stylers": [
      {
        "visibility": "on"
      },
      {}
    ]
  },
  {
    "featureType": "poi",
    "stylers": [
      {
        "visibility": "on"
      },
      {}
    ]
  },
  {
    "featureType": "landscape",
    "stylers": [
      {
        "visibility": "on"
      },
      {}
    ]
  }
]

_.templateSettings = {
  evaluate : /\{\[([\s\S]+?)\]\}/g,
  interpolate : /\{\{([\s\S]+?)\}\}/g
}

Nicely.base_module = {

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

class Nicely.Base
  includeModule(@,Backbone.Events)
  includeModule(@,Nicely.base_module)

  constructor: ->
  $: (selector, scope) ->
    scope.find(selector)

  $$: (selector) ->
    jQuery(selector)

  $document: ->
    jQuery(document)

  one: (ev, callback, context) ->
    that = @
    c = callback
    e = ev
    func = ->
      c.call(@)
      that.unbind(e, func)
    @bind(ev, func, context)

  createHandler: (handler) ->
    (->
      args = Array.prototype.slice.call(arguments)
      args.unshift(this)
      handler.apply(null, args)
    )