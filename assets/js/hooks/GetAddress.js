



const GetAddress = {

    mounted() {

        // console.log(this)
        // console.log(this.el)
        // console.log(this.el.id)
        var address = document.getElementById(this.el.id)
        // console.log(address)
        // this.el.value = "pumpkin"

        // get the position
        // console.log(navigator)

        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition((pos) => {
                const lat = pos.coords.latitude;
                const lng = pos.coords.longitude;
                // console.log(lat)
                // console.log(lng)
                this.pushEventTo("#cart-details", "get-address", { lat: lat, lng: lng }, (reply, ref) => {
                    // console.log("reply")
                    // console.log(reply)
                    const { address: value } = reply;
                    this.el.value = value
                    // console.log(ref)
                })
            })
        }


    }
}
export default GetAddress