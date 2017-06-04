module Mutations exposing (..)

import GraphQL.Request.Builder as GraphQL
import GraphQL.Request.Builder.Arg as Arg
import GraphQL.Request.Builder.Variable as Var
import GraphQL.Client.Http as GraphQLClient
import Types exposing (..)
import Task exposing (Task)


-- Common (NOTE: Server is setup wrong, only has queries. Should be mutations.)


sendMutationRequest : GraphQL.Request GraphQL.Query a -> Task GraphQLClient.Error a
sendMutationRequest request =
    GraphQLClient.sendQuery "http://tv-controls.server.home/" request



-- AVR


avrMutation : GraphQL.Document GraphQL.Query String { vars | state : Bool, volume : Int }
avrMutation =
    let
        stateVar =
            Var.required "state" .state Var.bool

        volumeVar =
            Var.required "volume" .volume Var.int
    in
        GraphQL.queryDocument <|
            GraphQL.extract
                (GraphQL.field "AVR"
                    [ ( "state", Arg.variable stateVar )
                    , ( "volume", Arg.variable volumeVar )
                    ]
                    GraphQL.string
                )


avrRequest : AVR -> GraphQL.Request GraphQL.Query String
avrRequest avr =
    avrMutation
        |> GraphQL.request { state = avr.state, volume = avr.volume }


sendAVRMutation : AVR -> Cmd Msg
sendAVRMutation avr =
    sendMutationRequest (avrRequest avr)
        |> Task.attempt ReceiveAVRMutationResponse
