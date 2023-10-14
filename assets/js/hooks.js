import LoadMoreProducts from "./hooks/loadMoreProducts";
import CartSession from "./hooks/cartSession";
import Drag from "./hooks/drag";
import GetAddress from "./hooks/GetAddress";
import Tracking from "./hooks/Tracking";

let Hooks = {
  LoadMoreProducts: LoadMoreProducts,
  CartSession: CartSession,
  Drag: Drag,
  GetAddress: GetAddress,
  Tracking: Tracking,
};

export default Hooks;
