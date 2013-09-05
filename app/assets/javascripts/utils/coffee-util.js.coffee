root = global ? window
root.module = ( paquete ) ->
  packageMembers = paquete.split(".")
  level = root
  jQuery.each( packageMembers, (index, value) ->
    level[ value ] = level[ value ] ? { }
    level = level[ value ]
  )

root.extendClass = (o, m) ->
  o[name] = metodo for name, metodo of m
  o

root.includeModule = (c, m) ->
  root.extendClass(c.prototype, m)

_.extend(Backbone.View.prototype, {
  $$: (selector)->
    use_selector = if selector then selector else @el
    jQuery(use_selector)

  $document: ->
    jQuery(document)

  createTemplate: (selector) ->
    jq = jQuery(selector)
    @template = _.template(jq.html())

# deprecated
  create_template: (selector) -> @createTemplate(selector)

  createTemplateFor: (selector) ->
    jq = jQuery(selector)
    _.template(jq.html())

# deprecated
  create_template_for: (selector) -> @createTemplateFor(selector)

  renderTemplate: (data, template) ->
    use_template = if template
      template
    else if jQuery.isFunction(@template)
      @template
    else
      JST[@template]

    @$el.html(use_template(data))

# deprecated
  render_template: (data, template) -> @renderTemplate(data, template)

  append_to_template: (data, template) ->
    use_template = if template then template else @template
    @$el.append(use_template(data))

  setOrGet: (name, value) ->
    if value?
      @[name] = value
      @
    else
      @[name]

  confirm: (message, confirmed=(->), declined=(->)) ->
    if confirm(message)
      confirmed()
    else
      declined()

})

_.extend(Backbone.View, {
  $document: ->
    jQuery(document)
})

_.extend(Backbone.Model.prototype, {
  one: (ev, callback, context) ->
    that = @
    c = callback
    e = ev
    func = ->
      c.call(@)
      that.unbind(e, func)
    @bind(ev, func, context)


})

root.initializeTemplates = ->
  _.templateSettings = {
    interpolate : /\{-(.+?)-\}/g,
    evaluate : /<%([\s\S]+?)%>/g,
    autoEscape : /\{\{(.+?)\}\}/g
  }

root.initializeTemplates()


