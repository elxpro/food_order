import LeafletMap from "./LeafletMap";

const Tracking = {
  mounted() {
    if (navigator.geolocation) {
      order = JSON.parse(this.el.dataset.order);
      navigator.geolocation.getCurrentPosition((pos) => {
        lat = pos.coords.latitude;
        lng = pos.coords.longitude;
        this.map = new LeafletMap(this.el, [lat, lng], (event) => {});
        this.map.addMarker(order);
      });
      
      this.handleEvent("update-deliver-location", (deliver) => {
        this.map.updateDeliver(deliver);
        // this.map.highlightMarker(restaurant);
      });
    }
  },
};

export default Tracking;
