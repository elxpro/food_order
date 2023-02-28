import Sortable from "sortablejs";
const Drag = {
  mounted() {
    const hook = this;
    const selector = "#" + hook.el.id;
    const el = document.getElementById(hook.el.id);

    new Sortable(el, {
      group: "shared",
      draggable: ".draggable",
      onEnd: function (evt) {
        hook.pushEventTo(selector, "dropped", {
          old_status: evt.from.id,
          new_status: evt.to.id,
          order_id: evt.item.id,
        });
      },
    });
  },
};

export default Drag;
