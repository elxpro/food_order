import LoadMoreProducts from "./hooks/loadMoreProducts";
import CartSession from "./hooks/cartSession";
import Drag from "./hooks/drag";
import GetAddress from "./hooks/GetAddress";
import Tracking from "./hooks/Tracking";
import DeliverPosition from "./hooks/DeliverPosition";

let Hooks = {
  LoadMoreProducts: LoadMoreProducts,
  CartSession: CartSession,
  Drag: Drag,
  GetAddress: GetAddress,
  Tracking: Tracking,
  DeliverPosition: DeliverPosition,
};

export default Hooks;
