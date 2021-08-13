module Replicant exposing (main)

import Browser
import Html exposing (Html)
import Html.Attributes as Attributes
import Html.Events as Events
import Json.Decode as Decode
import Process
import SelectList exposing (SelectList)
import Task


type alias Model =
    { androids : SelectList Android
    , screen : ScreenState
    }


type ScreenState
    = Avatar
    | Information


type alias Android =
    { gender : String
    , id : String
    , inceptDate : String
    , func : String
    , phys : Maybe String
    , ment : Maybe String
    , name : ( String, Maybe String )
    , picture : String
    }


roy =
    Android
        "M"
        "N6MAA10816"
        "8 JAN., 2016"
        "Combat, Colonization Defense Prog."
        (Just "LEV. A")
        (Just "LEV. A")
        ( "Batty", Just "Roy" )
        "https://www.lorempixel.com/1024/768"


zhora =
    Android
        "F"
        "N6FAB61216"
        "12 JUNE, 2016"
        "Retrained(9 Feb.,2018)Polit. Homicide"
        (Just "LEV. A")
        (Just "LEV. B")
        ( "Zhora", Nothing )
        "https://www.fillmurray.com/1024/768"


pris =
    Android
        "F"
        "N6FAB21416"
        "14 FEB, 2016"
        "Military / Leisure"
        (Just
            "LEV. A"
        )
        (Just
            "LEV. B"
        )
        ( "Pris", Nothing )
        "https://www.stevensegallery.com/1024/768"


leon =
    Android
        "M"
        "N6MAC41717"
        "10 APRIL., 2017"
        "Combat / Loader (Nuc. Fiss.)"
        (Just
            "LEV. A"
        )
        (Just
            "LEV. C"
        )
        ( "Leon", Nothing )
        "https://www.placecage.com/1024/768"


androids =
    [ roy, zhora, pris, leon ]


viewNexusData : Model -> Android -> Html Msg
viewNexusData model android =
    let
        ( surname, maybeFirstName ) =
            name

        { gender, name, id, inceptDate, func, phys, ment, picture } =
            android
    in
    Html.div [ Attributes.class "flex flex-col " ]
        [ Html.img
            [ Attributes.src <| String.concat [ picture, "?id=", id ]
            , Attributes.classList
                [ ( "flex-1 block ", True )
                , ( "ml-5 w-1/2 transition-all", model.screen == Information )
                , ( "w-full", model.screen == Avatar )
                ]
            , Events.on "transitionend" (Decode.succeed WaitAndCycleNextDroid)
            ]
            []
        , Html.div
            [ Attributes.class "flex-1 px-3 overflow-hidden font-serif text-5xl border-black opacity-100 xborder-t-4 xpy-5 bg-blue-50"
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
                    , Html.span []
                        [ phys
                            |> Maybe.withDefault ""
                            |> Html.text
                        ]
                    , Html.div [ Attributes.class "ml-auto" ]
                        [ Html.label [ Attributes.class "mr-1" ] [ Html.text "Ment:" ]
                        , Html.span []
                            [ ment
                                |> Maybe.withDefault ""
                                |> Html.text
                            ]
                        ]
                    ]
                ]
            ]
        ]


view : Model -> Html Msg
view model =
    Html.div
        [ Attributes.style "width" "1024px"
        , Attributes.style "height" "768px"
        , Attributes.class "mx-auto overflow-hidden border"
        ]
        [ viewNexusData model <| SelectList.selected model.androids
        ]


type Msg
    = CycleNextDroid
    | CycleScreen
    | WaitAndCycleNextDroid


nextDroid =
    Process.sleep 3000
        |> Task.perform (always CycleNextDroid)


nextScreen =
    Process.sleep 3000
        |> Task.perform (always CycleScreen)


defaultAndroids =
    SelectList.fromLists [] leon [ roy, zhora, pris ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        WaitAndCycleNextDroid ->
            ( model, nextDroid )

        CycleNextDroid ->
            ( { model
                | screen = Avatar
                , androids =
                    SelectList.selectBy 1 model.androids
                        |> Maybe.withDefault defaultAndroids
              }
            , nextScreen
            )

        CycleScreen ->
            ( { model
                | screen =
                    Information
              }
            , Cmd.none
            )


init : () -> ( Model, Cmd Msg )
init _ =
    ( { androids = defaultAndroids
      , screen = Avatar
      }
    , nextScreen
    )


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = always Sub.none
        }


parens s =
    String.concat
        [ "("
        , s
        , ")"
        ]



{-
   -- next time
   -- animation
   -- Start Portrait
   -- animates into displaying card
   -- settimeout
   -- select next card
   -- text typing effect
   -- after typing is over move to next android

-}
