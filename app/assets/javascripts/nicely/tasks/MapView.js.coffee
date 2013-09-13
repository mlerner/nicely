module 'Nicely.Tasks'

class Nicely.Tasks.MapView extends Nicely.Base
  attributes: {
    model: null
    startMarkerOptions:
      draggable: false
      icon: 'http://www.google.com/mapfiles/dd-start.png'
    endMarkerOptions:
      draggable: false
      icon: 'http://www.google.com/mapfiles/dd-end.png'
    mapStyles: window.map_styles,
    styledMap: null,
    mapOptions:
      zoom: 11,
      mapTypeControlOptions:
        mapTypeIds: [google.maps.MapTypeId.ROADMAP, 'map_style']
    map: null,
    startXY: null,
    startLatLng: null
    startMarker: null
    endXY: null
    endLatLng: null
    endMarker: null
    bounds: null
  }

  constructor: (model) ->
    @initializeAttributes(@attributes)
    @bounds(new google.maps.LatLngBounds())
    @model(model)
    @generateGoogleLatLngs()
    @setCenter()
    @styledMap(new google.maps.StyledMapType(@mapStyles(),
    {name: "Styled Map"}))

    @map( new google.maps.Map(document.getElementById('map-canvas'),
      @mapOptions()))
    @generateMarkers()

    console.log @endMarkerOptions()


    @map().mapTypes.set('map_style', @styledMap())
    @map().setMapTypeId('map_style')
    @map().fitBounds(@bounds())

  setCenter: ->
    if @startLatLng()?
      @mapOptions().center = @startLatLng()
    else if @endLatLng()?
      @mapOptions().center = @endLatLng()


  extendBounds: (latLng) ->
    @bounds().extend(latLng)

  generateMarkers: () ->
    @startMarkerOptions().map = @map()
    @startMarkerOptions().position = @startLatLng() if @startLatLng()?
    @startMarker(new google.maps.Marker(@startMarkerOptions()))

    @endMarkerOptions().map = @map()
    @endMarkerOptions().position = @endLatLng() if @endLatLng()?
    @endMarker(new google.maps.Marker(@endMarkerOptions()))

  generateGoogleLatLngs: ->
    if @model().start_xy?
      @startXY(@model().start_xy.coordinates)
      @startLatLng(new google.maps.LatLng(@startXY()[1], @startXY()[0]))
      @extendBounds(@startLatLng())

    if @model().end_xy?
      @endXY(@model().end_xy.coordinates)
      @endLatLng(new google.maps.LatLng(@endXY()[1], @endXY()[0]))
      @extendBounds(@endLatLng())


