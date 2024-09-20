import BaseObject from "sap/ui/base/Object";
import { ISubmitChangeResponse } from "cftc/training/capui5simplefullstackui/types/ResponseParser";

export default class ResponseParser<EntityT extends object = object> extends BaseObject {
    private response?: ISubmitChangeResponse<EntityT>;
    private data: EntityT | null;
    private statusCode: string | null;
    private statusType: "Success" | "Error";

    constructor(response?: ISubmitChangeResponse<EntityT>) {
        super();
        this.response = response;
        this.parse();
    }

    public getData() {
        return this.data;
    }

    public getStatusType() {
        return this.statusType;
    }

    public getStatusCode() {
        return this.statusCode;
    }

    private parse() {
        if (this.response) {
            if (this.response.__batchResponses.length) {
                this.statusCode = this.response.__batchResponses[0].response?.statusCode || null;

                if (!this.statusCode && this.response.__batchResponses[0].__changeResponses) {
                    this.statusCode = this.response.__batchResponses[0].__changeResponses[0].statusCode ||
                        this.response.__batchResponses[0].__changeResponses[0].response?.statusCode || null;
                }

                if (this.statusCode) {
                    if (this.statusCode.startsWith("4") || this.statusCode.startsWith("5")) {
                        this.data = null;
                        this.statusType = "Error";
                    } else {
                        this.statusType = "Success";

                        if (this.response.__batchResponses[0].__changeResponses) {
                            this.data = this.response.__batchResponses[0].__changeResponses[0].data || null;
                        } else {
                            this.data = null;
                        }
                    }
                } else {
                    this.data = null;
                    this.statusType = "Error";
                }
            } else {
                this.data = null;
                this.statusCode = null;
                this.statusType = "Error";
            }
        } else {
            this.data = null;
            this.statusCode = null;
            this.statusType = "Error";
        }
    }
}