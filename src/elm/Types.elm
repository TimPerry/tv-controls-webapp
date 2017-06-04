module Types exposing (..)

import Ui.Checkbox
import Ui.Tabs
import Ui.Slider
import GraphQL.Client.Http as GraphQLClient


type alias Model =
    { checkbox : Ui.Checkbox.Model
    , tabs : Ui.Tabs.Model
    , slider : Ui.Slider.Model
    , avr : AVR
    }


type alias AVRMutationResponse =
    Result GraphQLClient.Error String


type Msg
    = CheckboxMsg Ui.Checkbox.Msg
    | TabsMsg Ui.Tabs.Msg
    | SliderMsg Ui.Slider.Msg
    | AVRSetPowerState Bool
    | AVRSetVolume Float
    | ReceiveAVRMutationResponse AVRMutationResponse


type alias AVR =
    { state : Bool
    , volume : Int
    }
