import {Elm }from "./Replicant.elm";
console.log({Elm})

class ElmLoader extends HTMLElement {

  constructor() {
    super();
  }
  connectedCallback() {
    Elm.Replicant.init({node: this});



  }
}
customElements.define('elm-replicant', ElmLoader, null);

