module Types exposing (..)

import Ui.Checkbox
import Ui.Tabs
import GraphQL.Client.Http as GraphQLClient


type alias Model =
    { checkbox : Ui.Checkbox.Model
    , tabs : Ui.Tabs.Model
    , avr : AVR
    }


type alias AVRMutationResponse =
    Result GraphQLClient.Error String


type Msg
    = CheckboxMsg Ui.Checkbox.Msg
    | TabsMsg Ui.Tabs.Msg
    | AVRSetPowerState Bool
    | ReceiveAVRMutationResponse AVRMutationResponse


type alias AVR =
    { state : Bool
    , volume : Int
    }
