module MapLocationsHelper

  def map_location_available?(map_location)
    map_location.present? && map_location.available?
  end

  def map_location_latitude(map_location)
    map_location.present? && map_location.latitude.present? ? map_location.latitude : Setting["map_latitude"]
  end

  def map_location_longitude(map_location)
    map_location.present? && map_location.longitude.present? ? map_location.longitude : Setting["map_longitude"]
  end

  def map_location_zoom(map_location)
    map_location.present? && map_location.zoom.present? ? map_location.zoom : Setting["map_zoom"]
  end

  def map_location_input_id(prefix, attribute)
    "#{prefix}_map_location_attributes_#{attribute}"
  end

  def map_location_remove_marker_link_id(map_location)
    "remove-marker-link-#{dom_id(map_location)}"
  end

  def render_map(map_location, parent_class, editable, remove_marker_label)
    map = content_tag_for :div,
                          map_location,
                          class: "map",
                          data: prepare_map_settings(map_location, editable, parent_class)
    map += map_location_remove_marker(map_location, remove_marker_label) if editable
    map
  end

  def map_location_remove_marker(map_location, text)
    content_tag :div, class: "text-right" do
      content_tag :a,
                  id: map_location_remove_marker_link_id(map_location),
                  href: "#",
                  class: "location-map-remove-marker-button delete" do
        text
      end
    end
  end

  private

  def prepare_map_settings(map_location, editable, parent_class)
    options = {
      map: "",
      map_center_latitude: map_location_latitude(map_location),
      map_center_longitude: map_location_longitude(map_location),
      map_zoom: map_location_zoom(map_location),
      map_tiles_provider: ENV['MAP_TILES_PROVIDER'],
      map_tiles_provider_attribution: ENV['MAP_TILES_PROVIDER_ATTRIBUTION'],
      marker_editable: editable,
      marker_latitude: map_location.latitude,
      marker_longitude: map_location.longitude,
      marker_remove_selector: "##{map_location_remove_marker_link_id(map_location)}",
      latitude_input_selector: "##{map_location_input_id(parent_class, 'latitude')}",
      longitude_input_selector: "##{map_location_input_id(parent_class, 'longitude')}",
      zoom_input_selector: "##{map_location_input_id(parent_class, 'zoom')}"
    }
  end

end
