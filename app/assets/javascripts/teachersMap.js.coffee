
#////////////////////////////show teachers map
window.initialise_show_teachers_map = ->
  mapCanvas = document.getElementById('teacher_display_map')
  mapOptions = setMapOptions()
  mapOptions.zoom = 14 #override setMapOptions zoom level

  window.map = new google.maps.Map(mapCanvas, mapOptions)

  circleOptions = 
    strokeColor: '#FF0000'
    strokeOpacity: .8
    strokeWeight: 2
    fillColor: '#FF0000'
    fillOpacity: .35
    map: map
    center: mapOptions.center
    radius: 200

  googleCircle = new google.maps.Circle(circleOptions)
#///////////////////////////end of show teachers map

#////////////////////////////teachers info map
window.initialize = (id = "")->
  mapArray = []
  $("a[data-toggle=\"tab\"]").on "shown.bs.tab", (e) ->
    
    for m in mapArray
      google.maps.event.trigger(m, 'resize')
      m.setCenter(mapOptions.center)
    
    e.target # newly activated tab
    e.relatedTarget # previous active tab
  mapCanvas = document.getElementById("map_canvas#{id}")
  if gon.location[0] == null && gon.location[1] == null
    mapOptions = 
      center: new google.maps.LatLng(52.904281, -8.023571)
      zoom: 8
      mapTypeId: google.maps.MapTypeId.ROADMAP
  else
    mapOptions = setMapOptions()
  
  window.map = new google.maps.Map(mapCanvas, mapOptions)
  mapArray.push map
  window.marker = new google.maps.Marker(
        map: map
        position: mapOptions.center       
        )
  google.maps.event.addListener map, "click", (e) ->
    lat = e.latLng.lat()
    lon = e.latLng.lng()
    $('#lat').val(e.latLng.lat())
    $('#lon').val(e.latLng.lng())
    setMapPosition e.latLng, map.getZoom()

    google.maps.event.addListenerOnce map, "idle", ->
      google.maps.event.trigger map, "resize"
      map.setCenter new google.maps.LatLng(52.904281, -8.023571)
  return
  
  

window.start_address_search = (id = "") ->
  geocoder = new google.maps.Geocoder()
  geocoder.geocode address: $("#address#{id}").val(), (results, status) ->
    if status is google.maps.GeocoderStatus.OK
      # alert JSON.stringify results
      setMapPosition results[0].geometry.location, 16
      $("#lat#{id}").val results[0].geometry.location.lat()
      $("#lon#{id}").val results[0].geometry.location.lng()
    else
      alert "Geocode was not successful for the following reason: " + status
    return
  
setMapOptions = () ->
  mapOptions =
    center: new google.maps.LatLng(gon.location[0], gon.location[1])
    zoom: 16
    mapTypeId: google.maps.MapTypeId.ROADMAP
  return mapOptions

setMapPosition = (latlng, zoom = 8) ->
  map.setCenter latlng
  map.setZoom zoom
  marker.setPosition latlng
  
checkCoordsSet = () ->
  if gon.location[0] == null && gon.location[1] == null
    $('.coordsHinter').css('visibility', 'visible')

#//////////end of teachers info map

# Run initialize on dom ready if map_container is on screen
$(document).on 'ready page:load', ->  
  if $('#map_container').is(':visible')      
    load_google_maps_api('initialize')
    checkCoordsSet()
  else if $('#teacher_display_map').is(':visible')
    load_google_maps_api('initialise_show_teachers_map')
    

load_google_maps_api = (name) ->
  script = document.createElement("script")
  script.type = "text/javascript"
  script.src = "https://maps.googleapis.com/maps/api/js?v=3.exp&" + "callback=#{name}"
  document.body.appendChild script




window.getTab = ->  
  $.ajax 
    url: '/add-map'
    data: { map: 'hello' }

  

$(document).on 'click', 'a[href="#profile"]', ->
  $.when(getTab()).done ->
    $('#add_tab').attr disabled: 'disabled'
    $('#1').hide()
    setTimeout $('#location_tab').tab 'show'
    