module Replicant exposing (main)

import Html
import Html.Attributes as Attributes


main =
    Html.div
        [ Attributes.style "width" "1024px"
        , Attributes.class "mx-auto border"
        ]
        [ Html.p [ Attributes.class "font-mono" ]
            [ Html.text "Replicants are here"
            ]
        ]
