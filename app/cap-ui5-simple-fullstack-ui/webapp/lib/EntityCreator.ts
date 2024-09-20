import FragmentLoader from "cftc/training/capui5simplefullstackui/lib/FragmentLoader";
import Controller from "sap/ui/core/mvc/Controller";
import Context from "sap/ui/model/odata/v2/Context";
import ODataModel from "sap/ui/model/odata/v2/ODataModel";
import { ISubmitSuccess } from "cftc/training/capui5simplefullstackui/types/EntityCreator";
import ResponseParser from "./ResponseParser";
import SmartForm from "sap/ui/comp/smartform/SmartForm";
import { ISubmitChangeResponse } from "cftc/training/capui5simplefullstackui/types/ResponseParser";
import BusyIndicator from "sap/ui/core/BusyIndicator";

/**
 * @namespace cftc.training.capui5simplefullstackui.lib
 */
export default class EntityCreator<EntityT extends object = object, ResponseT extends object = EntityT> extends FragmentLoader {
    private entityName: string;
    private entityPath: string;
    private oDataModel: ODataModel;
    private context: Context;
    private submitSuccess?: ISubmitSuccess<ResponseT>;

    constructor(controller: Controller, entity: string, fragmentPath: string) {
        super(controller, fragmentPath);
        this.entityPath = entity.startsWith("/") ? entity : `/${entity}`;
        this.entityName = this.entityPath.replace("/", "");
        this.oDataModel = this.view.getModel() as ODataModel;
    }

    public async create(initialData?: EntityT) {
        const context = this.createEntry(initialData);
        const dialog = await this.open();
        dialog.setBindingContext(context);
    }

    public async submit() {
        if (this.oDataModel.hasPendingChanges()) {
            BusyIndicator.show(0);

            this.oDataModel.submitChanges({
                success: (rawResponse?: ISubmitChangeResponse<ResponseT>) => {
                    BusyIndicator.hide();

                    const response = new ResponseParser<ResponseT>(rawResponse);
                    const statusType = response.getStatusType();

                    if (statusType === "Success") {
                        if (this.submitSuccess) {
                            this.submitSuccess.eventHandler.call(this.submitSuccess.listener, response);
                        }

                        this.close();
                    } else {
                        this.cancel();
                    }
                },
                error: () => {
                    BusyIndicator.hide();
                    this.cancel();
                }
            });
        } else {
            this.close();
        }
    }

    public async checkEntry(): Promise<object[] | string[]> {
        if (!(this.dialog.getContent()[0] instanceof SmartForm)) {
            throw new Error("This feature is only available for sap.ui.comp.smartform.SmartForm.");
        }

        return new Promise((resolve, reject) => {
            const validations = (this.dialog.getContent()[0] as SmartForm).check();

            if (validations instanceof Promise) {
                validations.then((results) => {
                    if (results.length) {
                        reject();
                    } else {
                        resolve(results);
                    }
                });
            } else {
                if (validations.length) {
                    reject();
                } else {
                    resolve(validations);
                }
            }
        });
    }

    public cancel() {
        if (this.oDataModel.hasPendingChanges()) {
            this.oDataModel.resetChanges([this.context.getPath()]);
        }

        this.close();
    }

    private createEntry(initialData?: EntityT) {
        const context = this.oDataModel.createEntry(this.entityPath, {
            properties: initialData
        });

        if (!context) {
            throw new Error("An unexpected error occured while creating the initial context.");
        }

        this.context = context;
        return this.context;
    }

    public attachSubmitSuccess(eventHandler: (response: ResponseParser<ResponseT>) => Promise<void> | void, listener?: object) {
        this.submitSuccess = {
            eventHandler: eventHandler,
            listener: listener || this.controller
        };
    }
}