import ResponseParser from "cftc/training/capui5simplefullstackui/lib/ResponseParser";

export interface ISubmitSuccess<EntityT extends object = object> {
    eventHandler: (response: ResponseParser<EntityT>) => Promise<void> | void;
    listener: object;
}