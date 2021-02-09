module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import Process
import String exposing (fromInt)
import Task


main =
    Browser.element { init = init, update = update, subscriptions = subscriptions, view = view }


type alias Model =
    { furniture : Maybe String
    , calculating : Bool
    , intelligenceQuotient : Maybe Int
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model Nothing False Nothing, Cmd.none )


type Msg
    = Calculate
    | CalculationFinished Int
    | SetFurniture String
    | Reset


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Calculate ->
            ( { model | calculating = True }
            , Process.sleep 2000 |> Task.perform (always (CalculationFinished 42))
            )

        CalculationFinished iq ->
            ( { model | calculating = False, intelligenceQuotient = Just iq }
            , Cmd.none
            )

        SetFurniture name ->
            ( { model | furniture = Just name }
            , Cmd.none
            )

        Reset ->
            ( { model | intelligenceQuotient = Nothing }
            , Cmd.none
            )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


view : Model -> Html Msg
view model =
    div panelStyle
        [ div []
            [ select [ onInput SetFurniture ]
                [ option [ value "" ] [ text "<Select>" ]
                , option [ value "chair" ] [ text "Chair" ]
                , option [ value "table" ] [ text "Table" ]
                ]
            ]
        , div []
            [ button [ style "background-color" "red", onClick Calculate ] [ text "Calculate" ]
            ]
        , viewIntelligenceQuotient model.calculating model.intelligenceQuotient
        ]


viewIntelligenceQuotient : Bool -> Maybe Int -> Html Msg
viewIntelligenceQuotient calculating intelligenceQuotient =
    if calculating == True then
        div [ style "color" "red" ] [ text "Calculating..." ]

    else
        case intelligenceQuotient of
            Nothing ->
                div [] []

            Just iq ->
                div [ style "color" "green" ] [ text ("Your IQ: " ++ fromInt iq) ]


panelStyle : List (Attribute msg)
panelStyle =
    [ style "margin" "auto"
    , style "width" "50%"
    , style "height" "50%"
    ]
