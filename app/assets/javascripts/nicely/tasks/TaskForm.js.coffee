module 'Nicely.Tasks'

class Nicely.Tasks.TaskForm extends Backbone.View

  events: {
    'click input' : 'logInput'
  }

  constructor: (options) ->
    super(options)
    @styledMap =new google.maps.StyledMapType(window.map_styles,
      {name: "Styled Map"})
    @map = new google.maps.Map(jQuery('#map_canvas')[0], {
      zoom: 14,
      scrollwheel: false,
      mapTypeControlOptions:
        mapTypeIds: [google.maps.MapTypeId.ROADMAP, 'map_style']
    })
    jQuery('textarea').autosize()
    @map.mapTypes.set('map_style', @styledMap)
    @map.setMapTypeId('map_style')
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
        details: 'form',
        markerOptions:
          draggable: false
          icon: 'http://www.google.com/mapfiles/dd-end.png'
      )

  logInput: ->
