const CartSession = {
    mounted(){
        this.handleEvent("create_cart_session_id", map => {
            console.log(map)
            var {cart_id: cart_id} = map;
            sessionStorage.setItem("cart_id", cart_id);
         })
    }
}

export default CartSession;