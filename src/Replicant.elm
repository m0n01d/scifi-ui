module Replicant exposing (main)

import Html exposing (Html)
import Html.Attributes as Attributes


viewNexusData : () -> Html msg
viewNexusData android =
    let
        gender =
            "M"

        ( surname, maybeFirstName ) =
            ( "BATTY", Just "Roy" )

        id =
            "N6MAA10816"

        inceptDate =
            "8 JAN., 2016"

        func =
            "Combat, Colonization Defense Prog."

        phys =
            "LEV. A"

        ment =
            "LEV. A"

        parens s =
            String.concat
                [ "("
                , s
                , ")"
                ]
    in
    Html.div
        [ Attributes.class "px-3 py-5 font-serif text-5xl border-t-4 border-black"
        ]
        [ Html.div [ Attributes.class "flex" ]
            [ Html.div [ Attributes.class "mr-2" ]
                [ Html.label
                    [ Attributes.class "mr-2"
                    ]
                    [ Html.text "Replicant" ]
                , Html.span []
                    [ Html.text <| parens gender
                    ]
                ]
            , Html.div [ Attributes.class "mr-2" ]
                [ Html.label [ Attributes.class "mr-3" ] [ Html.text "Des:" ]
                , Html.span []
                    [ [ Just surname, Maybe.map parens maybeFirstName ]
                        |> List.filterMap identity
                        |> String.join " "
                        |> Html.text
                    ]
                ]
            ]
        , Html.div []
            [ Html.label
                [ Attributes.class "mr-4"
                ]
                [ Html.text "NEXUS 6" ]
            , Html.span [] [ Html.text id ]
            ]
        , Html.div []
            [ Html.label [ Attributes.class "mr-4" ] [ Html.text "Incept Date:" ]
            , Html.span [] [ Html.text inceptDate ]
            ]
        , Html.div []
            [ Html.label [ Attributes.class "mr-1" ]
                [ Html.text "Func:"
                ]
            , Html.span [] [ Html.text func ]
            ]
        , Html.div
            [ Attributes.class "flex pr-48" ]
            [ Html.div []
                [ Html.label [ Attributes.class "mr-1" ] [ Html.text "Phys:" ]
                , Html.span [] [ Html.text phys ]
                ]
            , Html.div [ Attributes.class "ml-auto" ]
                [ Html.label [ Attributes.class "mr-1" ] [ Html.text "Ment:" ]
                , Html.span [] [ Html.text ment ]
                ]
            ]
        ]



{-

   for now we're only working on layout and dumb views


    Next time:
    template json, cycle through replicants
-}


main : Html msg
main =
    Html.div
        [ Attributes.style "width" "1024px"
        , Attributes.class "mx-auto border"
        ]
        [ Html.img
            [ Attributes.src "https://www.fillmurray.com/1024/768"
            , Attributes.class "block w-1/2 ml-5"
            ]
            []
        , viewNexusData ()
        ]
