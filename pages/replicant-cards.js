import React from "react";
import Link from "next/link";
function Replicant() {
  React.useEffect(() => {
    const { Elm } = require("../src/Replicant.elm");
    const app = Elm.Replicant.init({
      node: document.getElementById("replicant-node"),
    });
  });
  return (
    <div>
      <div id="replicant-node"></div>
      <Link href={"/posts/replicant-cards"}>
        <span className="text-blue-500 ml-4">read more</span>
      </Link>
    </div>
  );
}
export default Replicant;
