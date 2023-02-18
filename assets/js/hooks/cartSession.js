const CartSession = {
    mounted(){
        this.handleEvent("create_cart_session_id", map => {
            var {cartId: cartId} = map
            sessionStorage.setItem("cart_id", cartId)
        })
    }
}

export default CartSession;