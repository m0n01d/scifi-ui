class ElmLoader extends HTMLElement {
  constructor() {
    super();
  }
  connectedCallback() {
    const { Elm } = require("./Replicant.elm");
    Elm.Replicant.init({ node: this });
  }
}
customElements.define("elm-replicant", ElmLoader, null);
