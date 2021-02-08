module Main exposing (..)

import Browser
import Debug exposing (toString)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import Time


main : Program () Model Msg
main =
    Browser.sandbox { init = init, view = view, update = update }


type alias Model =
    { furniture : String
    , calculationFinished : Bool
    , intelligenceQuotient : Int
    }


init : Model
init =
    Model "" False 0


type Msg
    = Calculate
    | SetFurniture String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Calculate ->
            { model | intelligenceQuotient = 42 }

        SetFurniture name ->
            { model | furniture = name }


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


view : Model -> Html Msg
view model =
    div []
        [ div []
            [ select [ onInput SetFurniture ]
                [ option [ value "chair" ] [ text "Chair" ]
                , option [ value "table" ] [ text "Table" ]
                ]
            ]
        , div []
            [ button [ onClick Calculate ] [ text "Calculate" ]
            ]
        , viewIntelligenceQuotient model.calculationFinished model.intelligenceQuotient
        ]


viewIntelligenceQuotient : Bool -> Int -> Html Msg
viewIntelligenceQuotient calculationFinished intelligenceQuotient =
    if calculationFinished then
        div [ style "color" "red" ] [ text "Calculating..." ]

    else
        div [ style "color" "green" ] [ text ("Your IQ: " ++ toString intelligenceQuotient) ]
