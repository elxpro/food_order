function errorCallback(err) {
  console.log(err);
}

const DeliverPosition = {
  mounted() {
    const options = {
      enableHighAccuracy: true,
      timeout: 10000,
      maximumAge: 0,
    };
    navigator.geolocation.watchPosition(
      (pos) => {
        const {accuracy, latitude, longitude, altitude, heading, speed} = pos.coords;
        selector = this.el.id;
        // console.log(pos);
        document.getElementById(selector).append(
            `
            <div>
            accuracy: ${accuracy} 
            latitude: ${latitude} 
            longitude: ${longitude} 
            altitude: ${altitude} 
            heading: ${heading} 
            speed: ${speed}<hr />
            </div>`
        )
        this.pushEvent("update-order", {
          lat: latitude,
          lng: longitude,
        })
      },
      errorCallback,
      options
    );
  },
};

export default DeliverPosition;
