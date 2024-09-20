import Controller from "sap/ui/core/mvc/Controller";
import EntityCreator from "cftc/training/capui5simplefullstackui/lib/EntityCreator";
import { ICategory, ICategoryResponse } from "cftc/training/capui5simplefullstackui/types/Homepage";
import MessageToast from "sap/m/MessageToast";
import Messaging from "sap/ui/core/Messaging";
import View from "sap/ui/core/mvc/View";
import Fragment from "sap/ui/core/Fragment";
import Control from "sap/ui/core/Control";
import MessagePopover from "sap/m/MessagePopover";
import Button, { Button$PressEvent } from "sap/m/Button";

/**
 * @namespace cftc.training.capui5simplefullstackui.controller
 */
export default class Homepage extends Controller {
    private newCategory: EntityCreator<ICategory, ICategoryResponse>;

    /*eslint-disable @typescript-eslint/no-empty-function*/
    public onInit(): void {
        this.attachMessageHandlers();
        const messageModel = Messaging.getMessageModel();
        this.getCurrentView().setModel(messageModel, "message");
        Messaging.registerObject(this.getView() as View, true);
    }

    public getCurrentView() {
        return this.getView() as View;
    }

    public async onMessagePopoverPress(event: Button$PressEvent) {
        const messagePopover = await (Fragment.load({
            id: this.getCurrentView().getId(),
            name: "cftc.training.capui5simplefullstackui.fragments.core.MessagePopover",
            controller: this
        }) as Promise<Control | Control[]>);

        this.getCurrentView().addDependent(messagePopover as MessagePopover);
        (messagePopover as MessagePopover).openBy(event.getSource());
    }

    public onClearMessages() {
        Messaging.removeAllMessages();
    }

    public onCreateCategory() {
        this.newCategory = new EntityCreator<ICategory, ICategoryResponse>(this, "Categories", "cftc.training.capui5simplefullstackui.fragments.category.NewCategory");
        this.newCategory.create();
    }

    public async onCompleteNewCategory() {
        try {
            await this.newCategory.checkEntry();
            this.newCategory.submit();
        } catch (error) {
            MessageToast.show("Error");
        }
    }

    public onCancelNewCategory() {
        this.newCategory.cancel();
    }

    private attachMessageHandlers() {
        this.getCurrentView().attachValidationError(() => {
            (this.getCurrentView().byId("btnMessages") as Button).firePress();
        });
        this.getCurrentView().attachParseError(() => {
            (this.getCurrentView().byId("btnMessages") as Button).firePress();
        });
    }
}