import {Elm }from "./Replicant.elm";
console.log({Elm})

class ElmLoader extends HTMLElement {

  constructor() {
    super();
  }
  connectedCallback() {
    Elm.Replicant.init({node: this});
    console.log('init')



  }
}
customElements.define('elm-replicant', ElmLoader, null);

