import L from "leaflet";
export default class LeafletMap {
  constructor(element, center, markerClickedCallback) {
    this.map = L.map(element).setView(center, 13);
    const accessToken =
      "pk.eyJ1IjoiZ3V1aG9saSIsImEiOiJja2c5bWVuaGwwc281MnNwZ3RtMjVlaWFuIn0.c8uUwyoB-wHJnrPEotEGSw";
    L.tileLayer(
      "https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}",
      {
        attribution: "Gustavo Oliveira",
        maxZoom: 40,
        id: "mapbox/streets-v12",
        tileSize: 512,
        zoomOffset: -1,
        accessToken: accessToken,
      }
    ).addTo(this.map);

    this.markerClickedCallback = markerClickedCallback;
  }

  addMarker(order) {
    console.log(order);
    const marker = L.marker([order.lat, order.lng], {
      orderId: order.id,
    })
      .addTo(this.map)
      .bindPopup(
        `
        hi
      `
      );

    marker.on("click", (e) => {
      marker.openPopup();
      // this.markerClickedCallback(e);
    });

    return marker;
  }

  //   highlightMarker(restaurant) {
  //     const marker = this.markerRestaurant(restaurant);
  //     marker.openPopup();
  //     this.map.panTo(marker.getLatLng());
  //   }

  //   markerRestaurant(restaurant) {
  //     let markerLayer;
  //     this.map.eachLayer((layer) => {
  //       if (layer instanceof L.Marker) {
  //         const position = layer.getLatLng();
  //         if (
  //           position.lat === restaurant.latitude &&
  //           position.lng === restaurant.longitude
  //         ) {
  //           markerLayer = layer;
  //         }
  //       }
  //     });
  //     return markerLayer;
  //   }
}
