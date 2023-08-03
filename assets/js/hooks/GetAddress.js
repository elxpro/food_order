const GetAddress = {
    mounted() {
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition((pos) => {
                const lat = pos.coords.latitude;
                const lng = pos.coords.longitude;

                this.pushEventTo("#cart-details", "get-address", { lat, lng }, (reply, ref) => {
                    const { address } = reply;
                    this.el.value = address
                })
            })
        }
    }
}

export default GetAddress;