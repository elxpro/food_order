import LeafletMap from "./LeafletMap";

const Tracking = {
  mounted() {
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition((pos) => {
        lat = pos.coords.latitude;
        lng = pos.coords.longitude;
        this.map = new LeafletMap(this.el, [lat, lng], (event) => {});
        // this.map.addMarker(restaurant);
      });
    }
  },
};

export default Tracking;
