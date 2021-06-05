import React from 'react'
function Replicant() {
  React.useEffect(() => import("../src/ElmLoader.js"));
  return <elm-replicant></elm-replicant>
}
export default Replicant;
