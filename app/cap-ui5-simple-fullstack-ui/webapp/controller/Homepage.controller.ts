import Controller from "sap/ui/core/mvc/Controller";
import EntityCreator from "cftc/training/capui5simplefullstackui/lib/EntityCreator";
import { ICategory, ICategoryResponse } from "cftc/training/capui5simplefullstackui/types/Homepage";

/**
 * @namespace cftc.training.capui5simplefullstackui.controller
 */
export default class Homepage extends Controller {

    /*eslint-disable @typescript-eslint/no-empty-function*/
    public onInit(): void {

    }

    public onCreateCategory() {
        const entity = new EntityCreator<ICategory, ICategoryResponse>(this, "Categories", "cftc.training.capui5simplefullstackui.fragments.category.NewCategory");
        entity.create();
    }
}