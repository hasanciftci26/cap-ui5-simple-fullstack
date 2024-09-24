import { ApplicationService, Request } from "@sap/cds";

export default class OnlineShopping extends ApplicationService {
    async init() {

        this.before("READ", "Customers", (req: Request) => {

        });

        return super.init();
    }
}