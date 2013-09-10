module 'Nicely.Tasks'

class Nicely.Tasks.TaskView extends Backbone.View
  events: {
    'click #help-button': 'offerHelp',
    'click #report-button': 'offerHelp'
  }

  constructor: (model, options) ->
    @model = new Nicely.Tasks.Task(model)
    console.log @model.toJSON()
    super(options)
    @mapStyles = [
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
    @styledMap = new google.maps.StyledMapType(@mapStyles,
    {name: "Styled Map"})
    @mapOptions = {
      zoom: 11,
      center: new google.maps.LatLng(55.6468, 37.581),
      mapTypeControlOptions: {
        mapTypeIds: [google.maps.MapTypeId.ROADMAP, 'map_style']
      }
    }
    @map = map = new google.maps.Map(document.getElementById('map-canvas'),
      @mapOptions)
    @map.mapTypes.set('map_style', @styledMap);
    @map.setMapTypeId('map_style')

  offerHelp: (event) ->
    console.log 'offer received'
    event.preventDefault()