import Dialog from "sap/m/Dialog";
import BaseObject from "sap/ui/base/Object";
import Control from "sap/ui/core/Control";
import Fragment from "sap/ui/core/Fragment";
import Controller from "sap/ui/core/mvc/Controller";
import View from "sap/ui/core/mvc/View";

/**
 * @namespace cftc.training.capui5simplefullstackui.lib
 */
export default abstract class FragmentLoader extends BaseObject {
    protected view: View;
    protected controller: Controller;
    protected dialog: Dialog;
    private path: string;
    private escapeHandler = true;

    constructor(controller: Controller, path: string) {
        super();
        this.controller = controller;
        this.path = path;
        this.view = controller.getView() as View;
    }

    protected async open(viewDependent: boolean = true) {
        const dialog = await this.load();

        if (viewDependent) {
            this.view.addDependent(dialog);
        }

        this.dialog.open();
        return this.dialog;
    }

    protected close() {
        this.dialog.close();
        this.destroyDialog();
    }

    private async load() {
        const content = await (Fragment.load({
            id: this.view.getId(),
            name: this.path,
            controller: this.controller
        }) as Promise<Control | Control[]>);

        if (!(content instanceof Dialog)) {
            throw new Error("The loaded fragment does not contain a sap.m.Dialog.");
        }

        if (!this.dialog.getContent().length) {
            throw new Error("The loaded sap.m.Dialog does not contain any content.");
        }

        this.dialog = content;

        if (this.escapeHandler) {
            this.dialog.setEscapeHandler(this.onEscapePressed);
        }

        return this.dialog;
    }

    private onEscapePressed(event: { resolve: Function; reject: Function; }) {
        event.resolve();
        this.destroyDialog();
    }

    private destroyDialog() {
        if (!this.dialog.isDestroyed()) {
            this.dialog.destroy();
        }
    }

    public disableEscapeHandler() {
        this.escapeHandler = false;
    }
}