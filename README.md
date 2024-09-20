# Online Shopping Simple CAP-UI5 Application

## Run Application

1) Clone the repo and install the dependencies with the following commands:

    ```sh
    git clone https://github.com/hasanciftci26/cap-ui5-simple-fullstack.git
    npm install --include=dev
    cd app/router
    npm install --include=dev
    cd app/cap-ui5-simple-fullstack-ui
    npm install --include=dev
    ```

2) Run the following commands:

    ```sh
    cf create-service xsuaa application cap-ui5-simple-fullstack-auth
    cf create-service hana hdi-shared cap-ui5-simple-fullstack-db
    cf create-service destination lite cap-ui5-simple-fullstack-dest
    ```

3) Bind the services with the following command:

    ```sh
    cds bind --to cap-ui5-simple-fullstack-auth,cap-ui5-simple-fullstack-db,cap-ui5-simple-fullstack-dest
    ```

4) Retrieve the guid of the xsuaa service with the command below:

    ```sh
    cf service cap-ui5-simple-fullstack-auth --guid
    ```

5) Retrieve the credentials of the xsuaa service with the command below:

    ```sh
    cf service-key cap-ui5-simple-fullstack-auth cap-ui5-simple-fullstack-auth-key
    ```

6) Paste the **guid** value retrieved in the step 4 into the **instance_guid** field below, and replace the **credentials** object with the values retrieved in the step 5.

    ```json
    {
       "xsuaa":[
          {
             "instance_guid": "",
             "instance_name": "cap-ui5-simple-fullstack-auth",
             "name": "cap-ui5-simple-fullstack-auth",
             "label": "xsuaa",
             "plan": "application",
             "tags": [
                "xsuaa"
             ],
             "credentials": {
                "apiurl": "",
                "clientid": "",
                "clientsecret": "",
                "credential-type": "",
                "identityzone": "",
                "identityzoneid": "",
                "sburl": "",
                "serviceInstanceId": "",
                "subaccountid": "",
                "tenantid": "",
                "tenantmode": "",
                "uaadomain": "",
                "url": "",
                "verificationkey": "",
                "xsappname": "",
                "zoneid": ""
             }
          }
       ]
    }
    ```

7) Convert the json into a single line. You can use 

8) Create a **.env** file under app/router

9) Fill the **.env** file with the context below. The value of the VCAP_SERVICES should be the single line JSON that you converted in the step 7.

    ```txt
    MOCK_DIR=["../cap-ui5-simple-fullstack-ui"]
    MOCK_LOOKUP_DIRS=["dist"]
    MOCK_PORT=1300
    PORT=1299
    DYNAMIC_IDENTITY_PROVIDER=true
    destinations=[{"name":"backend-api","url":"http://localhost:4004","forwardAuthToken":true},{"name":"ui5","url":"https://ui5.sap.com"}]
    VCAP_SERVICES={"xsuaa":[{"instance_guid":"","instance_name":"cap-ui5-simple-fullstack-auth","name":"cap-ui5-simple-fullstack-auth","label":"xsuaa","plan":"application","tags":["xsuaa"],"credentials":{"apiurl":"","clientid":"","clientsecret":"","credential-type":"","identityzone":"","identityzoneid":"","sburl":"","serviceInstanceId":"","subaccountid":"","tenantid":"","tenantmode":"","uaadomain":"","url":"","verificationkey":"","xsappname":"","zoneid":""}}]}
    ```

10) Build and deploy the entities with the following command:

    ```sh
    cds deploy --to hana:cap-ui5-simple-fullstack-db
    ```

11) Run the CAP server with the following command in the root directory

    ```sh
    cds-ts w --profile hybrid
    ```

12) To run the SAPUI5 app, change the directory and run the following command:

    ```sh
    cd app/router
    npm run start-local
    ```

## Deploy Application Cloud Foundry

1) Run the following command in the root directory to build the app

    ```sh
    mbt build --mtar app.mtar
    ```

2) Deploy the application to the cloud foundry environment with the following command:

    ```sh
    cf deploy mta_archives/app.mtar -f
    ```