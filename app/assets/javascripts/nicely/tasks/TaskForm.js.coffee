module 'Nicely.Tasks'

class Nicely.Tasks.TaskForm extends Backbone.View

  events: {
    'click input' : 'logInput'
  }

  constructor: (options) ->
    super(options)
    @map = new google.maps.Map(jQuery('#map_canvas')[0], {
      zoom: 14,
      scrollwheel: false,
      mapTypeId: "roadmap"
    })
    @$('input[name="task[start_loc]"]')
      .geocomplete(
        map: @map,
        tag: 'start'
        details: 'form'
        markerOptions:
          draggable: false
          icon: 'http://www.google.com/mapfiles/dd-start.png'
      )
    @$('input[name="task[end_loc]"]')
      .geocomplete(
        map: @map,
        tag: 'end',
        details: 'form'
      )

  logInput: ->
