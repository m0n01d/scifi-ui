import React from "react";
function Replicant() {
  React.useEffect(() => {
    const { Elm } = require("../src/Replicant.elm");
    const app = Elm.Replicant.init({
      node: document.getElementById("replicant-node"),
    });
  });
  return <div id="replicant-node"></div>;
}
export default Replicant;
