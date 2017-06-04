module State exposing (..)

import Types exposing (..)
import Ui.Tabs
import Ui.Checkbox
import Ui.Slider
import Mutations exposing (sendAVRMutation)


init : ( Model, Cmd Msg )
init =
    ( { checkbox = Ui.Checkbox.init ()
      , tabs = Ui.Tabs.init ()
      , slider = Ui.Slider.init ()
      , avr = { state = True, volume = 55 }
      }
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        CheckboxMsg msg ->
            let
                ( subModel, subMsg ) =
                    Ui.Checkbox.update msg model.checkbox
            in
                ( { model | checkbox = subModel }, Cmd.map CheckboxMsg subMsg )

        TabsMsg msg ->
            let
                ( subModel, subMsg ) =
                    Ui.Tabs.update msg model.tabs
            in
                ( { model | tabs = subModel }, Cmd.map TabsMsg subMsg )

        SliderMsg msg ->
            let
                ( subModel, subMsg ) =
                    Ui.Slider.update msg model.slider
            in
                ( { model | slider = subModel }, Cmd.map SliderMsg subMsg )

        AVRSetVolume newVolume ->
            let
                currentAvr =
                    model.avr

                newAvr =
                    { currentAvr | volume = (floor newVolume) }

                newModel =
                    { model | avr = newAvr }
            in
                ( newModel, sendAVRMutation newAvr )

        AVRSetPowerState newState ->
            let
                currentAvr =
                    model.avr

                newAvr =
                    { currentAvr | state = newState }

                newModel =
                    { model | avr = newAvr }
            in
                ( newModel, sendAVRMutation newAvr )

        ReceiveAVRMutationResponse response ->
            ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Ui.Checkbox.onChange AVRSetPowerState model.checkbox
        , Ui.Slider.onChange AVRSetVolume model.slider
        ]
